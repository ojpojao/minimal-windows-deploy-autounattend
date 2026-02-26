# 🖥️ Instalação Mínima Automatizada do Windows 10

Este projeto automatiza a instalação do Windows 10 utilizando **Ventoy + autounattend.xml**, ignorando a fase OOBE e preparando o sistema para o primeiro uso.

O objetivo é acelerar instalações limpas e padronizar o processo de deploy.

---

# 📦 Visão Geral

O fluxo automatizado realiza:

- Instalação unattended do Windows 10
- Bypass do OOBE
- Criação automática de conta local
- Execução de script PowerShell pós-instalação
- Sistema final pronto para login

---

# 📁 Estrutura do Projeto
/
├── .gitignore
├── ISO
│   └── .gitkeep
├── README.md
└── ventoy
    ├── autounattend_files
    │   └── autounattend_win10.xml
    ├── scripts
    │   └── setup_win10.ps1
    └── ventoy.json


---

# 🔧 Setup do Ambiente

## 1️⃣ Baixar o Ventoy

Baixe a versão mais recente do Ventoy no repositório oficial:

https://github.com/ventoy/Ventoy

---

## 2️⃣ Instalar o Ventoy no Pendrive

⚠️ Atenção: Isso apagará o conteúdo do pendrive.

### Windows

1. Extraia o arquivo baixado
2. Execute `Ventoy2Disk.exe`
3. Selecione o pendrive
4. Clique em **Install**

### Linux

```bash
sudo sh Ventoy2Disk.sh -i /dev/sdX
```

(Substitua /dev/sdX pelo dispositivo correto)



## 3️⃣ Clonar o Projeto

```bash
git clone https://github.com/ojpojao/windows-autodeploy-kit.git
```

Ou baixe como ZIP.

## 4️⃣ Copiar Arquivos para o Pendrive

Copie para a raiz do pendrive:

Pasta ISO/

Pasta ventoy/

# ⚙️ Configuração do ventoy.json

Exemplo básico:
```json

{
  "control": [
    { "VTOY_DEFAULT_MENU_MODE": "0" }
  ],
  "auto_install": [
    {
      "image": "/ISO/Win10_22H2_x64.iso",
      "template": "/ventoy/autounattend_files/autounattend_win10.xml"
    }
  ]
}
```

---

# 🚀 Fluxo de Instalação

Inserir pendrive

Boot via USB

Selecionar ISO do Windows

Ventoy injeta o autounattend.xml

Windows instala automaticamente

Script PowerShell executa no FirstLogon

Sistema finaliza pronto para login

---

# 📝 Requisitos

- ISO oficial do Windows 10

- Pendrive 8GB+

- Ventoy instalado

---

# 🧠 Objetivo do Projeto

Este projeto nasceu com foco em:

- Automatizar instalações repetitivas

- Padronizar ambientes

- Reduzir tempo operacional

- Servir como base para evolução futura

---

# 📦 Versionamento
v1.0.0

- Versão inicial funcional:

- Instalação unattended

- OOBE ignorado

- Script pós-instalação executando corretamente

---

# 👨‍💻 Autor

Nome: ojpojao
LinkedIn / GitHub: https://linkedin.com/in/ojpojao / https://github.com/ojpojao
