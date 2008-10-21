From: "Fabien Marteau" <fabien.marteau-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Simple read byte data compilation problem
Date: Tue, 21 Oct 2008 11:44:28 +0200
Message-ID: <ce62e9d00810210244p3194a50fj3b6b19209465ac7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4836_16197450.1224582268544"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

------=_Part_4836_16197450.1224582268544
Content-Type: multipart/alternative;
	boundary="----=_Part_4837_22763661.1224582268544"

------=_Part_4837_22763661.1224582268544
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hy,

I wrote a simple user program to test an i2c bus driver. I found in
Documentation/i2c/dev-interface their is macro function to read data
(i2c_smbus_read_byte_data). I used it but I have link error when I compile :
$ arm-linux-gcc -O i2cread.c -o i2cread
/tmp/ccfa90st.o: In function `read_byte':
i2cread.c:(.text+0x3c): undefined reference to `i2c_smbus_read_byte_data'
collect2: ld returned 1 exit status

Is someone know what is the problem ?

Thanks in advance
FabM

------=_Part_4837_22763661.1224582268544
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hy,<br><br>I wrote a simple user program to test an i2c bus driver. I found in Documentation/i2c/dev-interface their is macro function to read data (i2c_smbus_read_byte_data). I used it but I have link error when I compile :<br>
$ arm-linux-gcc -O i2cread.c -o i2cread<br>/tmp/ccfa90st.o: In function `read_byte&#39;:<br>i2cread.c:(.text+0x3c): undefined reference to `i2c_smbus_read_byte_data&#39;<br>collect2: ld returned 1 exit status<br><br>Is someone know what is the problem ?<br>
<br>Thanks in advance<br>FabM<br><br>

------=_Part_4837_22763661.1224582268544--

------=_Part_4836_16197450.1224582268544
Content-Type: text/x-csrc; name=i2cread.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmkckdra0
Content-Disposition: attachment; filename=i2cread.c

