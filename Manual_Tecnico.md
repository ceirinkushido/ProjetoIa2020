# Manual Técnico

## Inteligência artificial 2020/2021

### Realizado por: André Espinho e Fábio Pinhal

#### Projeto Nº 1: Época Normal

<hr/>

## Arquitetura do sistema

1. Módulo Puzzle
    * Contém o relacionado com o problema.
2. Modulo Projeto
    * Carrega os outros ficheiros de código, escreve e lê ficheiros, e trata
     da interação com o utilizador.
3. Modulo Procura
    * Deve de conter a implementação do BFS,DFS e *A.

## Entidades e sua implementação

1. TAD NO
    * Representa a ligação entre o estado atual do jogo e o anterior.
    * <Estado_atual_do_no, profundidade, Estado_do_no_anterior>  
2. Estado do jogo
    * Representa o tabuleiro e a reserva.
    * <Tabuleiro_Atual,Reserva_Atual>

## Algoritmos e sua implementação

1. Modulo Procura - Algoritmo BFS
    * Tem uma complexidade de (n*n)!
    * O algoritmo testa se:
        * A Lista de abertos está vazia
            * Se estiver retorna "END"
        * Se o no-incial está vazio
            * Corre o algoritmo do bfs novamente com os argumentos:
                * (list(cria-no open 0 0)) '() max-depth 0 0
        * Se a profundidade atual é igual ou superior á profundidade maxima definida
        ou se no atual é um nó final/solução.
            * Se for retorna uma lista com a profundidade do nó, o estado do nó atual
              , o numero de nós percorridos e numero de nós gerados.

## Descrição das opções tomadas

## Limitações técnicas e ideias para desenvolvimento futuro

1. Requisitos não implementados
    * Requisito Algoritmo A estrela e heuristica dada.
    * Implementação da nova heuristica.
2. Limitações tecnicas.
    * O algoritmo BFS não corre os problemas 4, 5 e 6 devido ao limite de memoria
      da versão gratuita do Lispworks.
3. Refactoring
    * Converter nomes de variaveis e funções para inglês.
