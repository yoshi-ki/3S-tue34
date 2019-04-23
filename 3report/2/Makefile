main : stack.cmo main.cmo
	ocamlc -o main stack.cmo main.cmo
main.cmo: main.ml
	ocamlc -c main.ml
stack.cmo: stack.cmi stack.ml
	ocamlc -c stack.ml
stack.cmi: stack.mli
	ocamlc -c stack.mli

clean:
	rm -rf main *.cmi *.cmo
