sort: strSet.cmi strSet.cmo sort.cmo
	ocamlc -o sort strSet.cmo sort.cmo
strSet.cmi: strSet.mli
	ocamlc -c strSet.mli
strSet.cmo: strSet.ml
	ocamlc -c strSet.ml
sort.cmo: sort.ml
	ocamlc -c sort.ml

clean:
	rm -rf *.cmi *.cmo sort
