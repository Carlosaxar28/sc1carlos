#!/bin/bash

if [[ ! -f colores.txt ]]; then
    echo "El archivo colores.txt no existe. Por favor, créalo primero."
    exit 1
fi

declare -A colores

while IFS=":" read -r clave valor; do
    if [[ -n "$clave" && -n "$valor" ]]; then
        colores["$clave"]=$(echo "$valor" | xargs)
    fi
done < colores.txt

if [[ -z "${colores[fondo]}" || -z "${colores[parrafo]}" || -z "${colores[letra]}" ]]; then
    echo "El archivo colores.txt no contiene todos los valores necesarios (fondo, parrafo, letra)."
    exit 1
fi

cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            background-color: ${colores[fondo]};
        }
        p {
            color: ${colores[parrafo]};
        }
        h1 {
            color: ${colores[letra]};
        }
	img {
		max-width: 100%;
		height: auto;
		max-height: 400px;
	}

    </style>
</head>
<body>
    <h1>¡Hola Mundo!</h1>
    <p>Este es un párrafo.</p>
    <img src="portrait-adorable-little-french-bulldog.jpg" alt="Una imagen bonita" >
</body>
</html>
EOF

echo "Archivo HTML generado correctamente: index.html"
