program practica_sm1_ej2;
type
	subrPartos = 1..12;
	
	vectorPartos = Array[subrPartos] of integer;
	
	hembra = record
		nombre : string[20];
		id : integer;
		anioNac : integer;
		partos : subrPartos;
		crias: vectorPartos;
	end;
	
	lista = ^nodo;
	
	nodo = record
		dato : hembra;
		sig : lista;
	end;

//modulos
procedure listaHembras (var l:lista);//se dispone
begin
	l:= nil
end;

procedure insertarOrdenado (l2:lista; d:hembra);
var
	nue:lista;
	act:lista;
	ant:lista;
begin
	new(nue);
	nue^.dato:= d;
	act:= l2;
	ant:= l2;
	while (act<>nil)and(d.nombre <= act^.dato.nombre) do begin
		ant:= act;
		act:= act^.sig;
	end;
	if (act<>nil) then begin
		l2:= nue;
	end
	else
		ant^.sig:= nue;
	nue^.sig:= act;
end;

procedure lista15Crias (l:lista; var l2:lista);
var
	i: integer;
	cantCrias: integer;
begin
	while (l<>nil) do begin
		cantCrias:= 0;
		for i:= 1 to l^.dato.partos do begin
			cantCrias:= cantCrias + l^.dato.crias[i];
		end;
		if (cantCrias >= 15)then
			insertarOrdenado(l2,l^.dato);
		l:= l^.sig;
	end;
end;

function retornarID (l2:lista; nom:string): integer;
begin
	while (l2<>nil)and(l2^.dato.nombre < nom) do begin
		l2:= l2^.sig;
	end;
	if (l2<>nil) then begin
		retornarID:= l2^.dato.id;
	end
	else
		retornarID:= -1;
end;

//programa principal
VAR
	l: lista;
	l2: lista;
	nombre:string;
BEGIN
	l:= nil;
	l2:= nil;
	listaHembras(l);
	lista15Crias(l,l2);
	writeln('ingrese el nombre de la perra');
	readln(nombre);
	writeln('el id de la perra es: ', retornarID(l2,nombre));
END.
