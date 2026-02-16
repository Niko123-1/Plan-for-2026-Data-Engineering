#!/bin/bash

cat <<EOL > access.log
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL

echo "Лог-файл access.log успешно создан"
echo ""

{
    echo "Отчет о логе веб-сервера"
    echo "========================"

    total_requests=$(wc -l < access.log)
    echo "Общее количество запросов:    $total_requests"

    unique_ips=$(awk '{ips[$1]++} END {print length(ips)}' access.log)
    echo "Количество уникальных IP-адресов:    $unique_ips"
    echo ""

    echo "Количество запросов по методам:"
    awk '{
        match($0, /"([A-Z]+) /, method)
        if (method[1] != "") {
            methods[method[1]]++
        }
    } END {
        for (m in methods) {
            printf "%5s %s\n", methods[m], m
        }
    }' access.log
    echo ""

    awk '{
        match($0, /"GET ([^ ]+)/, url)
        if (url[1] != "") {
            urls[url[1]]++
        }
    } END {
        max_count = 0
        max_url = ""
        for (u in urls) {
            if (urls[u] > max_count) {
                max_count = urls[u]
                max_url = u
            }
        }
        print "Самый популярный URL:    " max_count " " max_url
    }' access.log

} > report.txt

echo "Отчет сохранен в файл report.txt"