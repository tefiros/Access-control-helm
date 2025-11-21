package AccessControl
import rego.v1
default allow = false

allow if{
  input.request.http.headers["x-user"] == "alice"
}
