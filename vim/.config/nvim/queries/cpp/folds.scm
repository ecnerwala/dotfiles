; inherits: c

[
  (for_range_loop)
  (class_specifier)
  (field_declaration
    type: (enum_specifier)
    default_value: (initializer_list))
  ; template_declaration usually wraps function_definition or class_specifier, so this is unnecessary
  ;(template_declaration)
  (namespace_definition)
  (try_statement)
  (catch_clause)
  (lambda_expression)
] @fold
