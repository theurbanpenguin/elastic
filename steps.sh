sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo tee /etc/yum.repos.d/elastic.repo <<EOF
[elasticsearch]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
sudo yum install -y elasticsearch


sudo systemctl daemon-reload
sudo systemctl enable --now elasticsearch

curl -X GET "localhost:9200/_cluster/health?pretty"
curl -X PUT "localhost:9200/test-index?pretty"
curl -X POST "localhost:9200/test-index/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "name": "John Doe",
  "age": 30,
  "occupation": "Software Engineer"
}
'
curl -X GET "localhost:9200/test-index/_doc/1?pretty"
curl -X GET "localhost:9200/test-index/_search?q=name:John&pretty"

sudo yum install -y logstash
#sudo /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/stdin.conf
#curl -X GET "localhost:9200/stdin-log-*/_search?pretty"
sudo vim /etc/logstash/conf.d/logstash-http.conf
sudo systemctl enable --now logstash

python3 email.py
curl -X GET "localhost:9200/python-emails-*/_search?pretty"
curl -X GET "localhost:9200/python-emails-*/_search?q=email:outlook.com&pretty"
curl -X GET "localhost:9200/python-emails-*/_count?pretty"