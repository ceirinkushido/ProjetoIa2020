;;; Tabuleiros iniciais
(defun initial-board-short ()
  "Funcao que representa um tabuleiro de teste com as iniciais de cada palavra"
  '(
    (
     (0 0 0 0) (0 0 0 0)(0 0 0 0) (0 0 0 0)
     )
    (
     (b r a o)
     (p r a o)
     (b r b o)
     (b r a c)
     (p r b o)
     (b q a o)
     (p q a o)
     (b q b o)
     (p q b o)
     (b r a c)
     (p r a c)
     (b r b c)
     (p r b c)
     (b q a c)
     (p q a c)
     (b q b c)
     (p q b c)
     )))

(defun initial-board ()
  "Funcao que representa um tabuleiro de teste"
  '(
    (
     (0 0 0 0) (0 0 0 0) (0 0 0 0) (0 0 0 0)
     )
    (
     (branca redonda alta oca)
     (preta redonda alta oca)
     (branca redonda baixa oca)
     (preta redonda baixa oca)
     (branca quadrada alta oca)
     (preta quadrada alta oca)
     (branca quadrada baixa oca)
     (preta quadrada baixa oca)
     (branca redonda alta cheia)
     (preta redonda alta cheia)
     (branca redonda baixa cheia)
     (preta redonda baixa cheia)
     (branca quadrada alta cheia)
     (preta quadrada alta cheia)
     (branca quadrada baixa cheia)
     (preta quadrada baixa cheia)
     )))

;; =========="Poor quality" Code AKA Globals==========
(setq node-list (make-hash-table))

;; ==========BROARD POSITION FUNCTIONS==========

(defun tabuleiro (table)
  "Funcao que recebe uma lista que contem um tabuleiro com reservas de pecas e devolve o tabuleiro"
  (car table))

(defun reserva (table)
  "Funcao que recebe uma lista que contem um tabuleiro com reservas de pecas e devolve a reserva de pecas."
  (cadr table))

(defun linha (index table)
  "Funcao que recebe um indice e o tabuleiro e retorna uma lista que representa essa linha do tabuleiro."
  (cond
   ((= index 0) (car table))
   (t (linha (1- index) (cdr table)))))

(defun coluna (index table)
  "Funcao que recebe um indice e o tabuleiro e retorna uma lista que representa essa coluna do tabuleiro"
  (cond
   ((null table) nil)
   (t (cons (linha index (car table)) (coluna index (cdr table)))) ))

(defun celula (x y table)
  "Funcaoo que recebe dois indices (linha e coluna) e o tabuleiro e retorna o valor presente nessa celula do tabuleiro"
  (nth y (nth x table)))

