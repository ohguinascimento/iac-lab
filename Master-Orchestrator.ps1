<#
.SYNOPSIS
    Orquestrador de Infraestrutura Automatizada - Lab SRE.
.DESCRIPTION
    Este script realiza o download dos módulos de AD e Hyper-V diretamente do GitHub
    do autor e orquestra a execução das fases do laboratório.
.AUTHOR
    Guilherme (ohguinascimento)
#>

$WorkDir = "C:\Automation-Lab"
if (!(Test-Path $WorkDir)) { New-Item -Path $WorkDir -ItemType Directory }
Set-Location $WorkDir

Write-Host "--- 🚀 INICIANDO ORQUESTRADOR DE INFRAESTRUTURA ---" -ForegroundColor Cyan

# 1. Download/Update dos Módulos do GitHub
Function Update-Module {
    param([string]$RepoUrl, [string]$FolderName)
    
    $DestPath = Join-Path $WorkDir $FolderName
    if (Test-Path $DestPath) {
        Write-Host "[#] Atualizando módulo $FolderName..." -ForegroundColor Yellow
        # Se tiver Git instalado, usa o pull. Se não, deleta e baixa de novo (para lab)
        Remove-Item $DestPath -Recurse -Force
    }
    
    Write-Host "[+] Clonando repositório: $RepoUrl" -ForegroundColor Gray
    git clone $RepoUrl $FolderName
}

# Verificação de Git (Necessário para o fluxo profissional)
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git não encontrado! Instale o Git ou baixe os scripts manualmente."
    return
}

# Atualizar repositórios
Update-Module -RepoUrl "https://github.com/ohguinascimento/AdDS" -FolderName "ADDS"
Update-Module -RepoUrl "https://github.com/ohguinascimento/hyperv" -FolderName "HyperV"

# 2. Menu de Orquestração
do {
    Write-Host "`n--- SELECIONE A FASE DO DEPLOY ---" -ForegroundColor Magenta
    Write-Host "1. [ADDS] Instalar Role e Criar Nova Floresta (DC01)"
    Write-Host "2. [ADDS] Adicionar DC de Réplica (DC02)"
    Write-Host "3. [HyperV] Habilitar Hypervisor nos Nós"
    Write-Host "4. [HyperV] Criar Cluster de Alta Disponibilidade"
    Write-Host "Q. Sair"

    $Option = Read-Host "Opção"

    switch ($Option) {
        "1" { 
            & "$WorkDir\ADDS\01-Install-ADDS.ps1"
            & "$WorkDir\ADDS\02-Deploy-Forest.ps1" 
        }
        "2" { 
            & "$WorkDir\ADDS\03-Add-ReplicaDC.ps1" 
        }
        "3" { 
            & "$WorkDir\HyperV\Enable-HyperVPlatform.ps1" 
        }
        "4" { 
            & "$WorkDir\HyperV\New-HyperVFailoverCluster.ps1" 
        }
        "Q" { Write-Host "Saindo..."; break }
        Default { Write-Host "Opção inválida." -ForegroundColor Red }
    }
} while ($Option -ne "Q")
