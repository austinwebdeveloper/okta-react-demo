# !/bin/sh

for value in `find . -type f -name "*.js" -o -name "*.js.map"`; do
    for env in `cat $value | grep -o "<(\[{[^<]*}])>" | sed 's/<(\[{\(.*\)}])>/\1/g'`; do
	      sed -i "s|<(\[{$env}])>|"$(eval echo \$$env)"|g" $value
    done
done


echo "port listening on 8080"
exec /usr/sbin/nginx -g "daemon off;$@"

