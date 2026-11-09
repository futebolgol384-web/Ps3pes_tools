# PS3 FPS Tools

Homebrew simples para PlayStation 3 focado em **ajuda para liberar FPS** nos jogos.

> **Importante:** Este app ainda e uma base. O desbloqueio real de FPS depende de patches da comunidade (Artemis / webMAN MOD / PS3MAPI). Este repositorio serve para gerar um PKG instalavel e evoluir o projeto.

## O que este projeto faz

- Gera um homebrew em formato `.pkg` para instalar no PS3 (CFW ou HEN)
- Serve de base para um app de ferramentas de FPS
- Compila automaticamente pelo GitHub Actions

## Requisitos no PS3

- Custom Firmware (Evilnat, Rebug, etc.) **ou** PS3HEN
- webMAN MOD (recomendado)
- Artemis PS3 (para aplicar cheats/patches de FPS)

## Como baixar o PKG

1. Va em **Actions** neste repositorio
2. Abra o ultimo workflow que rodou com sucesso
3. Baixe o artifact `ps3-pkg`
4. Coloque o `.pkg` num pen drive (FAT32)
5. No PS3: **Gerenciador de Pacotes** → Instalar pacote

## Como funciona o unlock de FPS de verdade

A maioria dos jogos de PS3 tem limite de 30 FPS no codigo. Para liberar:

| Metodo | O que precisa |
|--------|---------------|
| **Artemis + .ncl** | Arquivos de cheat da comunidade |
| **PS3MAPI (webMAN)** | Escrever na memoria enquanto o jogo roda |
| **EBOOT pre-patchado** | Versao do jogo ja modificada |
| **PSUF** | App mais completo da comunidade |

### Repositorios uteis de patches

- [DoSpamu/RPCS3toArtemisPatches](https://github.com/DoSpamu/RPCS3toArtemisPatches) – milhares de patches convertidos
- [RafJaeger/psuf-ps3](https://github.com/RafJaeger/psuf-ps3) – app PSUF (fonte aberta)
- Threads no [PSX-Place](https://www.psx-place.com/)

## Compilar localmente (opcional)

Voce precisa do ambiente **PS3DEV / PSL1GHT**:

```bash
export PS3DEV=/usr/local/ps3dev
export PSL1GHT=/usr/local/ps3dev
export PATH=$PS3DEV/bin:$PS3DEV/ppu/bin:$PATH

make pkg
```

O arquivo gerado sera algo como `ps3tools.pkg`.

## Estrutura do projeto

```
Ps3pes_tools/
├── source/main.c          # Codigo do app
├── Makefile               # Build PSL1GHT
├── .github/workflows/     # Build automatico no GitHub
└── README.md
```

## Aviso

- Use apenas em jogos que voce possui legalmente
- Patches de FPS podem causar instabilidade, tela preta ou aquecimento maior
- Nao use online (risco de ban)

## Licenca

Projeto livre para estudo e uso pessoal.
