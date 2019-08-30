main : bst.cmo main.cmo
	ocamlc -o main bst.cmo main.cmo
main.cmo: main.ml
	ocamlc -c main.ml
bst.cmo: bst.cmi bst.ml
	ocamlc -c bst.ml
bst.cmi: bst.mli
	ocamlc -c bst.mli

clean:
	rm -rf main *.cmi *.cmo
