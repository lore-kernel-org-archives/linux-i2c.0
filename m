From: "Zhang, Sean C. (NSB - CN/Hangzhou)" <sean.c.zhang@nokia-sbell.com>
Subject: [Bug fix] octeon-i2c driver updates
Date: Thu, 23 Nov 2017 11:42:36 +0000
Message-ID: <VI1PR0702MB3615DF756007C1F87BED50BB8E210@VI1PR0702MB3615.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="_002_VI1PR0702MB3615DF756007C1F87BED50BB8E210VI1PR0702MB3615_"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10097.outbound.protection.outlook.com ([40.107.1.97]:29130
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751799AbdKWLmj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Nov 2017 06:42:39 -0500
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "jglauber@cavium.com" <jglauber@cavium.com>, "david.daney@cavium.com" <david.daney@cavium.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--_002_VI1PR0702MB3615DF756007C1F87BED50BB8E210VI1PR0702MB3615_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear Maintainer,

For octeon TWSI controller, I found below two cases, maybe can be improved.


>From 09d9f0ce658d7f6a50d1af352dde619c29bc8bcf Mon Sep 17 00:00:00 2001
From: hgt463 <sean.c.zhang@nokia.com>
Date: Thu, 23 Nov 2017 18:46:09 +0800
Subject: [PATCH] Driver updates:
 - In the case of I2C bus dead lock occurred during driver probing,
   it is better try to recovery it. so added bus recovery step in
   octeon_i2c_probe();
 - The purpose of function octeon_i2c_start() is to send START, so after
   bus recovery, also need try to send START again.

Signed-off-by: hgt463 <sean.c.zhang@nokia.com>
---
 drivers/i2c/busses/i2c-octeon-core.c    |   31 +++++++++++++++++++++++++++=
+++-
 drivers/i2c/busses/i2c-octeon-platdrv.c |   15 +++++++++------
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-=
octeon-core.c
index 1d87757..3ae1e03 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -255,6 +255,35 @@ static int octeon_i2c_recovery(struct octeon_i2c *i2c)
        return ret;
 }
=20
+/*
+ * octeon_i2c_start_retry - send START to the bus after bus recovery.
+ * @i2c: The struct octeon_i2c
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_start_retry(struct octeon_i2c *i2c)
+{
+       int ret;
+       u8 stat;
+
+       ret =3D octeon_i2c_recovery(i2c);
+       if (ret)
+               goto error;
+
+       octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_STA);
+       ret =3D octeon_i2c_wait(i2c);
+       if (ret)
+               goto error;
+
+       stat =3D octeon_i2c_stat_read(i2c);
+       if (stat =3D=3D STAT_START || stat =3D=3D STAT_REP_START)
+               /* START successful, bail out */
+               return 0;
+
+error:
+       return (ret) ? ret : -EAGAIN;
+}
+
 /**
  * octeon_i2c_start - send START to the bus
  * @i2c: The struct octeon_i2c
@@ -280,7 +309,7 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
=20
 error:
        /* START failed, try to recover */
-       ret =3D octeon_i2c_recovery(i2c);
+       ret =3D octeon_i2c_start_retry(i2c);
        return (ret) ? ret : -EAGAIN;
 }
=20
diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i=
2c-octeon-platdrv.c
index 64bda83..98063af 100644
--- a/drivers/i2c/busses/i2c-octeon-platdrv.c
+++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
@@ -228,12 +228,6 @@ static int octeon_i2c_probe(struct platform_device *pd=
ev)
        if (OCTEON_IS_MODEL(OCTEON_CN38XX))
                i2c->broken_irq_check =3D true;
=20
-       result =3D octeon_i2c_init_lowlevel(i2c);
-       if (result) {
-               dev_err(i2c->dev, "init low level failed\n");
-               goto  out;
-       }
-
        octeon_i2c_set_clock(i2c);
=20
        i2c->adap =3D octeon_i2c_ops;
@@ -245,6 +239,15 @@ static int octeon_i2c_probe(struct platform_device *pd=
ev)
        i2c_set_adapdata(&i2c->adap, i2c);
        platform_set_drvdata(pdev, i2c);
=20
+       stat =3D octeon_i2c_stat_read(i2c);
+       if (stat !=3D STAT_IDLE) {
+               result =3D octeon_i2c_recovery(i2c);
+               if (result) {
+                       dev_err(i2c->dev, "octeon i2c recovery failed\n");
+                       goto  out;
+               }
+       }
+
        result =3D i2c_add_adapter(&i2c->adap);
        if (result < 0)
                goto out;


