;;; init-Neo4j.el --- init for Neo4j.

;;; Time-stamp: <2019-02-15 14:23:40 stardiviner>

;;; Commentary:



;;; Code:

;;; [ n4js ] -- Neo4j shell in Emacs.

(use-package n4js
  :ensure t
  :defer t
  :commands (n4js-start)
  :init (defalias 'run-neo4j 'n4js-start))

;;; [ ob-neo4j ] -- Execute Neo4j's Cypher query in Org Mode Babel source block.

;; (use-package ob-neo4j
;;   :quelpa (ob-neo4j :fetcher github :repo "MarkBorcherding/ob-neo4j"))

;;; [ cypher-mode ] -- major mode for editing cypher scripts.

(use-package cypher-mode
  :ensure t
  :defer t)

;;; [ ob-cypher ] -- Query Neo4j using Cypher in Org Mode source blocks.

(use-package ob-cypher
  :ensure t
  :defer t)



(provide 'init-Neo4j)

;;; init-Neo4j.el ends here
