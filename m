From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2 8/8] ARM: bcm2835: Disable i2c2 in the Device Tree
Date: Tue, 27 Sep 2016 13:57:06 +0200
Message-ID: <1474977426-3272-9-git-send-email-noralf@tronnes.org>
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

aTJjMiBpcyBjb25uZWN0ZWQgdG8gdGhlIEhETUkgY29ubmVjdG9yIGFuZCBpcyBjb250cm9sbGVk
IGJ5IHRoZQpmaXJtd2FyZS4gRGlzYWJsZSBpdCB0byBzdGF5IG91dCBvZiBoYXJtcyB3YXkuCgpG
cm9tIHRoZSBkb3duc3RyZWFtIGNvbW1pdDoKaTJjLWJjbTI3MDgvQkNNMjcwWF9EVDogQWRkIHN1
cHBvcnQgZm9yIEkyQzIKClRoZSB0aGlyZCBJMkMgYnVzIChJMkMyKSBpcyBub3JtYWxseSByZXNl
cnZlZCBmb3IgSERNSSB1c2UuIENhcmVsZXNzCnVzZSBvZiB0aGlzIGJ1cyBjYW4gYnJlYWsgYW4g
YXR0YWNoZWQgZGlzcGxheSAtIHVzZSB3aXRoIGNhdXRpb24uCgpJdCBpcyByZWNvbW1lbmRlZCB0
byBkaXNhYmxlIGFjY2Vzc2VzIGJ5IFZpZGVvQ29yZSBieSBzZXR0aW5nCmhkbWlfaWdub3JlX2Vk
aWQ9MSBvciBoZG1pX2VkaWRfZmlsZT0xIGluIGNvbmZpZy50eHQuCgpTaWduZWQtb2ZmLWJ5OiBO
b3JhbGYgVHLDuG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4KLS0tCiBhcmNoL2FybS9ib290L2R0
cy9iY20yODM1LXJwaS5kdHNpIHwgNCAtLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9iY20yODM1LXJwaS5kdHNpIGIvYXJj
aC9hcm0vYm9vdC9kdHMvYmNtMjgzNS1ycGkuZHRzaQppbmRleCBlOWI0N2IyLi44YmZmYmVlIDEw
MDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9iY20yODM1LXJwaS5kdHNpCisrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2JjbTI4MzUtcnBpLmR0c2kKQEAgLTU5LDEwICs1OSw2IEBACiAJY2xvY2st
ZnJlcXVlbmN5ID0gPDEwMDAwMD47CiB9OwogCi0maTJjMiB7Ci0Jc3RhdHVzID0gIm9rYXkiOwot
fTsKLQogJnNkaGNpIHsKIAlzdGF0dXMgPSAib2theSI7CiAJYnVzLXdpZHRoID0gPDQ+OwotLSAK
Mi44LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
