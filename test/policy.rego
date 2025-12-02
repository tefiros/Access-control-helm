package AccessControl

default allow = true
default message = ""

# Set of forbidden fields
blocked_fields[field] {
    field = "mw:kneVendorName"
}

# Main rule: deny if a forbidden field is found in the SPARQL query
allow = false {
    forbidden_field := find_forbidden_field
}

# Dynamic denial message
message = msg {
    forbidden_field := find_forbidden_field
    msg := sprintf("Access denied: the field '%v' is not authorized.", [forbidden_field])
}

# Returns the forbidden field that appears in the SPARQL query
find_forbidden_field = field {
    blocked_fields[field]
    contains(input.request.body, field)   # Correct location of SPARQL body
}

# Helper: string contains() function compatible with older Rego engines
contains(text, sub) {
    indexof(text, sub) >= 0
}
