#!/bin/bash


mkdir -p codeGenOutputs_1

FILES=`ls codeGenInputs_1/*.cl`

for file in $FILES
do
    base=`basename $file`
    filename="${base%.*}"
    echo "# "$base
    java -cp ./out/production/CS544-COOL-CodeGenerator/:./libs/obf-parser.jar:./libs/obf-scanner.jar:$CLASSPATH cool.Main codeGenInputs_1/$base &> codeGenOutputs_1/$filename".ll"
    echo "--------------"
    lli codeGenOutputs_1/$filename".ll"
    echo $?
    echo "==============================================="
done

