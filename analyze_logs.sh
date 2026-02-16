cat <<EOL > access.log
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL


echo "Отчет о логе веб-сервера" > report.txt
echo "===================" >> report.txt
echo "" >> report.txt


total_requests=$(wc -l < access.log)
printf "Общее количество запросов:                %d\n" $total_requests >> report.txt


unique_ips=$(awk '{ips[$1]++} END {print length(ips)}' access.log)
printf "Количество уникальных IP-адресов:                %d\n" $unique_ips >> report.txt
echo "" >> report.txt


echo "Количество запросов по методам:" >> report.txt
awk '{
    match($0, /"(GET|POST|PUT|DELETE|HEAD|OPTIONS) /, methods)
    if (methods[1] != "") {
        count[methods[1]]++
    }
} END {
    for (method in count) {
        if (method == "GET") {
            printf "         %d  %-5s\n", count[method], method
        } else {
            printf "         %d   %-5s\n", count[method], method
        }
    }
}' access.log >> report.txt
echo "" >> report.txt


printf "Самый популярный URL:                " >> report.txt
awk '{
    # Более простое извлечение URL
    for (i=1; i<=NF; i++) {
        if ($i ~ /^\//) {
            url = $i
            urls[url]++
            break
        }
    }
} END {
    max_count = 0
    max_url = ""
    for (url in urls) {
        if (urls[url] > max_count) {
            max_count = urls[url]
            max_url = url
        }
    }
    printf "%d %s\n", max_count, max_url
}' access.log >> report.txt


cat report.txt