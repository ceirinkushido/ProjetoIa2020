;;; Tabuleiros
(defun teste ()
"Função que representa um tabuleiro de teste"
  '(
		(
			((branca redonda alta oca) 0 0 0) 
			(0 (preta redonda alta oca) 0 0) 
			(0 0 (branca redonda baixa oca) 0) 
			(0 0 0 0)
		)
		(
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
		)
	)
)

;;; Função que recebe uma lista que contém um tabuleiro com reservas de peça e devolve o tabuleiro
(defun tabuleiro (table)
  (car table))

;;; Função que recebe uma lista que contém um tabuleiro com reservas de peça e devolve a reserva de peças.
(defun reserva (table)
  (cadr table))

;;; Função que recebe um índice e o tabuleiro e retorna uma lista que representa essa linha do tabuleiro.
(defun linha (index table)
  (nth index table))

;;; Função que recebe um índice e o tabuleiro e retorna uma lista que representa essa coluna do tabuleiro
(defun coluna (index table)
  (mapcar #'(lambda (subtable) (nth index subtable)) table))

;;; Função que recebe dois índices (linha e coluna) e o tabuleiro e retorna o valor presente nessa célula do tabuleiro.
(defun celula (x y table)
  (nth y (nth x table)))

;;; Função que recebe um tabuleiro e retorna uma lista que representa uma diagonal desse tabuleiro.
;;; (diagonal-1 (tabuleiro (teste))) -> ((branca redonda alta oca) (preta redonda alta oca) (branca redonda baixa oca) 0)
(defun diagonal-1(table)
  (if (null table) '()
  (cons (caar table) (diagonal-1 (mapcar #'cdr (cdr table))))))

;;; Função que recebe um tabuleiro e retorna uma lista que representa uma diagonal desse tabuleiro.
;;; (diagonal-2 (tabuleiro (teste))) -> (0 0 0 0)
(defun diagonal-2(table)
  (diagonal-1 (reverse table)))

;;; Função que recebe dois índices (linha e coluna) e o tabuleiro e devolve T se a casa estiver vazia e NIL caso contrário.
;;; O valor de uma casa vazia no Problema do Quatro é o valor 0.
;;; (casa-vaziap 0 1 (tabuleiro (teste))) -> T
;;; (casa-vaziap 0 0 (tabuleiro (teste))) -> NIL
(defun casa-vaziap (line col table)
  (cond 
   ((atom (celula line col table)) T )
   (NIL)))

;;; Função que recebe uma peça e uma lista com as peças de reserva e devolve uma nova lista sem essa peça de reserva
(defun remover-peca (piece reserved-pieces)
  (cond
   ((null reserved-pieces) NIL)
   ((equal piece (car reserved-pieces))
    (remover-peca piece (cdr reserved-pieces)))
   (T (cons (car reserved-pieces) (remover-peca piece (cdr reserved-pieces))))))

;;; Função que recebe um índice, uma peça e uma lista que representará uma linha do tabuleiro
;;;  e substitui pelo valor pretendido nessa posição.
(defun substituir-posicao (index piece line)
  (setf (nth index line) piece)
  line)

;;; Função que recebe dois índices (linha e coluna), uma peça e o tabuleiro.
;;; A função deverá retornar o tabuleiro com a célula substituída pelo valor pretendido. 
(defun substituir (line col piece table)
  (substituir-posicao col piece (nth line table))
  table)


;;; =================================================OPERADORES=====================================

;;; Função que recebe dois índices (linha e coluna), uma lista que representará uma peça e
;;;  o tabuleiro com reservas de peca e movimenta a peça para a célula correspondente, removendo-a da reserva de peças.
(defun operador (line col piece table)
  (cond
   ( (casa-vaziap line col (tabuleiro table))
     (setf table (list 
                  (substituir line col piece (tabuleiro table)) 
                  (remover-peca piece (reserva table))
                  ))table)
   NIL))