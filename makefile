run: build 
	cabal run 

build: db
	cabal build

db: 
	# ensure the database file exists
	echo $null >> languages.db

stack: db 
	stack ghc ./app/Main.hs --package QuickCheck
