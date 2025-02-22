
# aes_key
- 生成
```
openssl rand -out aes_key.txt 32
```
- 加密
```
openssl pkeyutl -encrypt -in Credentials/aes_key.txt -pubin -inkey public.pem -out Credentials/aes_key.enc
```
- 解密(ase_key.txt)
```
openssl pkeyutl -decrypt -in Credentials/aes_key.enc -inkey private.pem -out Credentials/aes_key.txt
```

# 文件
- 加密
```
openssl enc -aes-256-cbc -salt -pbkdf2 -in SOURCE_FILENAME -out DEST_FILENAME.enc -pass file:Credentials/aes_key.txt
```
- 解密
```
openssl enc -d -aes-256-cbc -pbkdf2 -in DEST_FILENAME.enc -out DECRYPTED_FILENAME -pass file:Credentials/aes_key.txt
```

>SOURCE_FILENAME是需要加密的文件,

>DEST_FILENAME.enc是加密后文件

>DECRYPTED_FILENAME是解密后的文件 eg: crypto.enc -> crypto.txt

>_zip结尾的解压为.zip文件


## 先解密aes_key,然后用aes_key解密文件(前提是需要将private.pem放在根目录)