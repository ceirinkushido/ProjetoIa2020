;;; This File Loads required files and handles user interaction
(defun load-problems ()
  (with-open-file (stream "~/desktop/ENG_INF/Projetos/ProjetoIa2020/problemas.dat" )
    (let ((linha (read-line stream  nil :fim)))
    (cond ((not (eq linha :fim)) (copia-linha f1 f2))
                (t (close f2)))))
)


(defun salta-linha (f1)
  (let ((linha (read-line f1 nil :fim)))
    (cond ((not (eq linha :fim)) ) ) )
 )