#!/bin/bash

# 检查 private.pem 是否存在
if [ ! -f private.pem ]; then
    echo "请导入私钥 (private.pem) 后再运行此脚本。"
    exit 1
fi

# 解密 AES 密钥
echo "正在解密 AES 密钥..."
openssl pkeyutl -decrypt -in Credentials/aes_key.enc -inkey private.pem -out aes_key.txt
if [ $? -ne 0 ]; then
    echo "AES 密钥解密失败。"
    exit 1
fi

echo "AES 密钥解密成功，开始解密文件..."

# 选择要解密的文件
echo "请输入要解密的文件路径："
read input_file

# 选择解密后的文件名
echo "请输入解密后文件的名称 (存放于 Decrypted 目录)："
read output_filename

# 解密文件
openssl enc -d -aes-256-cbc -pbkdf2 -in "Encrypted/$input_file" -out "Decrypted/$output_filename" -pass file:aes_key.txt
if [ $? -ne 0 ]; then
    echo "文件解密失败。"
    rm -f aes_key.txt
    exit 1
fi

echo "文件解密成功，清理临时文件..."

# 删除 AES 密钥文件
rm -f aes_key.txt
echo "解密完成。"