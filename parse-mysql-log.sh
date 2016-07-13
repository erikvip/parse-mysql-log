#!/bin/bash 

PATH=`dirname "${BASH_SOURCE}"`/bash:$PATH source template.bash

INPUT_FILE="$1"

main() {
	IFS=$'\n';
	q="";
	qstart=0;
	cmd="";
	for l in $(tail "${INPUT_FILE}"); do
		T=$'\t';
		regex="^[0-9 :${T}]+(Query|Connect)"
		
		if [[ "${l}" =~ $regex ]]; then
			echo "CMD: ${cmd}. Query: ${q}";
			qstart=1;
			q=`echo "$l" | sed -r -e "s/^[0-9 :${T}]+//" -e 's/$//g'`;
			#cmd=`echo "$q" | egrep -o "^[A-Za-z]+"`;
			#q=`echo "$q" | sed "s/^${cmd}[[:space:]]*//g"`;
		else
			if [[ "${qstart}" == "1" ]]; then
				q="${q}${l}"
			fi
		fi

	done;
}


main
