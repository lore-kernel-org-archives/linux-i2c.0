From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2 6/8] i2c: bcm2835: Support i2c-dev ioctl I2C_TIMEOUT
Date: Tue, 27 Sep 2016 13:57:04 +0200
Message-ID: <1474977426-3272-7-git-send-email-noralf@tronnes.org>
References: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
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
w7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Ci0tLQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1i
Y20yODM1LmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWJjbTI4MzUuYyBi
L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtMjgzNS5jCmluZGV4IGYzYTE0NzIuLjc5ZGQxNWYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtMjgzNS5jCisrKyBiL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtYmNtMjgzNS5jCkBAIC01Myw4ICs1Myw2IEBACiAjZGVmaW5lIEJD
TTI4MzVfSTJDX0NESVZfTUlOCTB4MDAwMgogI2RlZmluZSBCQ00yODM1X0kyQ19DRElWX01BWAkw
eEZGRkUKIAotI2RlZmluZSBCQ00yODM1X0kyQ19USU1FT1VUIChtc2Vjc190b19qaWZmaWVzKDEw
MDApKQotCiBzdHJ1Y3QgYmNtMjgzNV9pMmNfZGV2IHsKIAlzdHJ1Y3QgZGV2aWNlICpkZXY7CiAJ
dm9pZCBfX2lvbWVtICpyZWdzOwpAQCAtMjMzLDcgKzIzMSw3IEBAIHN0YXRpYyBpbnQgYmNtMjgz
NV9pMmNfeGZlcihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIHN0cnVjdCBpMmNfbXNnIG1zZ3Nb
XSwKIAliY20yODM1X2kyY19zdGFydF90cmFuc2ZlcihpMmNfZGV2KTsKIAogCXRpbWVfbGVmdCA9
IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmaTJjX2Rldi0+Y29tcGxldGlvbiwKLQkJCQkJ
CUJDTTI4MzVfSTJDX1RJTUVPVVQpOworCQkJCQkJYWRhcC0+dGltZW91dCk7CiAJaWYgKCF0aW1l
X2xlZnQpIHsKIAkJYmNtMjgzNV9pMmNfd3JpdGVsKGkyY19kZXYsIEJDTTI4MzVfSTJDX0MsCiAJ
CQkJICAgQkNNMjgzNV9JMkNfQ19DTEVBUik7Ci0tIAoyLjguMgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
