;; to setup slime in emacs:
(load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "/usr/bin/sbcl")

;; external library setup.
(ql:quickload "CL-ppcre")

;; this was on its way to elegance, but the return format was just too clunky to format.
;; (defun rgb-search (string)
;;  (let ((matches))
;;    (cl-ppcre:do-register-groups (r g b) ("([0-9]*) red|([0-9]*) green|([0-9]*) blue" string) (push (list r g b) matches))
;;    matches )
;;  )

;; returns:
;;
;(NIL NIL "8")
;(NIL "7" NIL)
;("3" NIL NIL)
;
;

;; process draws into rgb counts
;; We have to use let to pre-define, because do-register-groups doesn't execute the setq portion if there is no match.
;; this version does one match (i.e. we need to pass it one draw and it will give us the rgb counts)

(defun list-replace-nil (list)
  (mapcar (lambda (x) (if (null x) 0 x)) list))

(defun rgb-search (string)
  (let ((r) (g) (b) )
    (cl-ppcre:do-register-groups (count) ("([0-9]*) red" string) (setq r (parse-integer count)))
    (cl-ppcre:do-register-groups (count) ("([0-9]*) green" string) (setq g (parse-integer count)))
    (cl-ppcre:do-register-groups (count) ("([0-9]*) blue" string) (setq b (parse-integer count)))
    (list-replace-nil (list r g b))
   )
  )

;; process lines into draws
(defun get-draws (string)
  (cdr (ppcre:split ";|:" string)))


(setq input (mapcar 'get-draws (uiop:read-file-lines "~/advent2023/s2in.txt")))
(setq input.p (mapcar (lambda (x) (mapcar 'rgb-search x)) input))

;; Get the maximum number drawn for each color in each game.
(defun get-pmax (list)
  (let ((r 0) (g 0) (b 0))
    (loop for x in list
          do (setq r (max r (first x)))
              (setq g (max g (second x)))
              (setq b (max b (third x))))
    (list r g b)))

(setq input.max (mapcar 'get-pmax input.p))

;; stage 1 (sum indices of impossible games with 12, 13, 14 rgb stones)
(defun good-game-test (list)
  (not (or (> (first list) 12)
      (> (second list) 13)
      (> (third list) 14))))

(setq input.goodtests (mapcar 'good-game-test input.max))

(defun all-positions (haystack)
  (loop
    for element in haystack
    and position from 1
     when element
      collect position))

(+ (all-positions input.goodtests))

;; stage 2 (sum the product of the maximum draws) *phew*
(apply '+ (mapcar (lambda (x) (apply '* x)) input.max))
