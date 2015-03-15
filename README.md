# company-d

Emacs Company mode backend for D Lang.

This is mad alpha. But happy to take pull requests if you want to contribute to improving it.

I have this in my init.d to set it up

```lisp
(load "~/path/to/company-d.el")

(add-hook 'd-mode-hook (lambda ()
                         (set (make-local-variable 'company-backends) '(company-d))))
```
