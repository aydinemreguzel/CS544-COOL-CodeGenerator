#!/bin/bash


mkdir -p parserOutputs

FILES=`ls parserInputs/*.cl`

for file in $FILES
do
    base=`basename $file`
    echo "# "$base
    java -cp ../out/production/CS544-COOL-CodeGenerator/:../libs/obf-cool.jar:$CLASSPATH cool.Main parserInputs/$base &> parserOutputs/$base
    echo "--------------"
    cat parserInputs/$base
    echo "--------------"
    cat parserOutputs/$base
    echo "==============================================="
done

