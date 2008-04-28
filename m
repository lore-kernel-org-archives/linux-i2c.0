From: "Will Newton" <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] pca953x: Add support for pca9555 I2C I/O expander.
Date: Mon, 28 Apr 2008 16:07:59 +0100
Message-ID: <87a5b0800804280807g30895902na3691f52208fb75e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_666_26590464.1209395279240"
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
To: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

------=_Part_666_26590464.1209395279240
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add support for pca9555 I2C I/O expander. As the comment suggests this
part is software compatible with the pca9539.

Signed-off-by: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/gpio/pca953x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 6e72fd3..4ff274f 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -36,6 +36,7 @@ static const struct pca953x_desc pca953x_descs[] = {
 	{ "pca9537", 4, },
 	{ "pca9538", 8, },
 	{ "pca9539", 16, },
+	{ "pca9555", 16, },
 	/* REVISIT several pca955x parts should work here too */
 };

-- 
1.5.5.1

------=_Part_666_26590464.1209395279240
Content-Type: text/x-patch; name=0001-pca953x.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffl6ouab0
Content-Disposition: attachment; filename=0001-pca953x.patch

RnJvbSA5ZGUxNDZhYjlmN2ZiM2I4MWVmYWViMjIzZmUzY2U5MDlhYTg3MDgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXaWxsIE5ld3RvbiA8d2lsbC5uZXd0b25AaW1ndGVjLmNvbT4K
RGF0ZTogTW9uLCAyOCBBcHIgMjAwOCAxNjowMzoyOSArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIHBj
YTk1M3g6IEFkZCBzdXBwb3J0IGZvciBwY2E5NTU1IEkyQyBJL08gZXhwYW5kZXIuCgpBZGQgc3Vw
cG9ydCBmb3IgcGNhOTU1NSBJMkMgSS9PIGV4cGFuZGVyLgoKU2lnbmVkLW9mZi1ieTogV2lsbCBO
ZXd0b24gPHdpbGwubmV3dG9uQGltZ3RlYy5jb20+Ci0tLQogZHJpdmVycy9ncGlvL3BjYTk1M3gu
YyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL3BjYTk1M3guYyBiL2RyaXZlcnMvZ3Bpby9w
Y2E5NTN4LmMKaW5kZXggNmU3MmZkMy4uNGZmMjc0ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncGlv
L3BjYTk1M3guYworKysgYi9kcml2ZXJzL2dwaW8vcGNhOTUzeC5jCkBAIC0zNiw2ICszNiw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNhOTUzeF9kZXNjIHBjYTk1M3hfZGVzY3NbXSA9IHsKIAl7
ICJwY2E5NTM3IiwgNCwgfSwKIAl7ICJwY2E5NTM4IiwgOCwgfSwKIAl7ICJwY2E5NTM5IiwgMTYs
IH0sCisJeyAicGNhOTU1NSIsIDE2LCB9LAogCS8qIFJFVklTSVQgc2V2ZXJhbCBwY2E5NTV4IHBh
cnRzIHNob3VsZCB3b3JrIGhlcmUgdG9vICovCiB9OwogCi0tIAoxLjUuNS4xCgo=
------=_Part_666_26590464.1209395279240
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------=_Part_666_26590464.1209395279240--