Attached patch for you review. Thanks in advance.

BR,
Sean Zhang

--_002_VI1PR0702MB3615DF756007C1F87BED50BB8E210VI1PR0702MB3615_
Content-Type: application/octet-stream; name="0001-Driver-updates.patch"
Content-Description: 0001-Driver-updates.patch
Content-Disposition: attachment; filename="0001-Driver-updates.patch";
	size=2929; creation-date="Thu, 23 Nov 2017 11:05:47 GMT";
	modification-date="Thu, 23 Nov 2017 11:27:08 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwOWQ5ZjBjZTY1OGQ3ZjZhNTBkMWFmMzUyZGRlNjE5YzI5YmM4YmNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBoZ3Q0NjMgPHNlYW4uYy56aGFuZ0Bub2tpYS5jb20+CkRhdGU6
IFRodSwgMjMgTm92IDIwMTcgMTg6NDY6MDkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBEcml2ZXIg
dXBkYXRlczoKIC0gSW4gdGhlIGNhc2Ugb2YgSTJDIGJ1cyBkZWFkIGxvY2sgb2NjdXJyZWQgZHVy
aW5nIGRyaXZlciBwcm9iaW5nLAogICBpdCBpcyBiZXR0ZXIgdHJ5IHRvIHJlY292ZXJ5IGl0LiBz
byBhZGRlZCBidXMgcmVjb3Zlcnkgc3RlcCBpbgogICBvY3Rlb25faTJjX3Byb2JlKCk7CiAtIFRo
ZSBwdXJwb3NlIG9mIGZ1bmN0aW9uIG9jdGVvbl9pMmNfc3RhcnQoKSBpcyB0byBzZW5kIFNUQVJU
LCBzbyBhZnRlcgogICBidXMgcmVjb3ZlcnksIGFsc28gbmVlZCB0cnkgdG8gc2VuZCBTVEFSVCBh
Z2Fpbi4KClNpZ25lZC1vZmYtYnk6IGhndDQ2MyA8c2Vhbi5jLnpoYW5nQG5va2lhLmNvbT4KLS0t
CiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9jdGVvbi1jb3JlLmMgICAgfCAgIDMxICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0KIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb2N0ZW9uLXBs
YXRkcnYuYyB8ICAgMTUgKysrKysrKysrLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2Vz
L2kyYy1vY3Rlb24tY29yZS5jIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY3Rlb24tY29yZS5j
CmluZGV4IDFkODc3NTcuLjNhZTFlMDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtb2N0ZW9uLWNvcmUuYworKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9jdGVvbi1jb3Jl
LmMKQEAgLTI1NSw2ICsyNTUsMzUgQEAgc3RhdGljIGludCBvY3Rlb25faTJjX3JlY292ZXJ5KHN0
cnVjdCBvY3Rlb25faTJjICppMmMpCiAJcmV0dXJuIHJldDsKIH0KIAorLyoKKyAqIG9jdGVvbl9p
MmNfc3RhcnRfcmV0cnkgLSBzZW5kIFNUQVJUIHRvIHRoZSBidXMgYWZ0ZXIgYnVzIHJlY292ZXJ5
LgorICogQGkyYzogVGhlIHN0cnVjdCBvY3Rlb25faTJjCisgKgorICogUmV0dXJucyAwIG9uIHN1
Y2Nlc3MsIG90aGVyd2lzZSBhIG5lZ2F0aXZlIGVycm5vLgorICovCitzdGF0aWMgaW50IG9jdGVv
bl9pMmNfc3RhcnRfcmV0cnkoc3RydWN0IG9jdGVvbl9pMmMgKmkyYykKK3sKKwlpbnQgcmV0Owor
CXU4IHN0YXQ7CisKKwlyZXQgPSBvY3Rlb25faTJjX3JlY292ZXJ5KGkyYyk7CisJaWYgKHJldCkK
KwkJZ290byBlcnJvcjsKKworCW9jdGVvbl9pMmNfY3RsX3dyaXRlKGkyYywgVFdTSV9DVExfRU5B
QiB8IFRXU0lfQ1RMX1NUQSk7CisJcmV0ID0gb2N0ZW9uX2kyY193YWl0KGkyYyk7CisJaWYgKHJl
dCkKKwkJZ290byBlcnJvcjsKKworCXN0YXQgPSBvY3Rlb25faTJjX3N0YXRfcmVhZChpMmMpOwor
CWlmIChzdGF0ID09IFNUQVRfU1RBUlQgfHwgc3RhdCA9PSBTVEFUX1JFUF9TVEFSVCkKKwkJLyog
U1RBUlQgc3VjY2Vzc2Z1bCwgYmFpbCBvdXQgKi8KKwkJcmV0dXJuIDA7CisKK2Vycm9yOgorCXJl
dHVybiAocmV0KSA/IHJldCA6IC1FQUdBSU47Cit9CisKIC8qKgogICogb2N0ZW9uX2kyY19zdGFy
dCAtIHNlbmQgU1RBUlQgdG8gdGhlIGJ1cwogICogQGkyYzogVGhlIHN0cnVjdCBvY3Rlb25faTJj
CkBAIC0yODAsNyArMzA5LDcgQEAgc3RhdGljIGludCBvY3Rlb25faTJjX3N0YXJ0KHN0cnVjdCBv
Y3Rlb25faTJjICppMmMpCiAKIGVycm9yOgogCS8qIFNUQVJUIGZhaWxlZCwgdHJ5IHRvIHJlY292
ZXIgKi8KLQlyZXQgPSBvY3Rlb25faTJjX3JlY292ZXJ5KGkyYyk7CisJcmV0ID0gb2N0ZW9uX2ky
Y19zdGFydF9yZXRyeShpMmMpOwogCXJldHVybiAocmV0KSA/IHJldCA6IC1FQUdBSU47CiB9CiAK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb2N0ZW9uLXBsYXRkcnYuYyBiL2Ry
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtb2N0ZW9uLXBsYXRkcnYuYwppbmRleCA2NGJkYTgzLi45ODA2
M2FmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9jdGVvbi1wbGF0ZHJ2LmMK
KysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY3Rlb24tcGxhdGRydi5jCkBAIC0yMjgsMTIg
KzIyOCw2IEBAIHN0YXRpYyBpbnQgb2N0ZW9uX2kyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCWlmIChPQ1RFT05fSVNfTU9ERUwoT0NURU9OX0NOMzhYWCkpCiAJCWkyYy0+
YnJva2VuX2lycV9jaGVjayA9IHRydWU7CiAKLQlyZXN1bHQgPSBvY3Rlb25faTJjX2luaXRfbG93
bGV2ZWwoaTJjKTsKLQlpZiAocmVzdWx0KSB7Ci0JCWRldl9lcnIoaTJjLT5kZXYsICJpbml0IGxv
dyBsZXZlbCBmYWlsZWRcbiIpOwotCQlnb3RvICBvdXQ7Ci0JfQotCiAJb2N0ZW9uX2kyY19zZXRf
Y2xvY2soaTJjKTsKIAogCWkyYy0+YWRhcCA9IG9jdGVvbl9pMmNfb3BzOwpAQCAtMjQ1LDYgKzIz
OSwxNSBAQCBzdGF0aWMgaW50IG9jdGVvbl9pMmNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKIAlpMmNfc2V0X2FkYXBkYXRhKCZpMmMtPmFkYXAsIGkyYyk7CiAJcGxhdGZvcm1f
c2V0X2RydmRhdGEocGRldiwgaTJjKTsKIAorCXN0YXQgPSBvY3Rlb25faTJjX3N0YXRfcmVhZChp
MmMpOworCWlmIChzdGF0ICE9IFNUQVRfSURMRSkgeworCQlyZXN1bHQgPSBvY3Rlb25faTJjX3Jl
Y292ZXJ5KGkyYyk7CisJCWlmIChyZXN1bHQpIHsKKwkJCWRldl9lcnIoaTJjLT5kZXYsICJvY3Rl
b24gaTJjIHJlY292ZXJ5IGZhaWxlZFxuIik7CisJCQlnb3RvICBvdXQ7CisJCX0KKwl9CisKIAly
ZXN1bHQgPSBpMmNfYWRkX2FkYXB0ZXIoJmkyYy0+YWRhcCk7CiAJaWYgKHJlc3VsdCA8IDApCiAJ
CWdvdG8gb3V0OwotLSAKMS43LjEKCg==

--_002_VI1PR0702MB3615DF756007C1F87BED50BB8E210VI1PR0702MB3615_--
