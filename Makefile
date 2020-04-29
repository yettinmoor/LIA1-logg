README.md: veckor/*
	rm -f README.md
	for file in veckor/*; do cat $$file >> README.md; echo >> README.md; done
	printf '$$d\nwq\n' | ed README.md
