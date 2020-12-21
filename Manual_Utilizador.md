# Manual de Utilizador

## Inteligencia artificial 2020/2021

### Realizado por: André Espinho e Fábio Pinhal

#### Projeto Nº 1: Época Normal

<div style="page-break-after: always"></div>

## Acrónimos e Convenções usadas

1. Explicação das convenções:
    * abreviaturas comuns

        ```md
            (por exemplo, parasoftware, comandos digitados são fontes
            monoespaçadas, nomesdos botões utilizados, ...)
        ```

## Introdução

1. Para quem é , para que serve? Que problemas resolve?
    * Este documente refere à implementação feita para resolução dop projeto
     "jogo dos 4" atravéz da linguagem lisp e dos algoritmos dados
2. Descrição dos requisitos do programa
    * implemtação dos algoritmos BFS, DFS e A*
    * separação do dominio do problema e do dominion dos algoritmos
    * implementação de input/output atravéz de consola e ficheiros

## Instalação e utilização

1. Instalação
    * efetuar o download da pasta
    * colocala no desktop
    * correr atravéz do ide LispWorks
2. Lista de comandos

    ```md
    Number -> Numero (0-7) problemas que o utilizador vai poder escolher para ser
    visto a resolução no ecran.
    
    Algorithm -> Algoritmos(BFS,DFS,*A) que vão ser escolhidos pelo utilizador 
    para que seja feito sobre o tabuleiro problemático que o utilizador escolheu.
    ```

## Input/Output

1. Informação que o programa recebe
    * Interativamente

    ```md
    O programa através do utilizador recebe:
    • Number -> Numero do problema 
    • Algorithm -> Nome do algoritmo a correr

    Exemplo: (load-problem 1 'bfs) 1 = Number
    'bfs = Algorithm
    ```

    * Por ficheiros

    ```md
    Recebe o puzzle a correr com os seguintes formatos:
    • Forma curta do puzzle
    ((((b q a o) (p q b c) 0 (p q a o)) ((b r a o) (p r a o) (b r a c) 0) (0 
    (p r a c) (p r b c) 0) ((b r b o) (b q a c) (p r b o) (b q b c)))
    ((p q a c)
    (p q b o)
    (b r b c)
    (b q b o)
    ))
    
    • Forma original do puzzle
    ((((branca quadrada alta oca) (preta quadrada baixa cheia) 0 (preta quadrada
    alta oca)) ((branca redonda alta oca) (preta redonda alta oca) (branca redonda
     alta cheia) 0) (0 (preta redonda alta cheia) (preta redonda baixa cheia) 0)
     ((branca redonda baixa oca) (branca quadrada alta cheia) (preta redonda 
     baixa oca) (branca quadrada baixa cheia)))
    ((preta quadrada alta cheia)
    (preta quadrada baixa oca)
    (branca redonda baixa cheia)
    (branca quadrada baixa oca)
    ))
    ```

2. informação produzida
    * écran

    ```md
    Após correr um dos algoritmos será mostrado ao utilizador a informação com 
    o seguinte formato:
     Tempo de execução: <tempo_de_exec>
     Profundidade: <profundidade>
     Nos espandidos: <nos_espandidos>
     Nos gerados: <nos_gerados>
     No final: <no_final>
      Tabuleiro:
      <linha1>
      <linha2>
      <linha3>
      <linha4>
      Reserva :
      <peca1>
      <peca2>
      <peca3>
      
    Por exemplo se correr o comando (load-problem 1 'bfs):  
    Tempo de exec: 0 ms 
    Profundidade: 1
    Nos espandidos: 1
    Nos gerados: 16
    No Final
     Tabuleiro:
     ((B Q A O) (P Q B C) (P Q A C) (P Q A O))
     ((B R A O) (P R A O) (B R A C) 0)
     (0 (P R A C) (P R B C) 0)
     ((B R B O) (B Q A C) (P R B O) (B Q B C))
     Reserva:
     (P Q B O)
     (B R B C)
     (B Q B O)
    NIL
    ```

    * ficheiros

    ```md
    Após correr um dos algoritmos é corrido num ficheiro e a informação estará 
    com o seguinte formato:
     Tempo de execução: <tempo_de_exec>
     Profundidade: <profundidade>
     Nos espandidos: <nos_espandidos>
     Nos gerados: <nos_gerados>
     No final: <no_final>
      Tabuleiro:
      <linha1>
      <linha2>
      <linha3>
      <linha4>
      Reserva :
      <peca1>
      <peca2>
      <peca3>
      
    Por exemplo se correr o comando (load-problem 1 'bfs):  
    Tempo de exec: 0 ms 
    Profundidade: 1
    Nos espandidos: 1
    Nos gerados: 16
    No Final
     Tabuleiro:
     ((B Q A O) (P Q B C) (P Q A C) (P Q A O))
     ((B R A O) (P R A O) (B R A C) 0)
     (0 (P R A C) (P R B C) 0)
     ((B R B O) (B Q A C) (P R B O) (B Q B C))
     Reserva:
     (P Q B O)
     (B R B C)
     (B Q B O)
    ```

