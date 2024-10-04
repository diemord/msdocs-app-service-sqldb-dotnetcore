#!/bin/bash
sqlfiles="false"
DBpassword=$1
sqlpath=$2

echo "SHOW DATABASES;" | dd of=testsqlconnection.sql

# Перевірка готовності MySQL сервера
for i in {1..60};
do
    mysql --host=localhost --user=root --password=$DBpassword < testsqlconnection.sql > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo "MySQL server ready"
        break
    else
        echo "Not ready yet..."
        sleep 1
    fi
done
rm testsqlconnection.sql

# Перевірка наявності SQL файлів
for f in $sqlpath/*
do
    if [[ $f == *.sql ]]
    then
        sqlfiles="true"
        echo "Found SQL file $f"
    fi
done

# Виконання SQL файлів
if [ $sqlfiles == "true" ]
then
    for f in $sqlpath/*
    do
        if [[ $f == *.sql ]]
        then
            echo "Executing $f"
            mysql --host=localhost --user=root --password=$DBpassword < $f
        fi
    done
fi

# Встановлення EF Core tools (для MySQL)
dotnet tool install --global dotnet-ef --version 8.*
