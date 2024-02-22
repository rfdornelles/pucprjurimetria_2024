# juntar andamentos com os processos

tabela_reintegracao <- dados_reintegracao |>
  left_join(movimentos_reintegracao)

dados_cnj <- datajud_ler_processo(datajud_resposta)
andamentos_cnj <- datajud_ler_movimentacoes(datajud_resposta)

tabela_cnj <- dados_cnj |>
  left_join(andamentos_cnj)

# queremos saber quais deles foram sentenciados
tabela_reintegracao

library(dplyr)
library(stringr)

# Lista de expressões relacionadas a decisões finais
expressoes_decisoes_finais <- c("sentença", "improvido", "provido", "julgamento")

# Construção da regex
regex_decisoes_finais <- paste(expressoes_decisoes_finais, collapse = "|")

# Filtragem dos processos que possuem movimentação de decisão final
processos_decisao_final <- tabela_cnj %>%
  filter(str_detect(nome_movimento, regex(regex_decisoes_finais, ignore_case = TRUE)))

# Exibir os números dos processos com decisão final
print(processos_decisao_final$numero_processo |> unique())

library(dplyr)

# Supondo que sua tabela seja chamada de 'dados'
# Calcula o tempo entre a data de ajuizamento e o movimento mais recente para cada processo
dados <- tabela_reintegracao %>%
  group_by(numero_processo) %>%
  mutate(tempo_desde_ajuizamento_ate_movimento_mais_recente = max(data_atualizacao) - min(data_ajuizamento)) %>%
  ungroup()


# Exibe os resultados
print(dados)

library(ggplot2)

# Supondo que sua tabela seja chamada de 'dados'
# Calcula o tempo entre a data de ajuizamento e o movimento mais recente para cada processo
dados <- tabela_reintegracao %>%
  group_by(numero_processo) %>%
  mutate(tempo_desde_ajuizamento_ate_movimento_mais_recente = as.numeric(difftime(max(data_atualizacao), min(data_ajuizamento), units = "days"))) %>%
  ungroup()

# Cria o gráfico
ggplot(dados, aes(x = numero_processo, y = tempo_desde_ajuizamento_ate_movimento_mais_recente)) +
  geom_point() +
  geom_boxplot() +
  labs(x = "Número do Processo", y = "Tempo (dias)",
       title = "Intervalo de tempo entre a data de ajuizamento e o movimento mais recente de cada processo")


library(dplyr)

# Supondo que sua tabela seja chamada de 'dados'
# Converte as datas para formato de mês/ano
dados <- tabela_reintegracao %>%
  mutate(mes_ano_ultima_movimentacao = format(data_atualizacao, "%Y-%m")) %>%
  distinct(numero_processo, .keep_all = TRUE) # Mantém apenas uma entrada por processo

# Agrupa os dados por mês/ano da última movimentação e conta o número de processos
contagem_por_mes_ano <- dados %>%
  group_by(mes_ano_ultima_movimentacao) %>%
  summarise(total_processos = n())

# Exibe os resultados
print(contagem_por_mes_ano)
