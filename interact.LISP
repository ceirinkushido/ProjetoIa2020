 ;;; This File Loads required files and handles user interaction
(load "~/desktop/ProjetoIa2020/algoritmo.lisp") ;;::if-does-not-exist nil)
(load "~/desktop/ProjetoIa2020/jogo.lisp") ;;::if-does-not-exist nil)


(defun start-play ()
  (format t "Choose Gamemode~% 1: Human VS CPU~% 2: CPU VS CPU~% Gamemode: ")
  (let
      ( (game-mode (read)) )
    (cond
     ((AND (numberp game-mode) (OR (= game-mode 1) (= game-mode 2)))
         (gameplay-loop game-mode (first-move) (cpu-time-limit)))
     (t (format t "Incorrect Game mode. Try Again.") (start-play) ))))


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
;;Funcao que carrega o ficheiro dos problemas e inicia o algorithm dado  
(defun load-problem (number algorithm)
  (let 
      ( (problem (with-open-file (stream "~/desktop/ProjetoIa2020/problemas-short.dat") (skip-line stream number)) ) ) 
    (cond
     ((equal problem :eof) "Eof: please check problem number")
     (t (run-algorithm problem algorithm)))))

;;Funcao que permite saltar até a linha indicada
(defun skip-line (file number)
  (cond 
   ( (> number 1) (read file nil :eof) (skip-line file (- number 1)))
   (t(read file nil :eof))))

;;Funcao que executa o algorithmo consoante a sua opcao.
(defun run-algorithm(table algorithm &optional (start-time (get-internal-run-time)))
  (cond
   ((equal algorithm 'bfs) (generate-output (append (bfs table) (list  (- (get-internal-run-time) start-time) ) ) ) )
   ((equal algorithm 'dfs) (generate-output (append (dfs table) (list  (- (get-internal-run-time) start-time) ) ) ) )
   ((equal algorithm 'a*) "a*")
   (t "Not the right algorithm")))

;;Funcao que retorna o output gerado pelo algoritmo usado e escreve no ficheiro
(defun generate-output(list)
  (format t "Tempo de exec: ~A ms~%Profundidade: ~A~%Nos espandidos: ~A~%Nos gerados: ~A~%No Final~% Tabuleiro:~{~% ~a~}~% Reserva:~{~% ~a~}"
          (car(cddddr list)) (car list) (caddr list) (cadddr list) (car(cadr list)) (cadr(cadr list)) ) 
  
  (with-open-file (str "~/desktop/ProjetoIa2020/results.txt"
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (format str "Tempo de exec: ~A ms~%Profundidade: ~A~%Nos espandidos: ~A~%Nos gerados: ~A~%No Final~% Tabuleiro:~{~% ~a~}~% Reserva:~{~% ~a~}"
            (car(cddddr list)) (car list) (caddr list) (cadddr list) (car(cadr list)) (cadr(cadr list))))
)
