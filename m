From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v4 6/7] i2c: bcm2835: Support i2c-dev ioctl I2C_TIMEOUT
Date: Mon,  3 Oct 2016 22:06:13 +0200
Message-ID: <1475525174-28604-7-git-send-email-noralf@tronnes.org>
References: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net
Cc: linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

VXNlIGkyY19hZGFwdGVyLT50aW1lb3V0IGZvciB0aGUgY29tcGxldGlvbiB0aW1lb3V0IHZhbHVl
LiBUaGUgY29yZQpkZWZhdWx0IGlzIDEgc2Vjb25kLgoKU2lnbmVkLW9mZi1ieTogTm9yYWxmIFRy
w7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+ClJldmlld2VkLWJ5OiBFcmljIEFuaG9sdCA8ZXJp
Y0BhbmhvbHQubmV0PgotLS0KIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtMjgzNS5jIHwgNCAr
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1iY20yODM1LmMgYi9kcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLWJjbTI4MzUuYwppbmRleCAyNDFlMDhhLi5kMjA4NWRkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLWJjbTI4MzUuYworKysgYi9kcml2ZXJzL2kyYy9idXNzZXMv
aTJjLWJjbTI4MzUuYwpAQCAtNTMsOCArNTMsNiBAQAogI2RlZmluZSBCQ00yODM1X0kyQ19DRElW
X01JTgkweDAwMDIKICNkZWZpbmUgQkNNMjgzNV9JMkNfQ0RJVl9NQVgJMHhGRkZFCiAKLSNkZWZp
bmUgQkNNMjgzNV9JMkNfVElNRU9VVCAobXNlY3NfdG9famlmZmllcygxMDAwKSkKLQogc3RydWN0
IGJjbTI4MzVfaTJjX2RldiB7CiAJc3RydWN0IGRldmljZSAqZGV2OwogCXZvaWQgX19pb21lbSAq
cmVnczsKQEAgLTI0Miw3ICsyNDAsNyBAQCBzdGF0aWMgaW50IGJjbTI4MzVfaTJjX3hmZXIoc3Ry
dWN0IGkyY19hZGFwdGVyICphZGFwLCBzdHJ1Y3QgaTJjX21zZyBtc2dzW10sCiAJYmNtMjgzNV9p
MmNfc3RhcnRfdHJhbnNmZXIoaTJjX2Rldik7CiAKIAl0aW1lX2xlZnQgPSB3YWl0X2Zvcl9jb21w
bGV0aW9uX3RpbWVvdXQoJmkyY19kZXYtPmNvbXBsZXRpb24sCi0JCQkJCQlCQ00yODM1X0kyQ19U
SU1FT1VUKTsKKwkJCQkJCWFkYXAtPnRpbWVvdXQpOwogCWlmICghdGltZV9sZWZ0KSB7CiAJCWJj
bTI4MzVfaTJjX3dyaXRlbChpMmNfZGV2LCBCQ00yODM1X0kyQ19DLAogCQkJCSAgIEJDTTI4MzVf
STJDX0NfQ0xFQVIpOwotLSAKMi44LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
