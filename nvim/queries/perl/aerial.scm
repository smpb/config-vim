(package_statement
  name: (package) @name
  (#set! "kind" "Class")) @symbol

(use_statement
  module: (package) @keyword
  (#eq? @keyword "constant")
  (list_expression
    (autoquoted_bareword) @name)
  (#set! "kind" "Constant")) @symbol

(use_statement
  module: (package) @name
  (#not-eq? @name "constant")
  (#set! "kind" "Module")) @symbol

(subroutine_declaration_statement
  name: (bareword) @name
  (#set! "kind" "Function")) @symbol

