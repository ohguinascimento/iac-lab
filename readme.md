# 🚀 Windows Full-Stack Infrastructure-as-Code (IaC) Lab

Este repositório é o **Orquestrador Mestre** de um framework completo de infraestrutura automatizada. Utilizando o conceito de **Modularidade**, este projeto provisiona um ambiente corporativo resiliente, integrando Identidade, Alta Disponibilidade, Governança de Updates e Storage Híbrido.

## 🏗️ Arquitetura do Ecossistema
Este lab automatiza o ciclo de vida completo da infraestrutura, dividindo-se em quatro pilares fundamentais:

1.  **[Identity (AdDS)](https://github.com/ohguinascimento/AdDS):** Fundação da floresta Active Directory com replicação entre Domain Controllers.
2.  **[High Availability (Hyper-V)](https://github.com/ohguinascimento/hyperv):** Configuração de hosts e criação de Clusters de Failover com validações proativas.
3.  **[Governance (WSUS)](https://github.com/ohguinascimento/wsus):** Gestão centralizada de atualizações e automação de políticas de grupo (GPO).
4.  **[Linux Storage (iSCSI)](https://github.com/ohguinascimento/linux-storage):** Provisionamento de Shared Storage utilizando alvos iSCSI em Linux com LVM.

---

## 📊 Diagrama de Arquitetura

```text
                                 ___________________________
                                |       REDES / DNS         |
                                |___________________________|
                                              |
       _______________________________________|_______________________________________
      |                                       |                                       |
 [ LINUX STORAGE ]                     [ ACTIVE DIRECTORY ]                    [ HYPER-V CLUSTER ]
  (iSCSI Target)                       (Identidade/DNS)                        (Virtualização)
 +---------------+              +-----------------------------+              +-----------------------+
 |  LUN 01 (CSV) | <---iSCSI--- | DC-01 (Principal)           | <---Auth--- | NODE-01 (Hypervisor)  |
 |  LVM / Target |              | [AD DS, DNS, GPO]           |             | [Cluster Service]     |
 |  Ubuntu/Rocky |              +-----------------------------+              +-----------------------+
 +---------------+                             |                             +-----------------------+
                                   (Replicação de NTDS)                      | NODE-02 (Hypervisor)  |
                               +-----------------------------+               | [Cluster Service]     |
                               | DC-02 (Réplica)             | <---Auth--- +-----------------------+
                               | [AD DS, DNS]                |                        |
                               +-----------------------------+               [ SERVIÇO WSUS ]
                                                                             (Patch Management)
