if [ "$1" == "" ]; then
    echo "Empty arguments for position 1."
    exit
fi 

echo "NAME: ${1}"

mvn archetype:generate -DgroupId=com.utec -DartifactId=$1 -DarchetypeVersion=1.0 -DinteractiveMode=false
cd $1
echo "You're now at $pwd!"
echo "Running pom.xml fixer"
sed -i '' -e '$ d' pom.xml
cat "/Users/dgcnz/scripts/resources/java/pom_tail_fix.txt" >> pom.xml
