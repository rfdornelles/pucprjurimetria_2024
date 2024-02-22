# instalacao do pacote
remotes::install_github("rfdornelles/datajud", force = TRUE)

library(datajud)
library(tidyverse)
# identificar
datajud_login("rodornelles@gmail.com")

# consultar processo
lista_cnj <- c(
 "0100973-12.2022.5.01.0010",
 "1099566-95.2020.8.26.0100",
 "1063525-08.2015.8.26.0100",
 "1108899-76.2017.8.26.0100"
)

datajud_consultar_processo(lista_cnj)

# ler resposta
dados <- datajud_ler_processo() |>
  distinct()

# andamentos
movimentos <- datajud_ler_movimentacoes()

# pesquisar por classe e orgao
datajud_pesquisar_classe_orgao(tribunal = "tjsp",
                               lista_classe = "1116",
                               size = 10)


datajud_ler_processo(datajud_resposta_5)
datajud_ler_movimentacoes(datajud_resposta_5)

datajud_pesquisar_classe_orgao(tribunal = "tjsc", lista_classe = "1707")

dados_reintegracao <- datajud_ler_processo(datajud_resposta_6)
movimentos_reintegracao <- datajud_ler_movimentacoes(datajud_resposta_6)


# ler tudo
