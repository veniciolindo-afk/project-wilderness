# AGENTS.md — regras obrigatórias do Codex

- Idioma principal: português do Brasil. Respostas curtas, checkpoints claros.
- Projeto `Project Wilderness` para Project Zomboid **Build 42**, single-player, Windows.
- Prioridade: criar e testar código, não só design. Investigue a instalação real antes de assumir APIs/IDs.
- Preservar saves e arquivos oficiais: **nunca editar** `steamapps/common/ProjectZomboid` diretamente, nunca apagar saves; backup antes de substituir o mod local.
- Pasta-mestre do projeto: `Contents/mods/ProjectWilderness/42/`; use `common/` somente para compartilhados.
- Não habilitar God Mode, construção gratuita, recursos infinitos, alteração de consumo de materiais, cheat de peso ou imortalidade.
- `setKnowAllRecipes(true)` é sobre conhecimento, NÃO é liberar ingredientes; prove no jogo.
- Personagem criado com mochila: preservar mochila escolhida, não dar segunda mochila. Kit entregue só uma vez por personagem e salvo em ModData.
- Não duplicar receitas do vanilla/mods se já houver craft sustentável.
- Garantia de sobrevivência fora da civilização = ciclo renovável de comida, água, fogo, proteção, ferramentas, caça/pesca e reposição de equipamentos. Materiais sempre consumidos.
- IDs de itens devem ser lidos dos scripts reais de Build 42 e Workshop e registrados em relatório.
- Sem copiar código/meshes/sprites de jogos, Steam Workshop ou repositórios sem conferir licença. Preferir dependência ativada pelo jogador.
- Configs de Sandbox: gerar dos presets da instalação, nunca adivinhar enums.
- Evitar mapas com propriedades/ruas urbanas residuais; testar WorldGen em build do usuário e spawn seguro perto da água.
- Se rodar com Debug, nunca deixar Debug=true como requisito final.
- Todo teste deve ter resultado explícito PASS/FAIL/SKIP com log; não alegar que testou in-game sem o jogo aberto.
- Não publicar/mudar repositórios remotos sem aprovação; se usar Git, branch `feature/project-wilderness-v1`.
