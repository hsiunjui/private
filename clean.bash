#!/bin/bash

# 检查 private.pem 是否存在，若存在则使用 dd 覆盖后删除
if [ -f private.pem ]; then
    echo "正在强力删除 private.pem..."
    dd if=/dev/zero of=private.pem bs=1M count=5 status=none
    rm -f private.pem
    echo "private.pem 已被安全删除。"
else
    echo "private.pem 不存在，无需删除。"
fi

# 强力删除 Decrypted 目录下除 ALWAYS_DELETE.md 以外的所有文件
echo "正在强力清理 Decrypted 目录..."
find Decrypted -type f ! -name "ALWAYS_DELETE.md" -print0 | while IFS= read -r -d '' file; do
    dd if=/dev/zero of="$file" bs=1M count=5 status=none
    rm -f "$file"
done

# 删除 Decrypted 目录下所有空目录
find Decrypted -type d ! -name "ALWAYS_DELETE.md" -empty -delete

rm -f Credentials/aes_key.txt

rm -f public.pem

echo "Decrypted 目录清理完成。"
