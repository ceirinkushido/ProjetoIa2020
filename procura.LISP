;;cria um novo no
(defun cria-no (novo-no &optional (g 0) (pai nil))
  (list novo-no g pai))

;;; =============================================Metodos seletores=========================================
;; no-estado devolve o estado de um no
(defun no-estado (no)
  (car no))

;;Funcao devolve o nível de um no
(defun nivel-no (no)
  (cadr no))

;;Funcao Verifica se o no existe numa lista
(defun no-existep (no lista algoritmo)
  (cond
   ((null lista) NIL)
   ((equal (no-estado (car lista)) (no-estado no)) T)
   (T (no-existep no (cdr lista) algoritmo))))

;;; =================================================OPERADORES===========================================
;;Funcao vai receber uma linha coluna a peca e tabuleiro e operar usando uma lista de operadores no tabuleiro
(defun operador (line col piece table)
  (cond
   ( (casa-vaziap line col (tabuleiro table))
     (list (substituir line col piece (tabuleiro table)) (remover-peca piece (reserva table)) ))
     (t nil)))

;;Funcao que gera os nos descentes da tabuleiro dado
(defun generate-descendants-bfs(state &optional (depth 0) )
  (apply #'append (mapcar #'(lambda (sublist) (run-operator state sublist 0 0 depth))(cadr state))))

;;Funcao que opera sobre o tabuleiro e tenta jogar a peca no tabuleiro 
(defun run-operator (state piece &optional (line 0) (col 0) (depth 0) )
  (cond 
   ((and (< col 4) (operador line col piece state) )
    (append
     (list (cria-no (operador line col piece state) (+ 1 depth) state) )
          (run-operator state piece line (+ col 1) depth)))
   ((< col 4) (run-operator state piece line (+ col 1) depth))
   ((and (< line 3)) (run-operator state piece (+ line 1) 0 depth))
   (t nil) ))

;;;BFS (Bread-First-Search) algorithm
(defun bfs (&optional (open '()) (closed '()) (max-depth 3) (initial nil) (counter 0))
  (cond ((null open) "END")
        ((null initial) (bfs (list (cria-no open 0 0) ) '() max-depth 0  0))
         (t (let ((state (car open)))
           (cond 
            ( (or (>= (nivel-no state) max-depth) (verifica-propriedades (tabuleiro (no-estado state))))
              (list (nivel-no state) (no-estado state) (/ (length closed) 3 ) (length open)))
            (t
             (bfs (append (cdr open) (generate-descendants-bfs (no-estado state) (nivel-no state)) )
                  (append state closed)  max-depth 0 (+ 1 counter))))))))

;;;DFS (Depth-First-Depth) algorithm
(defun dfs (&optional (open '()) (closed '()) (max-depth 3) (initial nil) (counter 0))
  (cond ((equal start goal) 
         (reverse (cons start been-list)))
        (t (try-moves start goal been-list moves moves))))