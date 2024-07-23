(declaration
  name: (identifier) @name
   (#eq? @name "node")
  (#set! "kind" "Class")) @symbol

(function_call
  function: (identifier) @keyword
  (#eq? @keyword "stage")
  args: (argument_list
          (string
            (string_content) @name))
  (#set! "kind" "Function")) @symbol

(function_call
  function: (identifier) @name
  (#eq? @name "parallel")
  (#set! "kind" "Array")) @symbol

(declaration
  type: (dotted_identifier) @name
  name: (identifier) @keyword
  (#eq? @keyword "import")
  (#set! "kind" "Module")) @symbol

(declaration
  name: (identifier) @name
  (#not-eq? @name "import")
  (#set! "kind" "Variable")) @symbol

