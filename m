From: Nick Teen <xpage_de-LWAfsSFWpa4@public.gmane.org>
Subject: i2c_smbus_write_block_data does not send all bytes?!
Date: Mon, 14 Jul 2008 20:32:25 +0000 (GMT)
Message-ID: <247321.99325.qm@web27608.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-154651088-1216067545=:99325"
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

--0-154651088-1216067545=:99325
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello folks,

i despair of i2c_smbus_write_block_data. I try to send this few bytes:

 5D W 11 02 33 44

but my attached example code sends always:

 5D W 11 03 33

I'm perfectly happy if somebody can help me! :-)

King Regards,

Nick=0A=0A=0A      ________________________________________________________=
__=0AGesendet von Yahoo! Mail.=0ADem pfiffigeren Posteingang.=0Ahttp://de.o=
verview.mail.yahoo.com
--0-154651088-1216067545=:99325
Content-Type: text/x-csrc; name="write-values.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="write-values.c"

I2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4K
I2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVk
ZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8bGlu
dXgvaTJjLWRldi5oPgoKaW50IG1haW4oKQp7CiAgICAgICAgaW50IGZkOwog
ICAgICAgIGludCBhZGFwdGVyX25yID0gMzsgLyogcHJvYmFibHkgZHluYW1p
Y2FsbHkgZGV0ZXJtaW5lZCAqLwogICAgICAgIHVuc2lnbmVkIGxvbmcgYWRk
ciA9IDB4NWQ7IC8qIFRoZSBJMkMgYWRkcmVzcyAqLwogICAgICAgIGNoYXIg
ZmlsZW5hbWVbMjBdID0gezB9OwogICAgICAgIHVuc2lnbmVkIGludCBzaXpl
OwogICAgICAgIGNoYXIgYnVmWzVdID0gezB9OwogICAgICAgIGludCByZXM7
CiAgICAgICAgaW50IHJlZzsKICAgICAgICB1bnNpZ25lZCBjaGFyIHZhbHVl
c1szXTsKCQogICAgICAgIHNwcmludGYoZmlsZW5hbWUsIi9kZXYvaTJjLSVk
IixhZGFwdGVyX25yKTsKICAgICAgICBwcmludGYoImRldmljZSBmaWxlOiAl
c1xuIixmaWxlbmFtZSk7CiAgICAgICAgcHJpbnRmKCJpMmMgZGV2aWNlIEFk
ZHJlc3M6IDB4JXhcbiIsYWRkcik7CgogICAgICAgIGZkID0gb3BlbihmaWxl
bmFtZSxPX1JEV1IpOwogICAgICAgIHJlcyA9IGlvY3RsKGZkLEkyQ19TTEFW
RSxhZGRyKTsKCglyZWcgPSAweDExOwoJdmFsdWVzWzBdID0gMHgzMzsKCXZh
bHVlc1sxXSA9IDB4NDQ7CgogICAgICAgIGlmICggaTJjX3NtYnVzX3dyaXRl
X2Jsb2NrX2RhdGEoZmQsIHJlZywgMiwgdmFsdWVzKSA8IDApIHsKICAgICAg
ICAgICAgICAgIHBlcnJvcigiRXJyb3I6ICIpOwogICAgICAgIH0KCiAgICAg
ICAgY2xvc2UoZmlsZW5hbWUpOwogICAgICAgIHJldHVybiAwOwp9Cg==

--0-154651088-1216067545=:99325
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--0-154651088-1216067545=:99325--
