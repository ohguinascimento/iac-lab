# 🚀 Windows Full-Stack Lab Automation (IaC)

Este repositório é um framework completo de **Infraestrutura como Código** para o provisionamento automatizado de um ambiente Microsoft corporativo resiliente. Ele orquestra desde a fundação do Active Directory até a alta disponibilidade com Clusters Hyper-V e gestão de patches com WSUS.

## 📌 Arquitetura do Laboratório
O objetivo é sair de servidores "Workgroup" para uma infraestrutura pronta para produção com:
* **Redundância de Domínio:** 2 Domain Controllers com replicação ativa.
* **Alta Disponibilidade (HA):** Cluster de Failover Hyper-V validado.
* **Governança:** Servidor WSUS centralizado com políticas de grupo (GPO) automatizadas.

---

## 🛠️ Módulos de Automação

### Fase 1: Core Identity (Active Directory)
Localizado em `/01-ActiveDirectory`, este módulo lida com a criação da floresta e a replicação do segundo DC para garantir que a identidade e o DNS nunca fiquem offline.

### Fase 2: Virtualização & HA (Hyper-V Cluster)
Localizado em `/02-HyperV-Cluster`, este módulo prepara os hosts e orquestra a criação do Cluster.
* **Destaque:** Inclui *Pre-flight checks* de DNS para garantir que o **Cluster Name Object (CNO)** seja registrado sem erros.

### Fase 3: Gestão de Ciclo de Vida (WSUS)
Localizado em `/03-Management-Services`, instala o WSUS e aplica GPOs via script para que todos os novos servidores do lab sejam reportados e atualizados automaticamente.

---

## 🚀 Como Iniciar o Lab

1. **Requisitos:** 2 VMs com Windows Server (IPs estáticos e comunicação de rede ativa).
2. **Orquestração:** Você pode executar os scripts individualmente ou usar o `Master-Orchestrator.ps1` para guiar o deploy.

```powershell
# Exemplo: Executando a fase de Cluster após o AD estar online
.\02-HyperV-Cluster\02-New-FailoverCluster.ps1 -ClusterName "LAB-CLUSTER" -Nodes "SRV-01","SRV-02" -StaticIP "10.0.0.50"
