include .env

ifdef FILE
  matchFile = --match-contract $(FILE)
endif
ifdef FUNC
  matchFunction = --match $(FUNC)
endif

test = forge test $(matchFile) $(matchFunction)
fork-block-number = --fork-block-number 16386958

# test locally
t:
	$(test) -vv 
tt:
	$(test) -vvv 
ttt:
	$(test) -vvvv 

# test on fork
ft:
	$(test) -vv   --fork-url $(RPC) $(fork-block-number)
ftt:
	$(test) -vvv  --fork-url $(RPC) $(fork-block-number)
fttt:
	$(test) -vvvv --fork-url $(RPC)	$(fork-block-number)

# deploy on goerli
deploy:
	forge script script/Deploy.s.sol --rpc-url https://rpc-mumbai.maticvigil.com --sender $(PUBLIC_KEY) --broadcast --verify -i 1 -vvvv --legacy

dd:
	forge script script/Deploy.chilliz.s.sol --rpc-url https://spicy-rpc.chiliz.com --sender $(PUBLIC_KEY) --broadcast --verify -i 1 -vvvv --legacy

# deploy on mainnet
mdeploy:
	forge script script/Deploy.Mainnet.s.sol --rpc-url $(MAINNET_RPC) --sender $(PUBLIC_KEY) --broadcast --verify -i 1 -vvvv

read:
	forge script script/Read.s.sol --rpc-url $(GOERLI_RPC) --fork-block-number 8416091
