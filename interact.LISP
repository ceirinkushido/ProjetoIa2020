 ;;; This File Loads required files and handles user interaction
(load "~/desktop/ProjetoIa2020/algoritmo.lisp") ;;::if-does-not-exist nil)
(load "~/desktop/ProjetoIa2020/jogo.lisp") ;;::if-does-not-exist nil)

;; Game Start Function
(defun start-play ()
  (create-clear-logs)
  (format t "Choose Gamemode~% 1: Human VS CPU~% 2: CPU VS CPU~% Gamemode: ")
  (let
      ( (game-mode (read)) )
    (cond
     ((AND (numberp game-mode) (OR (= game-mode 1) (= game-mode 2)))
         (gameplay-loop game-mode (first-move) (cpu-time-limit)))
     (t (format t "Incorrect Game mode. Try Again.") (start-play) ))))


;; ==========GAMEPLAY FUNCTIONS==========
;;;Funcao que efetua uma jogada (de jogador ou cpu)
(defun jogar (estado tempo)
  (cond
   ( (not (numberp tempo))
     (let 
         ( (move (read-from-string (concatenate 'string "(" (read-line) ")"))) )
       (cond 
        ( (AND (validate-sintax move) (human-move move estado) )
          (player-log (list move (no-estado estado)))
          (human-move move estado))
        (t (format t "Invalid move Try again.~%") 
           (print move)
           (print estado)
           (jogar estado tempo)) )))
   ( (<= tempo 0)
     ;; Verificar tempo restante apos algoritmo
     (format t "CPU Over.~% By: Time Out"))
   (t (format t "CPU continues ~A" estado))) )

;;Funcao que controla o fluxo de jogo
(defun gameplay-loop (game-mode current-player time-limit &optional (current-state (cria-no (initial-board-short))) )
  (cond
   ( (= game-mode 1)
     (format t "Game State:~{~% ~a~}~%Reserve:~{~% ~a~}~%"
             (tabuleiro current-state) (reserva current-state))
     (cond
      ( (AND (= current-player 1) (NOT (verifica-propriedades (tabuleiro current-state))) )
        (format t "Insert Player Move Format: Column[a to d] Line[1 to 4] (Piece)>~% Insert Move:")
        (gameplay-loop game-mode 1 time-limit (cria-no (jogar current-state nil))))

      ( (AND (= current-player 2) (NOT (verifica-propriedades (tabuleiro current-state))) )
        (gameplay-loop game-mode 1 time-limit (jogar current-state time-limit)))

      ( (= (length (cadr current-state)) 0)
        (format t "Game Over!~% Draw.~% Final Game State:~{~% ~a~}~% Reserve:~{~% ~a~}~%"
                (tabuleiro current-state) (reserva current-state)))

      (t (format t "Game Over!~% Player ~A Wins.~% Final Game State:~{~% ~a~}~% Reserve:~{~% ~a~}~%"
                 current-player (tabuleiro current-state) (reserva current-state) ))))
   (t
    (cond
     ( (AND (= current-player 1) (NOT (verifica-propriedades (tabuleiro current-state))) )
       (gameplay-loop game-mode 2 time-limit (jogar current-state time-limit)))

     ( (AND (= current-player 2) (NOT (verifica-propriedades (tabuleiro current-state))) )
       ;; Alterar Tempo Limite a cada Jogada?
       (gameplay-loop game-mode 1 time-limit (jogar current-state time-limit)))

     ( (= (length (reserva current-state)) 0)
       (format t "Game Over!~% Draw.~% Final Game State:~{~% ~a~}~% Reserve:~{~% ~a~}~%"
               (tabuleiro current-state) (reserva current-state)))

     (t (format t "Game Over!~% Player ~A Wins.~% Final Game State:~{~% ~a~}~% Reserve:~{~% ~a~}~%"
                current-player (car current-state) (reserva current-state)))) )))


;; ==========AUXILIARY FUNCTIONS [GAME SETUP]==========
(defun first-move ()
  (format t "Who goes first?~% Player: ")
  (let 
      ( (first-move (read)) )
    (cond
     (
      (AND (numberp first-move) (OR (= first-move 1) (= first-move 2)))
      first-move)
     (t (format t "Incorrect Player. Try Again.") (first-move) ))))

(defun cpu-time-limit ()
  (format t "CPU Time Limit [1000 - 5000]?~% Time: ")
  (let 
      ( (time-limit (read)) )
    (cond
     (
      (AND (numberp time-limit) (AND (>= time-limit 1000) (<= time-limit 5000)))
      time-limit)
     (t (format t "Incorrect Time. Try Again.~%") (cpu-time-limit)))))


;; ==========FILE I/O FUNCTIONS==========
;;Funcao que permite saltar até a linha indicada
(defun skip-line (file number)
  (cond 
   ( (> number 1) (read file nil :eof) (skip-line file (- number 1)))
   (t(read file nil :eof))))

;;Funcao que cria ou limpa os ficheiros de log
(defun create-clear-logs ()
  (with-open-file (str "~/desktop/ProjetoIa2020/log.dat"
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create) (format str "" ))
  (with-open-file (str "~/desktop/ProjetoIa2020/player-log.dat"
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create) (format str "" )) )

;;Funcao que escreve o log do jogador humano
(defun player-log (list)
  (with-open-file (str "~/desktop/ProjetoIa2020/player-log.dat"
                       :direction :output
                       :if-exists :append
                       :if-does-not-exist :create)
    (format str "Move: ~A~% Table:~{~% ~a~}~% Reserve:~{~% ~a~}~%"
            (car list) (car (cadr list)) (cadr(cadr list)) )) )