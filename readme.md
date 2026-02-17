# 🚀 Windows Full-Stack Infrastructure-as-Code (IaC) Lab

Este repositório é o **Orquestrador Mestre** de um framework completo de infraestrutura automatizada. Ele utiliza o conceito de **Modularidade** para provisionar um ambiente Microsoft corporativo resiliente, integrando Identidade, Alta Disponibilidade e Governança de Updates.

## 📌 Arquitetura do Ecossistema
Este lab automatiza o ciclo de vida completo da infraestrutura, dividindo-se em três pilares fundamentais:

1.  **[Identity (AdDS)](https://github.com/ohguinascimento/AdDS):** Fundação da floresta Active Directory com replicação entre Domain Controllers.
2.  **[High Availability (Hyper-V)](https://github.com/ohguinascimento/hyperv):** Configuração de hosts e criação de Clusters de Failover com validações proativas de DNS.
3.  **[Governance (WSUS)](https://github.com/ohguinascimento/wsus):** Gestão centralizada de atualizações e automação de políticas de grupo (GPO).

---

## 🛠️ Módulos Integrados

### 🔹 Fase 1: Core & Resilience (Active Directory)
Implementa a base de autenticação. O diferencial deste módulo é a **Replicação Automática**, garantindo que o ambiente não possua pontos únicos de falha (SPOF).

### 🔹 Fase 2: Virtualization & SRE (Hyper-V Cluster)
Transforma servidores isolados em um Cluster de Failover. Focado em **Observabilidade**, o script realiza *pre-flight checks* para garantir a integridade do registro do Cluster no DNS/AD.

### 🔹 Fase 3: Compliance & Patching (WSUS) - *Novo*
O mais novo pilar do lab. Este módulo instala o **Windows Server Update Services** e provisiona automaticamente as **GPOs** de atualização. Isso garante que todos os servidores do lab (simulando um parque de 300+) estejam em conformidade com as últimas correções de segurança.

## 🔹 Fase 4: Shared Storage & Linux (Cross-Platform)
Módulo focado em interoperabilidade entre Windows e Linux.
* **Linux iSCSI Target:** Uso de **LVM** (Logical Volume Manager) para criação de **LUNs** em um servidor Linux.
* **Storage Networking:** Implementação de protocolo iSCSI para prover o *Shared Storage* necessário para o Quórum e CSV (Cluster Shared Volumes) do Hyper-V.
* **Multipath I/O (MPIO):** Preparado para configurações de alta redundância de caminhos de dados.

---

## 🚀 Como Executar o Deploy Completo

Utilize o `Master-Orchestrator.ps1` contido neste repositório para baixar e executar os módulos diretamente do GitHub:

```powershell
# Inicie o orquestrador como Administrador
.\Master-Orchestrator.ps1
