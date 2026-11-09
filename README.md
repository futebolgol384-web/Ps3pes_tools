# PS3 FPS Tools

Homebrew base para PlayStation 3 focado em **ferramentas de FPS**.

Repositorio: https://github.com/futebolgol384-web/Ps3pes_tools

## Status atual

- Codigo base criado
- Compila `ps3tools.elf` e `ps3tools.self` no GitHub Actions
- Empacotamento automatico de `.pkg` ainda com problema (toolchain antiga / Python)
- O desbloqueio real de FPS **ainda depende** de patches da comunidade

## O que este projeto e (e o que nao e)

**E:**
- Base de um homebrew PS3
- Projeto no seu GitHub para ir evoluindo
- Ponto de partida para aprender PSL1GHT

**Nao e (ainda):**
- Um unlocker universal que libera FPS em todos os jogos sozinho

Para FPS unlock de verdade hoje, use:

| Metodo | Onde |
|--------|------|
| Artemis + .ncl | [RPCS3toArtemisPatches](https://github.com/DoSpamu/RPCS3toArtemisPatches) |
| App PSUF | [psuf-ps3](https://github.com/RafJaeger/psuf-ps3) |
| PS3MAPI | webMAN MOD no navegador do PC |

## Como baixar o build

1. Abra **Actions** neste repo
2. Entre no workflow **Build PS3 PKG** que tiver concluido
3. Baixe o artifact `ps3-build`
4. Dentro tera `ps3tools.self` (e talvez `.elf`)

### Como usar o `.self` no PS3 (CFW/HEN)

Opcoes comuns:
- Converter para PKG com ferramenta no PC (ex.: tools da cena)
- Ou colocar como `EBOOT.BIN` em uma pasta de jogo homebrew via FTP/multiman

## Requisitos no console

- CFW (Evilnat, Rebug...) **ou** HEN
- webMAN MOD recomendado
- Artemis (para patches de memoria)

## Estrutura

```
source/main.c          # App (mostra info + sai com CIRCULO)
Makefile               # Build PSL1GHT
.github/workflows/     # Build automatico
README.md
```

## Proximos passos reais

1. Fazer o build gerar `.pkg` de forma confiavel
2. Adicionar interface grafica (Tiny3D)
3. Integrar lista de patches / PS3MAPI
4. Ou fazer fork do [PSUF](https://github.com/RafJaeger/psuf-ps3) e customizar

## Aviso

- Use so em jogos que voce possui
- Patch de FPS pode causar crash, tela preta ou mais calor
- Nao use online

Projeto livre para estudo e uso pessoal.