## Exemplo de Utilização

1. Como efetuar a operação BFS  do problema 1

    ```md
    1. Abrir o lispworks.

    2. Abrir o ficheiro projeto.lisp a partir do opção open do lispworks.

    3. Selecionar a opção compile buffer 
    * O programa dá erro se os ficheiros não existirem ou se está na directoria incorrecta.
    
    4. Escrever no listener o (load-problem 1 'bfs) para correr o problema
    selecionado com o algorithmo selecionado.
    * O programa dá erro se o utilizador não escolher um dos
     problemas ou algoritmos disponiveis.
    * Caso esteja a utilizar uma versão gratuita do lispworks pode acontecer o 
    seguinte erro o "you are approaching the heap size limit for the Personal 
    Edition of LispWorks.
    If you choose to continue now you are advised to save your work
    at regular intervals.".

    5. Caso o programa tenha executado correctamente terá o seguinte resultado :
    Tempo de exec: 31 ms
    Profundidade: 2
    Nos espandidos: 26
    Nos gerados: 400
    No Final
    Tabuleiro:
    ((B Q A O) (P R B O) (P Q A O) (B Q A C))
    ((B R A O) (B R B O) (B R A C) (P R B C))
    ((P Q B C) (P R A C) (B Q B O) 0)
    ((P Q B O) 0 (B Q B C) 0)
    Reserva:
    (P R A O)
    (P Q A C)
    (B R B C)
    ```

2. Como efetuar a operação DFS do problema 6

    ```md
    1. Abrir o lispworks.

    2. Abrir o ficheiro projeto.lisp a partir do opção open do lispworks.

    3. Selecionar a opção compile buffer 
    * O programa dá erro se os ficheiros não existirem ou se está na directoria incorrecta.
    
    4. Escrever no listener o (load-problem 6 'dfs) para correr o problema
    selecionado com o algorithmo selecionado.
    * O programa dá erro se o utilizador não escolher um dos problemas
     ou algoritmos disponiveis.
    * Caso esteja a utilizar uma versão gratuita do lispworks pode acontecer o 
    seguinte erro o "you are approaching the heap size limit for the Personal 
    Edition of LispWorks.
    If you choose to continue now you are advised to save your work
    at regular intervals.".

    5. Caso o programa tenha executado correctamente terá o seguinte resultado:
    Tempo de exec: 47 ms
    Profundidade: 3
    Nos espandidos: 3
    Nos gerados: 675
    No Final
    Tabuleiro:
    ((B Q A C) (B Q A O) (B Q B O) 0)
    (0 0 0 0)
    (0 0 0 0)
    (0 0 0 0)
    Reserva:
    (B Q B C)
    (P Q A C)
    (P Q A O)
    (P Q B O)
    (P Q B C)
    (B R A C)
    (B R A O)
    (B R B C)
    (B R B O)
    (P R A C)
    (P R A O)
    (P R B C)
    (P R B O)
    ```
