.PHONY: startTestnet deployBackend getDidBackend help

help:
	@echo "startTestnet: inicia la testnet local de ICP"
	@echo "deployBackend: despliega el backend en la testnet local"
	@echo "getDidBackend: obtiene el candid del backend"

testnet:
	dfx start --clean

deployBackend:
	dfx deploy mc4_backend

deployFrontend:
	dfx deploy mc4_frontend

deploy:
	dfx deploy

getDidBackend:
	@dfx canister create mc4_backend
	@dfx build mc4_backend
	@echo "El candid del backend esta ubicado en ./.dfx/local/canisters/mc4_backend"