#!/bin/bash

# -------- CONFIG --------
KEYCLOAK_URL="http://localhost:32112/auth/realms/keycloakOpa/protocol/openid-connect/token"
CLIENT_ID="kck"
USERNAME="user1"
PASSWORD="user1"
CLIENT_SECRET="secret"
REPO_URL="http://localhost:32341/repositories/Test"
# ------------------------

echo "🔐 Requesting access token..."

TOKEN_RESPONSE=$(curl -s -X POST "$KEYCLOAK_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=password" \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CLIENT_SECRET" \
  -d "username=$USERNAME" \
  -d "password=$PASSWORD")

ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')

if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" == "null" ]; then
  echo "❌ Failed to obtain token"
  echo "$TOKEN_RESPONSE"
  exit 1
fi

echo "✅ Token obtained"

echo "📡 Executing SPARQL query..."

curl -X POST "$REPO_URL" \
  -H "Content-Type: application/sparql-query" \
  -H "Accept: application/sparql-results+json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  --data-binary @- <<'EOF'

PREFIX mw: <https://w3id.org/candil/mouseworld#>
PREFIX mod: <https://w3id.org/mod#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xml: <http://www.w3.org/XML/1998/namespace>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX vann: <http://purl.org/vocab/vann/>
PREFIX dcterms: <http://purl.org/dc/terms/>

SELECT *
WHERE {
    ?topology a mw:Topology ;
        mw:topologyId ?topologyId .

    ?node a mw:Router ;
        mw:nodeId ?nodeId ;
        mw:os ?os ;
        mw:interface ?interface .

    ?interface mw:interfaceName ?interfaceName .

    ?os a mw:OperatingSystem ;
        mw:vendor ?vendor ;
        mw:dockerImage ?dockerImage .

    ?vendor mw:kneVendorName ?vendorName .
    ?dockerImage mw:imageUrl ?dockerImageUrl .

    ?link a mw:Link ;
        mw:connectsInterface ?ifaceA ;
        mw:connectsInterface ?ifaceB .

    ?ifaceA mw:interfaceName ?ifaceNameA .
    ?nodeA mw:interface ?ifaceA ;
        mw:nodeId ?nodeIdA .

    ?ifaceB mw:interfaceName ?ifaceNameB .
    ?nodeB mw:interface ?ifaceB ;
        mw:nodeId ?nodeIdB .

    FILTER (?ifaceA != ?ifaceB)
}

EOF

