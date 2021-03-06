#!/bin/bash
:<<LICENCIA
	Plugin creado por Heliodoro Avila Donoso.
	Script creado por Ricardo.
LICENCIA

declare -i n=0
declare name="latino.lang" folder_
if [[ "$(echo `whoami`)" != "root" ]]; then printf "%s\n"  "Necesitas ser root para instalar este plugin."; exit; fi
case `dpkg -s gedit | grep "Version:" | cut -d ":" -f2- | cut -d " " -f2 | cut -d '.' -f1` in
  4) n=4;;
  3) n=3;;
  2) n=2;;
  1) n=1;;
esac
if [[ ! -f ${name} ]]; then
	cat <(curl -s https://raw.githubusercontent.com/lenguaje-latino/Latino-Gedit-Plugin/master/${name}) >> ${name}
fi

if [[ $n < 1 ]]; then printf "%s\n" "Error al obtener versión."; exit; fi
folder_="/usr/share/gtksourceview-${n}.0/language-specs/"
if [[ ! -d $folder_ ]]; then echo "Error al obtener carpeta de Gedit"; fi
mv ${name} ${folder_}
if [[ $? < 1 ]]; then
	echo "Plugin instalado correctamente"
else
	printf "%s\n"\
	"Error al copiar el archivo,"\
	"¿El archivo ${name} existe?"
fi
