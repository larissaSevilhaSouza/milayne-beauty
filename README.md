# Skeleton Rails Docker

## Instruções

#### Copie um exemplo de arquivo .env porque o arquivo real é ignorado pelo Git:

```sh
cp .env.example .env
```

#### Configurando o projeto:

```sh
./run setup

# Em outro terminal
./run rake db:setup db:seed
```

#### Verificando no navegador:

Acesse <http://localhost:3000>

#### Parando tudo:

```sh
# Para os contêiners e remove alguns recursos relacionados ao Docker associados a este projeto.
docker compose down
```

Você pode iniciar tudo novamente com docker `docker compose up`.

---

##### Extensão para o script de formatar o código

Baixe RunOnSave [clicando aqui](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave).

##### Alias para rodar todos com `run` comando sem precisar do `./run`

```sh
# Edite o terminal que estiver usando (exemplo usando zshrc)
sudo nano ~/.zshrc

# Adicione a linha
alias run="./run"

# Para funcionar sem precisar fechar e abrir o terminal
source ~/.zshrc
```
