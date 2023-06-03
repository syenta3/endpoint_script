#!/bin/bash

# Dosya adları
input_file="endpoints.txt"
output_file="endpoints_responses.txt"

# Dosya kontrolü
if [ ! -f "$input_file" ]; then
  echo "Hata: $input_file bulunamadı."
  exit 1
fi

# Çıktı dosyasını sıfırla
> "$output_file"

# Endpointleri işle
while IFS= read -r endpoint; do
  echo "İstek yapılıyor: $endpoint"
  
  # HTTP isteği yap ve yanıtı al
  response=$(curl -s -o /dev/null -w "%{http_code}" "$endpoint")
  
  # Yanıtı dosyaya yaz
  echo "$endpoint: $response" >> "$output_file"
done < "$input_file"

echo "İşlem tamamlandı. Yanıtlar $output_file dosyasına kaydedildi."