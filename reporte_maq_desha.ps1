﻿#*******Begin Comment**************
.SYNOPSIS
#	This script removes from AD all machines with more than 180 days without reporting.
#  Script for Report of machine with more 180 days not report to AD
# version V1
# Autor: Saith Barreto
# Fecha: Septiembre 2024
#*******End Comment**************
import-module activedirectory  
#$domain = "Domain.local"
$searchOU = "ou=OU,DC=Domain,DC=local"  
$DaysInactive = 180  
$time = (Get-Date).Adddays( - ($DaysInactive)) 
  
# pilla el lastlongon y lo contrasta 
Get-ADComputer -SearchBase $searchOU -Filter { LastLogonTimeStamp -lt $time } -Properties LastLogonTimeStamp | 
  
# mete los nombres de las maquinas en un csv.
select-object Name, @{Name = "Stamp"; Expression = { [DateTime]::FromFileTime($_.lastLogonTimestamp) } } | export-csv C:\temp\Maquinas_inactivas.csv