LyogYSBzaW1wbGUgcHJvZ3JhbSB0byByZWFkIG9uIGkyYyBidXMKICogRmFiaWVuIE1hcnRlYXUg
PGZhYmllbi5tYXJ0ZWF1QGFybWFkZXVzLmNvbT4KICoKICogaW5zcGlyZWQgZnJvbSA6IAogKiAg
IGNoNzAyNDogbWFuYWdlIHRoZSBTdmlkZW8gY29udHJvbGxlciBDSDcwMjQKICogIGF1dGhvcjog
dGhvbTI1QHVzZXJzLnNvdXJjZWZvcmdlLm5ldAogKgogKgogKiogIFRIRSBBUk1BREVVUyBQUk9K
RUNUCiAqKgogKiogIENvcHlyaWdodCAoQykgeWVhciAgVGhlIHNvdXJjZSBmb3JnZSBhcm1hZGV1
cyBwcm9qZWN0IHRlYW0KICoqCiAqKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91
IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogKiogaXQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKICoqIHRo
ZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vu
c2UsIG9yCiAqKiAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgogKiogCiAqKiBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVz
ZWZ1bCwKICoqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mCiAqKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCiAqKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLgogKiogCiAqKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQogKiogYWxvbmcgd2l0aCB0aGlzIHBy
b2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgCiAqKiBGb3VuZGF0aW9u
LCBJbmMuLCA1OSBUZW1wbGUgUGxhY2UgLSBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMw
NywgVVNBLgogKioKICovCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2lu
Y2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgoj
aW5jbHVkZSA8c3RyaW5nLmg+CiAKI2luY2x1ZGUgPGxpbnV4L2kyYy5oPiAKI2luY2x1ZGUgPGxp
bnV4L2kyYy1kZXYuaD4KIAojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiAKaW50IGZkOwogCi8qIFJl
YWQgYSBieXRlIG9uIHRoZSBJMkMgYnVzCiAgIFRoaXMgaXMgZG9uZSBieSB3cml0aW5nIHRoZSBy
ZWdpc3RlciBhZGRyZXNzIAogICB3ZSB3YW50IHRvIGFjY2VzcyBhbmQgdGhlbiBieSByZWFkaW5n
IHRoaXMgcmVnaXN0ZXIKICAgICBAcGFyYW0gZmQ6IGZpbGUgZGVzY3JpcHRvciBvZiB0aGUgZGV2
aWNlCiAgICAgQHBhcmFtIHJlZzogcmVnaXN0ZXIgdG8gYWNjZXNzCiAgICAgQHBhcmFtIGJ1Zjog
YnVmZmVyIHVzZWQgdG8gc3RvcmUgdGhlIHJlc3VsdAogICAgIEByZXR1cm4gOiAtMSBpbiBjYXNl
IG9mIGVycm9yIG90aGVyd2lzZSAwCiAqLwpfX3MzMiByZWFkX2J5dGUoIGludCBmZCx1bnNpZ25l
ZCBjaGFyIGFkZHIsIHVuc2lnbmVkIGNoYXIgcmVnKQp7IAoJaW50IGVycjsKCV9fczMyIHJlczsK
CS8qIHNlbGVjdCBhZGRyZXNzICovCglpZihlcnI9aW9jdGwoZmQsSTJDX1NMQVZFLGFkZHIpIDwg
MCl7CgkJcGVycm9yKCJjYW4ndCBzZWxlY3QgdGhpcyBhZGRyZXNzXG4iKTsKCQlyZXR1cm4gZXJy
OwoJfQoJcmVzID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGZkLChfX3U4KXJlZyk7CglpZihy
ZXM8MCkKCQlwZXJyb3IoInJlYWQgYnl0ZSBkYXRhIGVycm9yXG4iKTsKCXJldHVybiByZXM7Cn0K
IAovKiBpMmNyZWFkIGkyYy1kZXZmaWxlIGFkZHIqLwppbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpewogIHVuc2lnbmVkIGNoYXIgYnVmOwogIHVuc2lnbmVkIGNoYXIgYWRkcjsKICB1bnNp
Z25lZCBjaGFyIHN1YmFkZHI7CiAgdW5zaWduZWQgY2hhciB2YWx1ZTsKIAogIGlmKGFyZ2MgIT0g
NCl7CiAgICBwcmludGYoIndyb25nIGFyZ3MgbnVtYmVyc1xuc3ludGF4ZSAoaGV4YSkgOlxuIik7
CglwcmludGYoImkyY3JlYWQgaTJjLWRldmZpbGUgYWRkciBzdWJhZGRyXG4iKTsKICAgIHJldHVy
biAtMTsKICB9CiAKICBmZCA9IG9wZW4oYXJndlsxXSxPX1JEV1IpOwogIGlmKGZkIDwgMCl7CiAg
ICBwcmludGYoIiVkIDogY2FuJ3Qgb3BlbiAlc1xuIixmZCxhcmd2WzFdKTsKICAgIHJldHVybiAt
MTsKICB9CiAgLyogc2VsZWN0IGFkZHJlc3MgKi8KICBhZGRyID0gICAgKHVuc2lnbmVkIGNoYXIg
KXN0cnRvbChhcmd2WzJdLCAoY2hhciAqKilOVUxMLCAxNik7CiAgLyogc2VsZWN0IHN1YmFkZHJl
c3MgKi8KICBzdWJhZGRyID0gICAgKHVuc2lnbmVkIGNoYXIgKXN0cnRvbChhcmd2WzNdLCAoY2hh
ciAqKilOVUxMLCAxNik7CiAKICBidWYgPSAodW5zaWduZWQgY2hhcilyZWFkX2J5dGUoZmQsYWRk
ciwgc3ViYWRkcik7IAogCiAgcHJpbnRmKCJSZWFkIGNvbXBvbmVudCAlMDJ4IGF0IHN1YmFkZHJl
c3MgJTAyeC0+JTAyeFxuIixhZGRyLHN1YmFkZHIsYnVmKTsKIAogIHJldHVybiB2YWx1ZTsKfQo=

------=_Part_4836_16197450.1224582268544
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------=_Part_4836_16197450.1224582268544--