;;; (diagonal-1 (tabuleiro (teste))) -> ((branca redonda alta oca) (preta redonda alta oca) (branca redonda baixa oca) 0)
(defun diagonal-1(table)
  "Funcao que recebe um tabuleiro e retorna uma lista que representa uma diagonal desse tabuleiro."
  (if (null table) '()
  (cons (caar table) (diagonal-1 (mapcar #'cdr (cdr table))))))

;;; (diagonal-2 (tabuleiro (teste))) -> (0 0 0 0)
(defun diagonal-2(table)
  "Funcao que recebe um tabuleiro e retorna uma lista que representa uma diagonal desse tabuleiro."
  (diagonal-1 (reverse table)))


;; ==========BOARD OPERATION FUNCTIONS==========

;;; (casa-vaziap 0 1 (tabuleiro (teste))) -> T
;;; (casa-vaziap 0 0 (tabuleiro (teste))) -> NIL
(defun casa-vaziap (line col table)
  "Funcao que recebe dois indices (linha e coluna) e o tabuleiro e devolve T se a casa estiver vazia e NIL caso contrario."
  (cond 
   ((atom (celula line col table)) T )
   (NIL)))

(defun remover-peca (piece reserved-pieces)
  "Funcao que recebe uma peca e uma lista com as pecas de reserva e devolve uma nova lista sem essa peca"
  (cond
   ((null reserved-pieces) NIL)
   ((equal piece (car reserved-pieces))
    (remover-peca piece (cdr reserved-pieces)))
   (T (cons (car reserved-pieces) (remover-peca piece (cdr reserved-pieces))))))

(defun substituir-posicao (index piece line)
  "Funcao que recebe um indice, uma peca e uma linha do tabuleiro. Substitui a peca na posicao indicada."
  (cond
   ((null line) nil)
   ((= index -1) (append (cons (car line) nil) (substituir-posicao index piece (cdr line))))
   ((= index 0) (append (cons piece nil) (substituir-posicao (1- index) piece (cdr line))))
   (t (append (cons (car line) nil) (substituir-posicao (1- index) piece (cdr line)))) ))

(defun substituir (line col piece table)
  "Funcao que retorna o tabuleiro com a celula substituida pelo valor pretendido. "
  (cond ((null table) nil)
        ((= line 0) (cons (substituir-posicao col piece (car table)) 
                          (substituir (1- line) col piece (cdr table))))
        (t (cons (car table) (substituir (1- line) col piece (cdr table))))))


(defun verifica-propriedades (lista-pecas &optional (index 0))
  "Funcao que recebe um tabuleiro e verifica se existem 4 propriedades iguais nas pecas."
  (cond 
   ((and (< index 3) (comparar-linha-coluna(linha index lista-pecas)) (comparar-linha-coluna(coluna index lista-pecas)))
    (verifica-propriedades lista-pecas (+ 1 index))) 
   ((or (not(comparar-linha-coluna (linha index lista-pecas) )) (not(comparar-linha-coluna (coluna index lista-pecas)))
        (not(comparar-linha-coluna (diagonal-1 lista-pecas)))  (not(comparar-linha-coluna (diagonal-2 lista-pecas))))  
    T)
   (nil)))

(defun comparar-linha-coluna (linha)
  "Funcao que testa todas as pecas diferentes de 0 e qualquer combinacao das 4 propriedadades iguais "
  (cond (
         (and
          (not(equal 0 (car linha))) (not(equal 0 (cadr linha))) (not(equal 0 (caddr linha))) (not(equal 0 (cadddr linha))) 
          (or (and
               (equal (car (first linha)) (car (second linha))) (equal (car (second linha)) (car (third linha))) 
               (equal (car (third linha)) (car (fourth linha))) )  
              (AND
               (equal (cadr (first linha)) (cadr (second linha))) (equal (cadr (second linha)) (cadr (third linha))) 
               (equal (cadr (third linha)) (cadr (fourth linha))) ) 
              (AND
               (equal (caddr (first linha)) (caddr (second linha))) (equal (caddr (second linha)) (caddr (third linha))) 
               (equal (caddr (third linha)) (caddr (fourth linha))) ) 
              (AND
               (equal (cadddr (first linha)) (cadddr (second linha)))
               (equal (cadddr (second linha)) (cadddr (third linha)))
               (equal (cadddr (third linha)) (cadddr (fourth linha))) )) ) nil)
        (t)))

;;; =================================================OPERADORES===========================================
(defun operador (line col piece table)
  "Funcao recebe uma linha, coluna, peca e tabuleiro. Devolve um novo estado"
  (cond
   ( (AND (casa-vaziap line col (tabuleiro table)) (find-piece piece (reserva table)) )
     (list (substituir line col piece (tabuleiro table)) (remover-peca piece (reserva table)) ))
     (t nil)))

(defun human-move (move state)
  "Funcao adicional que trata de realizar a jogada do humano"
  (operador  (convert-to-internal-col (car move)) (- (cadr move) 1) (caddr move) state) )

(defun run-operator (state piece &optional (line 0) (col 0) (depth 0) )
  "Funcao que opera sobre o tabuleiro e tenta jogar a peca no em todas as posicoes do tabuleiro "
  (cond 
   ((and (< col 4) (operador line col piece state) )
    (append
     (list (cria-no (operador line col piece state) (+ 1 depth) state) )
          (run-operator state piece line (+ col 1) depth)))
   ((< col 4) (run-operator state piece line (+ col 1) depth))
   ((and (< line 3)) (run-operator state piece (+ line 1) 0 depth))
   (t nil) ))

;; ==========INTERNAL AUXILIARY FUNCTIONS==========
(defun convert-to-internal-col (col)
  "Converts the human sintax for internal use"
  (- (char-int (char (symbol-name col) 0) ) 65))

(defun validate-sintax (move)
 "Validates the human move sintax"
   (cond
    ( (AND (symbolp (car move)) (numberp (cadr move)) )
      t)
    (t (format t"result:~a" (caddr move) ) nil )) )

(defun find-piece (piece reserved-pieces)
  "Verifies weather the piece exists in the reserve"
  (cond
   ((null reserved-pieces) NIL)
   ((equal piece (car reserved-pieces)) T)
   (T (find-piece piece (cdr reserved-pieces)))))

;; ==========Problem Domain Specific Alfa Beta Functions==========
(declaim (ftype function terminal-node-p heuristic-value children))
;; node = <depth> <current-board> <parent-board>

(defun terminal-node-p (node)
  "Verifies weather the node is a leaf node"
  (cond
   ( (verifica-propriedades (cadr node)) t)
   (t nil)))

(defun heuristic-value (node)
  "Returns the heuristic value for the node"
  (+ (car node) (+ (line-val (linha (cadr node))) (+col-val (coluna (cadr node)) (+diagonals-val (cadr node)) ))))

(defun children (node)
  "returns all possible children of the current node"
  ;;(mapcar #'lamda))
  (setf (gethash 'AAA node-list) '(Node 1))
  (setf (gethash '02 node-list) '(Node 2)) 
  (setf (gethash '003 node-list) '(Node 3)) 

  (remhash 'AAA node-list)
  (maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) node-list)
)

(defun line-val (line)
  (cond
   ( (nil line) nil)
   (t nil)))


;;; =============================================Metodos seletores=========================================
(defun cria-no (novo-no &optional (depth 0) (pai nil))
  "cria um novo no"
  (list depth novo-no pai))

(defun no-estado (no)
  "no-estado devolve o estado de um no"
  (cadr no))

(defun no-pai (no)
  "no-estado devolve o estado do pai de um no"
  (caddr no))

(defun nivel-no (no)
  "Funcao devolve o nível de um no"
  (car no))

(defun no-existep (no lista algoritmo)
  "Funcao que verifica se o no existe numa lista"
  (cond
   ((null lista) NIL)
   ((equal (no-estado (car lista)) (no-estado no)) T)
   (T (no-existep no (cdr lista) algoritmo))))