#!/bin/bash

if [ "$#" -lt 1 ]; then
    FILES=`ls codeGenInputs/*.cl`
else
    FILES=`ls codeGenInputs/$1_*.cl`    
fi

mkdir -p codeGenOutputs


for file in $FILES
do
    base=`basename $file`
    filename="${base%.*}"
    echo "# "$base
    java -cp ../out/production/CS544-COOL-CodeGenerator/:../libs/obf-cool.jar:$CLASSPATH cool.Main codeGenInputs/$base &> codeGenOutputs/$filename".ll"
    echo "--------------"
    cat ../builtin/builtin.ll codeGenOutputs/$filename".ll" | lli > codeGenOutputs/$filename".txt"
    result=`echo $?`
    echo $result > codeGenOutputs/$filename".result"
    cat codeGenOutputs/$filename".txt" codeGenOutputs/$filename".result"
    echo "==============================================="
done

