# PROJECT WILDERNESS — Build 42

**Status:** V1 dev corrigida para a instalação local 42.21.0. O núcleo foi validado
estaticamente; kit/skills/crafting/mapa ainda exigem teste em save novo.

## O que já está implementado (código incluso)
- Estrutura B42 (`Contents/mods/ProjectWilderness/42/`).
- Inicialização de personagem persistente e starter kit por categoria, evitando duplicações ao carregar o save.
- Tentativa de colocar todas as skills no máximo via API B42 e ativar `setKnowAllRecipes(true)`; não concede recursos de crafting.
- Starter kit com 30 IDs validados na 42.21.0, priorizando e preenchendo a mochila escolhida.
- Logs de erros/ausências por componente em `Zomboid/console.txt`.
- Uma receita B42 simples de gravetos com consumo de galho e desgaste da faca, a confirmar in-game.
- Preset-fonte auditável em `presets/ProjectWilderness.lua`, com valores exatos da 42.21.0.
- Instalador de PowerShell e checador local de recursos/arquivos do game.

## O que NÃO está implementado ou comprovado
- Mapa WorldGen isolado sem cidades, sistema automático de rios e spawn na água.
- Arco/flechas de mod (não sabemos os IDs locais). É integração condicionada à verificação dos arquivos instalados.
- Crafting completo de abrigos/roupas/cordas, caça avançada e armazenamento sazonal.
- Distribuição automática de traits/ajuste de fauna (faça inicialmente no menu sandbox; o Codex validará as APIs da sua instalação).
- Compatibilidade completa in-game; consulte `docs/RELATORIO_TESTES.md`.

## Iniciar AGORA no Windows
1. Extraia este ZIP numa pasta local, por exemplo `C:\Users\Venicio\Documents\ProjectWilderness`.
2. Abra **Codex** nessa pasta. Cole o conteúdo de `CODEX_PROMPT.txt`.
3. No PowerShell (na pasta extraída), execute `powershell -ExecutionPolicy Bypass -File .\tools\install.ps1`.
4. Inicie o Project Zomboid **Build 42**, entre em **Mods**, ative `Project Wilderness - V1 Dev` também na nova partida.
5. Abra um **novo save Sandbox**. Configure **Zumbis: Nenhum**, fauna alta, coleta/pesca abundante, dia de 2h, clima normal, começo em maio. Não marque God Mode ou crafting gratuito.
6. Verifique inventário e skills e procure `[Project Wilderness]` no `C:\Users\Venicio\Zomboid\console.txt`.
7. Se houver erros, peça ao Codex para ler `console.txt`, corrigir e reinstalar.

A instalação local **não edita** a pasta oficial do jogo. A instalação faz backup de uma cópia local anterior do mod, caso exista.

## Mods opcionais a instalar via Workshop
- Archery Nexus (arco/flechas): https://steamcommunity.com/sharedfiles/filedetails/?id=3617854007
- Wilderness Progression: Archery Nexus: https://steamcommunity.com/workshop/filedetails/?id=3776221203
- Wilderness Primitive Survival: https://steamcommunity.com/sharedfiles/filedetails/?id=3649911353
- Camp in the Rain: https://steamcommunity.com/sharedfiles/filedetails/?id=3429176285

**Não copie código/arquivos de terceiros automaticamente.** Inscreva-se nos mods e valide requisitos, ID e licença pelo Workshop. O mod não depende deles para ser reconhecido.

Consulte `docs/STATUS.md`, `docs/CONFIGURACAO.md`, `docs/MAPA.md`, `docs/IMPLEMENTACAO.md`.
