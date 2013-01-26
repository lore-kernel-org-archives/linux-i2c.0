From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V10 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Sat, 26 Jan 2013 10:43:49 +0530
Message-ID: <CAKohpok2arxhsAt3xOxRCZZjvLMTed1EYX3ZRUSQ3733wx2mMw@mail.gmail.com>
References: <59a73d182bf1ce330becf32ad780f3501a57aed0.1359106966.git.viresh.kumar@linaro.org>
	<20130125111322.GA2649@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf300faf81f571fb04d42a1b31
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130125111322.GA2649-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--20cf300faf81f571fb04d42a1b31
Content-Type: text/plain; charset=ISO-8859-1

On 25 January 2013 16:43, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> Code-wise I am mostly satisfied, except that I need to think about
> clock-stretching a little more. We could add that later, too.

Great!!

> However, while I understand you are keen to get rid of this series ASAP,
> it seems that this eagerness results in some sloppyness which is a bit
> cumbersome (most lines changed since last time have something to comment
> on).

:(

> So, I'll try a different review style this time and let you do the
> detective work :)
>
> 1) Please be strict and consistent with spaces around operators.

Sorry, but i couldn't find any such issues in code (but were there
in a comment)

> 2) Make sure the warnings and printouts match the code
> 3) Take the printouts serious and invest a thought if they can be
> further improved.

I have looked them again and attached are the final patches.
Following are the improvements i have:

Author: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date:   Sat Jan 26 10:31:42 2013 +0530

    fixup! i2c/adapter: Add bus recovery infrastructure
---
 drivers/i2c/i2c-core.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 24c8a1e..3ec040e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -136,14 +136,14 @@ static int i2c_get_gpios_for_recovery(struct
i2c_adapter *adap)
        ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
                        GPIOF_OUT_INIT_HIGH, "i2c-scl");
        if (ret) {
-               dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
+               dev_warn(dev, "Can't get SCL gpio: %d\n", bri->scl_gpio);
                return ret;
        }

        if (bri->get_sda) {
                if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
                        /* work without SDA polling */
-                       dev_warn(dev, "can't get SDA: %d. not using
SDA polling\n",
+                       dev_warn(dev, "Can't get SDA gpio: %d. Not
using SDA polling\n",
                                        bri->sda_gpio);
                        bri->get_sda = NULL;
                }
@@ -163,8 +163,11 @@ static void i2c_put_gpios_for_recovery(struct
i2c_adapter *adap)
 }

 /*
- * We need to provide delay after every half clock pulse,
- * delay in ns = (10^6/ 100 KHz)/2
+ * We are generating clock pulse. ndelay() would decide durating of clk pulse.
+ * We will generate clock with rate 100 KHz and so duration of both
clock levels
+ * would be:
+ *
+ * delay in ns = (10^6 / 100) / 2
  */
 #define RECOVERY_CLK_CNT       9
 #define RECOVERY_NDELAY                5000
@@ -181,13 +184,13 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
         */
        while (i++ < RECOVERY_CLK_CNT * 2) {
                if (val) {
-                       /* break if SDA got high */
+                       /* Break if SDA is high */
                        if (bri->get_sda && bri->get_sda(adap))
                                        break;
                        /* SCL shouldn't be low here */
                        if (!bri->get_scl(adap)) {
                                dev_err(&adap->dev,
-                                       "SCL is stuck low exit recovery\n");
+                                       "SCL is stuck low, exit recovery\n");
                                ret = -EBUSY;
                                break;
                        }
@@ -229,7 +232,7 @@ int i2c_recover_bus(struct i2c_adapter *adap)
        if (!adap->bus_recovery_info)
                return -EOPNOTSUPP;

-       dev_dbg(&adap->dev, "trying i2c bus recovery\n");
+       dev_dbg(&adap->dev, "Trying i2c bus recovery\n");
        return adap->bus_recovery_info->recover_bus(adap);
 }

@@ -1031,12 +1034,12 @@ static int i2c_register_adapter(struct
i2c_adapter *adap)
                struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;

                if (!bri->recover_bus) {
-                       dev_err(&adap->dev, "No recover_bus(), not
using recovery\n");
+                       dev_err(&adap->dev, "No recover_bus() found,
not using recovery\n");
                        adap->bus_recovery_info = NULL;
                        goto exit_recovery;
                }

-               /* GPIO recovery */
+               /* Generic GPIO recovery */
                if (bri->recover_bus == i2c_generic_gpio_recovery) {
                        if (!gpio_is_valid(bri->scl_gpio)) {
                                dev_err(&adap->dev, "Invalid SCL gpio,
not using recovery\n");
@@ -1052,8 +1055,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
                        bri->get_scl = get_scl_gpio_value;
                        bri->set_scl = set_scl_gpio_value;
                } else if (!bri->set_scl || !bri->get_scl) {
-                       dev_warn(&adap->dev,
-                                       "set_scl() is must for SCL recovery\n");
+                       /* Generic SCL recovery */
+                       dev_err(&adap->dev, "No get[set]_gpio() found,
not using recovery\n");
+                       adap->bus_recovery_info = NULL;
                }
        }

--20cf300faf81f571fb04d42a1b31
Content-Type: application/octet-stream;
	name="0001-i2c-adapter-Add-bus-recovery-infrastructure.patch"
Content-Disposition: attachment;
	filename="0001-i2c-adapter-Add-bus-recovery-infrastructure.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hceayibk1

RnJvbSA2OGYxZGVhNWU1ODVhN2NmNGQ3MTkyMzJmZjk0YzAyYWVmODYyMGU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NjhmMWRlYTVlNTg1YTdjZjRkNzE5MjMyZmY5NGMw
MmFlZjg2MjBlNi4xMzU5MTc3MDk5LmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogVHVlLCAyOCBGZWIg
MjAxMiAxODoyNjozMSArMDUzMApTdWJqZWN0OiBbUEFUQ0ggVjExIDEvMl0gaTJjL2FkYXB0ZXI6
IEFkZCBidXMgcmVjb3ZlcnkgaW5mcmFzdHJ1Y3R1cmUKCkFkZCBpMmMgYnVzIHJlY292ZXJ5IGlu
ZnJhc3RydWN0dXJlIHRvIGkyYyBhZGFwdGVycyBhcyBzcGVjaWZpZWQgaW4gdGhlIGkyYwpwcm90
b2NvbCBSZXYuIDAzIHNlY3Rpb24gMy4xLjE2IHRpdGxlZCAiQnVzIGNsZWFyIi4KCmh0dHA6Ly93
d3cubnhwLmNvbS9kb2N1bWVudHMvdXNlcl9tYW51YWwvVU0xMDIwNC5wZGYKClNvbWV0aW1lcyBk
dXJpbmcgb3BlcmF0aW9uIGkyYyBidXMgaGFuZ3MgYW5kIHdlIG5lZWQgdG8gZ2l2ZSBkdW1teSBj
bG9ja3MgdG8Kc2xhdmUgZGV2aWNlIHRvIHN0YXJ0IHRoZSB0cmFuc2ZlciBhZ2Fpbi4gTm93IHdl
IG1heSBoYXZlIGNhcGFiaWxpdHkgaW4gdGhlIGJ1cwpjb250cm9sbGVyIHRvIGdlbmVyYXRlIHRo
ZXNlIGNsb2NrcyBvciBwbGF0Zm9ybSBtYXkgaGF2ZSBncGlvIHBpbnMgd2hpY2ggY2FuIGJlCnRv
Z2dsZWQgdG8gZ2VuZXJhdGUgZHVtbXkgY2xvY2tzLiBUaGlzIHBhdGNoIHN1cHBvcnRzIGJvdGgu
CgpUaGlzIHBhdGNoIGFsc28gYWRkcyBpbiBnZW5lcmljIGJ1cyByZWNvdmVyeSByb3V0aW5lcyBn
cGlvIG9yIHNjbCBsaW5lIGJhc2VkCndoaWNoIGNhbiBiZSB1c2VkIGJ5IGJ1cyBjb250cm9sbGVy
LiBJbiBhZGRpdGlvbiBjb250cm9sbGVyIGRyaXZlciBtYXkgcHJvdmlkZQppdHMgb3duIHZlcnNp
b24gb2YgdGhlIGJ1cyByZWNvdmVyeSByb3V0aW5lLgoKVGhpcyBkb2Vzbid0IHN1cHBvcnQgbXVs
dGktbWFzdGVyIHJlY292ZXJ5IGZvciBub3cuCgpSZXZpZXdlZC1ieTogUGF1bCBDYXJwZW50ZXIg
PHBhdWxAcGNzZXJ2aWNlc2VsZWN0cm9uaWNzLmNvLnVrPgpTaWduZWQtb2ZmLWJ5OiBWaXJlc2gg
S3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvaTJjL2kyYy1jb3Jl
LmMgfCAxNjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogaW5jbHVkZS9saW51eC9pMmMuaCAgICB8ICA0MCArKysrKysrKysrKysrCiAyIGZpbGVzIGNo
YW5nZWQsIDIwMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvaTJjLWNv
cmUuYyBiL2RyaXZlcnMvaTJjL2kyYy1jb3JlLmMKaW5kZXggZTM4ODU5MC4uM2VjMDQwZSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9pMmMvaTJjLWNvcmUuYworKysgYi9kcml2ZXJzL2kyYy9pMmMtY29y
ZS5jCkBAIC0yNyw3ICsyNyw5IEBACiAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNs
dWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUg
PGxpbnV4L2Vycm5vLmg+CisjaW5jbHVkZSA8bGludXgvZ3Bpby5oPgogI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC9pMmMuaD4KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+
CkBAIC0xMDksNiArMTExLDEzMSBAQCBzdGF0aWMgaW50IGkyY19kZXZpY2VfdWV2ZW50KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGtvYmpfdWV2ZW50X2VudiAqZW52KQogI2RlZmluZSBpMmNf
ZGV2aWNlX3VldmVudAlOVUxMCiAjZW5kaWYJLyogQ09ORklHX0hPVFBMVUcgKi8KIAorLyogaTJj
IGJ1cyByZWNvdmVyeSByb3V0aW5lcyAqLworc3RhdGljIGludCBnZXRfc2NsX2dwaW9fdmFsdWUo
c3RydWN0IGkyY19hZGFwdGVyICphZGFwKQoreworCXJldHVybiBncGlvX2dldF92YWx1ZShhZGFw
LT5idXNfcmVjb3ZlcnlfaW5mby0+c2NsX2dwaW8pOworfQorCitzdGF0aWMgdm9pZCBzZXRfc2Ns
X2dwaW9fdmFsdWUoc3RydWN0IGkyY19hZGFwdGVyICphZGFwLCBpbnQgdmFsKQoreworCWdwaW9f
c2V0X3ZhbHVlKGFkYXAtPmJ1c19yZWNvdmVyeV9pbmZvLT5zY2xfZ3BpbywgdmFsKTsKK30KKwor
c3RhdGljIGludCBnZXRfc2RhX2dwaW9fdmFsdWUoc3RydWN0IGkyY19hZGFwdGVyICphZGFwKQor
eworCXJldHVybiBncGlvX2dldF92YWx1ZShhZGFwLT5idXNfcmVjb3ZlcnlfaW5mby0+c2RhX2dw
aW8pOworfQorCitzdGF0aWMgaW50IGkyY19nZXRfZ3Bpb3NfZm9yX3JlY292ZXJ5KHN0cnVjdCBp
MmNfYWRhcHRlciAqYWRhcCkKK3sKKwlzdHJ1Y3QgaTJjX2J1c19yZWNvdmVyeV9pbmZvICpicmkg
PSBhZGFwLT5idXNfcmVjb3ZlcnlfaW5mbzsKKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmYWRhcC0+
ZGV2OworCWludCByZXQgPSAwOworCisJcmV0ID0gZ3Bpb19yZXF1ZXN0X29uZShicmktPnNjbF9n
cGlvLCBHUElPRl9PUEVOX0RSQUlOIHwKKwkJCUdQSU9GX09VVF9JTklUX0hJR0gsICJpMmMtc2Ns
Iik7CisJaWYgKHJldCkgeworCQlkZXZfd2FybihkZXYsICJDYW4ndCBnZXQgU0NMIGdwaW86ICVk
XG4iLCBicmktPnNjbF9ncGlvKTsKKwkJcmV0dXJuIHJldDsKKwl9CisKKwlpZiAoYnJpLT5nZXRf
c2RhKSB7CisJCWlmIChncGlvX3JlcXVlc3Rfb25lKGJyaS0+c2RhX2dwaW8sIEdQSU9GX0lOLCAi
aTJjLXNkYSIpKSB7CisJCQkvKiB3b3JrIHdpdGhvdXQgU0RBIHBvbGxpbmcgKi8KKwkJCWRldl93
YXJuKGRldiwgIkNhbid0IGdldCBTREEgZ3BpbzogJWQuIE5vdCB1c2luZyBTREEgcG9sbGluZ1xu
IiwKKwkJCQkJYnJpLT5zZGFfZ3Bpbyk7CisJCQlicmktPmdldF9zZGEgPSBOVUxMOworCQl9CisJ
fQorCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIHZvaWQgaTJjX3B1dF9ncGlvc19mb3JfcmVj
b3Zlcnkoc3RydWN0IGkyY19hZGFwdGVyICphZGFwKQoreworCXN0cnVjdCBpMmNfYnVzX3JlY292
ZXJ5X2luZm8gKmJyaSA9IGFkYXAtPmJ1c19yZWNvdmVyeV9pbmZvOworCisJaWYgKGJyaS0+Z2V0
X3NkYSkKKwkJZ3Bpb19mcmVlKGJyaS0+c2RhX2dwaW8pOworCisJZ3Bpb19mcmVlKGJyaS0+c2Ns
X2dwaW8pOworfQorCisvKgorICogV2UgYXJlIGdlbmVyYXRpbmcgY2xvY2sgcHVsc2UuIG5kZWxh
eSgpIHdvdWxkIGRlY2lkZSBkdXJhdGluZyBvZiBjbGsgcHVsc2UuCisgKiBXZSB3aWxsIGdlbmVy
YXRlIGNsb2NrIHdpdGggcmF0ZSAxMDAgS0h6IGFuZCBzbyBkdXJhdGlvbiBvZiBib3RoIGNsb2Nr
IGxldmVscworICogd291bGQgYmU6CisgKgorICogZGVsYXkgaW4gbnMgPSAoMTBeNiAvIDEwMCkg
LyAyCisgKi8KKyNkZWZpbmUgUkVDT1ZFUllfQ0xLX0NOVAk5CisjZGVmaW5lIFJFQ09WRVJZX05E
RUxBWQkJNTAwMAorc3RhdGljIGludCBpMmNfZ2VuZXJpY19yZWNvdmVyeShzdHJ1Y3QgaTJjX2Fk
YXB0ZXIgKmFkYXApCit7CisJc3RydWN0IGkyY19idXNfcmVjb3ZlcnlfaW5mbyAqYnJpID0gYWRh
cC0+YnVzX3JlY292ZXJ5X2luZm87CisJaW50IGkgPSAwLCB2YWwgPSAxLCByZXQgPSAwOworCisJ
aWYgKGJyaS0+cHJlcGFyZV9yZWNvdmVyeSkKKwkJYnJpLT5wcmVwYXJlX3JlY292ZXJ5KGJyaSk7
CisKKwkvKgorCSAqIEJ5IHRoaXMgdGltZSBTQ0wgaXMgaGlnaCwgYXMgd2UgbmVlZCB0byBnaXZl
IDkgZmFsbGluZy1yaXNpbmcgZWRnZXMKKwkgKi8KKwl3aGlsZSAoaSsrIDwgUkVDT1ZFUllfQ0xL
X0NOVCAqIDIpIHsKKwkJaWYgKHZhbCkgeworCQkJLyogQnJlYWsgaWYgU0RBIGlzIGhpZ2ggKi8K
KwkJCWlmIChicmktPmdldF9zZGEgJiYgYnJpLT5nZXRfc2RhKGFkYXApKQorCQkJCQlicmVhazsK
KwkJCS8qIFNDTCBzaG91bGRuJ3QgYmUgbG93IGhlcmUgKi8KKwkJCWlmICghYnJpLT5nZXRfc2Ns
KGFkYXApKSB7CisJCQkJZGV2X2VycigmYWRhcC0+ZGV2LAorCQkJCQkiU0NMIGlzIHN0dWNrIGxv
dywgZXhpdCByZWNvdmVyeVxuIik7CisJCQkJcmV0ID0gLUVCVVNZOworCQkJCWJyZWFrOworCQkJ
fQorCQl9CisKKwkJdmFsID0gIXZhbDsKKwkJYnJpLT5zZXRfc2NsKGFkYXAsIHZhbCk7CisJCW5k
ZWxheShSRUNPVkVSWV9OREVMQVkpOworCX0KKworCWlmIChicmktPnVucHJlcGFyZV9yZWNvdmVy
eSkKKwkJYnJpLT51bnByZXBhcmVfcmVjb3ZlcnkoYnJpKTsKKworCXJldHVybiByZXQ7Cit9CisK
K2ludCBpMmNfZ2VuZXJpY19zY2xfcmVjb3Zlcnkoc3RydWN0IGkyY19hZGFwdGVyICphZGFwKQor
eworCWFkYXAtPmJ1c19yZWNvdmVyeV9pbmZvLT5zZXRfc2NsKGFkYXAsIDEpOworCXJldHVybiBp
MmNfZ2VuZXJpY19yZWNvdmVyeShhZGFwKTsKK30KKworaW50IGkyY19nZW5lcmljX2dwaW9fcmVj
b3Zlcnkoc3RydWN0IGkyY19hZGFwdGVyICphZGFwKQoreworCWludCByZXQ7CisKKwlyZXQgPSBp
MmNfZ2V0X2dwaW9zX2Zvcl9yZWNvdmVyeShhZGFwKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0
OworCisJcmV0ID0gaTJjX2dlbmVyaWNfcmVjb3ZlcnkoYWRhcCk7CisJaTJjX3B1dF9ncGlvc19m
b3JfcmVjb3ZlcnkoYWRhcCk7CisKKwlyZXR1cm4gcmV0OworfQorCitpbnQgaTJjX3JlY292ZXJf
YnVzKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcCkKK3sKKwlpZiAoIWFkYXAtPmJ1c19yZWNvdmVy
eV9pbmZvKQorCQlyZXR1cm4gLUVPUE5PVFNVUFA7CisKKwlkZXZfZGJnKCZhZGFwLT5kZXYsICJU
cnlpbmcgaTJjIGJ1cyByZWNvdmVyeVxuIik7CisJcmV0dXJuIGFkYXAtPmJ1c19yZWNvdmVyeV9p
bmZvLT5yZWNvdmVyX2J1cyhhZGFwKTsKK30KKwogc3RhdGljIGludCBpMmNfZGV2aWNlX3Byb2Jl
KHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgaTJjX2NsaWVudAkqY2xpZW50ID0gaTJj
X3ZlcmlmeV9jbGllbnQoZGV2KTsKQEAgLTkwMiw2ICsxMDI5LDM5IEBAIHN0YXRpYyBpbnQgaTJj
X3JlZ2lzdGVyX2FkYXB0ZXIoc3RydWN0IGkyY19hZGFwdGVyICphZGFwKQogCQkJICJGYWlsZWQg
dG8gY3JlYXRlIGNvbXBhdGliaWxpdHkgY2xhc3MgbGlua1xuIik7CiAjZW5kaWYKIAorCS8qIGJ1
cyByZWNvdmVyeSBzcGVjaWZpYyBpbml0aWFsaXphdGlvbiAqLworCWlmIChhZGFwLT5idXNfcmVj
b3ZlcnlfaW5mbykgeworCQlzdHJ1Y3QgaTJjX2J1c19yZWNvdmVyeV9pbmZvICpicmkgPSBhZGFw
LT5idXNfcmVjb3ZlcnlfaW5mbzsKKworCQlpZiAoIWJyaS0+cmVjb3Zlcl9idXMpIHsKKwkJCWRl
dl9lcnIoJmFkYXAtPmRldiwgIk5vIHJlY292ZXJfYnVzKCkgZm91bmQsIG5vdCB1c2luZyByZWNv
dmVyeVxuIik7CisJCQlhZGFwLT5idXNfcmVjb3ZlcnlfaW5mbyA9IE5VTEw7CisJCQlnb3RvIGV4
aXRfcmVjb3Zlcnk7CisJCX0KKworCQkvKiBHZW5lcmljIEdQSU8gcmVjb3ZlcnkgKi8KKwkJaWYg
KGJyaS0+cmVjb3Zlcl9idXMgPT0gaTJjX2dlbmVyaWNfZ3Bpb19yZWNvdmVyeSkgeworCQkJaWYg
KCFncGlvX2lzX3ZhbGlkKGJyaS0+c2NsX2dwaW8pKSB7CisJCQkJZGV2X2VycigmYWRhcC0+ZGV2
LCAiSW52YWxpZCBTQ0wgZ3Bpbywgbm90IHVzaW5nIHJlY292ZXJ5XG4iKTsKKwkJCQlhZGFwLT5i
dXNfcmVjb3ZlcnlfaW5mbyA9IE5VTEw7CisJCQkJZ290byBleGl0X3JlY292ZXJ5OworCQkJfQor
CisJCQlpZiAoZ3Bpb19pc192YWxpZChicmktPnNkYV9ncGlvKSkKKwkJCQlicmktPmdldF9zZGEg
PSBnZXRfc2RhX2dwaW9fdmFsdWU7CisJCQllbHNlCisJCQkJYnJpLT5nZXRfc2RhID0gTlVMTDsK
KworCQkJYnJpLT5nZXRfc2NsID0gZ2V0X3NjbF9ncGlvX3ZhbHVlOworCQkJYnJpLT5zZXRfc2Ns
ID0gc2V0X3NjbF9ncGlvX3ZhbHVlOworCQl9IGVsc2UgaWYgKCFicmktPnNldF9zY2wgfHwgIWJy
aS0+Z2V0X3NjbCkgeworCQkJLyogR2VuZXJpYyBTQ0wgcmVjb3ZlcnkgKi8KKwkJCWRldl9lcnIo
JmFkYXAtPmRldiwgIk5vIGdldFtzZXRdX2dwaW8oKSBmb3VuZCwgbm90IHVzaW5nIHJlY292ZXJ5
XG4iKTsKKwkJCWFkYXAtPmJ1c19yZWNvdmVyeV9pbmZvID0gTlVMTDsKKwkJfQorCX0KKworZXhp
dF9yZWNvdmVyeToKIAkvKiBjcmVhdGUgcHJlLWRlY2xhcmVkIGRldmljZSBub2RlcyAqLwogCWlm
IChhZGFwLT5uciA8IF9faTJjX2ZpcnN0X2R5bmFtaWNfYnVzX251bSkKIAkJaTJjX3NjYW5fc3Rh
dGljX2JvYXJkX2luZm8oYWRhcCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2kyYy5oIGIv
aW5jbHVkZS9saW51eC9pMmMuaAppbmRleCBkMGM0ZGI3Li4wNWExOTY2IDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2kyYy5oCisrKyBiL2luY2x1ZGUvbGludXgvaTJjLmgKQEAgLTM3MCw2ICsz
NzAsNDQgQEAgc3RydWN0IGkyY19hbGdvcml0aG0gewogCXUzMiAoKmZ1bmN0aW9uYWxpdHkpIChz
dHJ1Y3QgaTJjX2FkYXB0ZXIgKik7CiB9OwogCisvKioKKyAqIHN0cnVjdCBpMmNfYnVzX3JlY292
ZXJ5X2luZm8gLSBJMkMgYnVzIHJlY292ZXJ5IGluZm9ybWF0aW9uCisgKiBAcmVjb3Zlcl9idXM6
IFJlY292ZXIgcm91dGluZS4gRWl0aGVyIHBhc3MgZHJpdmVyJ3MgcmVjb3Zlcl9idXMoKSByb3V0
aW5lLCBvcgorICoJaTJjX2dlbmVyaWNfc2NsX3JlY292ZXJ5KCkgb3IgaTJjX2dlbmVyaWNfZ3Bp
b19yZWNvdmVyeSgpLgorICogQGdldF9zY2w6IFRoaXMgZ2V0cyBjdXJyZW50IHZhbHVlIG9mIFND
TCBsaW5lLiBNYW5kYXRvcnkgZm9yIGdlbmVyaWMgU0NMCisgKiAgICAgIHJlY292ZXJ5LiBVc2Vk
IGludGVybmFsbHkgZm9yIGdlbmVyaWMgR1BJTyByZWNvdmVyeS4KKyAqIEBzZXRfc2NsOiBUaGlz
IHNldHMvY2xlYXJzIFNDTCBsaW5lLiBNYW5kYXRvcnkgZm9yIGdlbmVyaWMgU0NMIHJlY292ZXJ5
LiBVc2VkCisgKiAgICAgIGludGVybmFsbHkgZm9yIGdlbmVyaWMgR1BJTyByZWNvdmVyeS4KKyAq
IEBnZXRfc2RhOiBUaGlzIGdldHMgY3VycmVudCB2YWx1ZSBvZiBTREEgbGluZS4gT3B0aW9uYWwg
Zm9yIGdlbmVyaWMgU0NMCisgKiAgICAgIHJlY292ZXJ5LiBVc2VkIGludGVybmFsbHksIGlmIHNk
YV9ncGlvIGlzIGEgdmFsaWQgR1BJTywgZm9yIGdlbmVyaWMgR1BJTworICogICAgICByZWNvdmVy
eS4KKyAqIEBwcmVwYXJlX3JlY292ZXJ5OiBUaGlzIHdpbGwgYmUgY2FsbGVkIGJlZm9yZSBzdGFy
dGluZyByZWNvdmVyeS4gUGxhdGZvcm0gbWF5CisgKgljb25maWd1cmUgcGFkbXV4IGhlcmUgZm9y
IFNEQS9TQ0wgbGluZSBvciBzb21ldGhpbmcgZWxzZSB0aGV5IHdhbnQuCisgKiBAdW5wcmVwYXJl
X3JlY292ZXJ5OiBUaGlzIHdpbGwgYmUgY2FsbGVkIGFmdGVyIGNvbXBsZXRpbmcgcmVjb3Zlcnku
IFBsYXRmb3JtCisgKgltYXkgY29uZmlndXJlIHBhZG11eCBoZXJlIGZvciBTREEvU0NMIGxpbmUg
b3Igc29tZXRoaW5nIGVsc2UgdGhleSB3YW50LgorICogQHNjbF9ncGlvOiBncGlvIG51bWJlciBv
ZiB0aGUgU0NMIGxpbmUuIE9ubHkgcmVxdWlyZWQgZm9yIEdQSU8gcmVjb3ZlcnkuCisgKiBAc2Rh
X2dwaW86IGdwaW8gbnVtYmVyIG9mIHRoZSBTREEgbGluZS4gT25seSByZXF1aXJlZCBmb3IgR1BJ
TyByZWNvdmVyeS4KKyAqLworc3RydWN0IGkyY19idXNfcmVjb3ZlcnlfaW5mbyB7CisJaW50ICgq
cmVjb3Zlcl9idXMpKHN0cnVjdCBpMmNfYWRhcHRlciAqKTsKKworCWludCAoKmdldF9zY2wpKHN0
cnVjdCBpMmNfYWRhcHRlciAqKTsKKwl2b2lkICgqc2V0X3NjbCkoc3RydWN0IGkyY19hZGFwdGVy
ICosIGludCB2YWwpOworCWludCAoKmdldF9zZGEpKHN0cnVjdCBpMmNfYWRhcHRlciAqKTsKKwor
CXZvaWQgKCpwcmVwYXJlX3JlY292ZXJ5KShzdHJ1Y3QgaTJjX2J1c19yZWNvdmVyeV9pbmZvICpi
cmkpOworCXZvaWQgKCp1bnByZXBhcmVfcmVjb3ZlcnkpKHN0cnVjdCBpMmNfYnVzX3JlY292ZXJ5
X2luZm8gKmJyaSk7CisKKwkvKiBncGlvIHJlY292ZXJ5ICovCisJdW5zaWduZWQgc2NsX2dwaW87
CisJdW5zaWduZWQgc2RhX2dwaW87Cit9OworCisvKiBHZW5lcmljIHJlY292ZXJ5IHJvdXRpbmVz
ICovCitpbnQgaTJjX2dlbmVyaWNfZ3Bpb19yZWNvdmVyeShzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFk
YXApOworaW50IGkyY19nZW5lcmljX3NjbF9yZWNvdmVyeShzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFk
YXApOworaW50IGkyY19yZWNvdmVyX2J1cyhzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXApOworCiAv
KgogICogaTJjX2FkYXB0ZXIgaXMgdGhlIHN0cnVjdHVyZSB1c2VkIHRvIGlkZW50aWZ5IGEgcGh5
c2ljYWwgaTJjIGJ1cyBhbG9uZwogICogd2l0aCB0aGUgYWNjZXNzIGFsZ29yaXRobXMgbmVjZXNz
YXJ5IHRvIGFjY2VzcyBpdC4KQEAgLTM5Myw2ICs0MzEsOCBAQCBzdHJ1Y3QgaTJjX2FkYXB0ZXIg
ewogCiAJc3RydWN0IG11dGV4IHVzZXJzcGFjZV9jbGllbnRzX2xvY2s7CiAJc3RydWN0IGxpc3Rf
aGVhZCB1c2Vyc3BhY2VfY2xpZW50czsKKworCXN0cnVjdCBpMmNfYnVzX3JlY292ZXJ5X2luZm8g
KmJ1c19yZWNvdmVyeV9pbmZvOwogfTsKICNkZWZpbmUgdG9faTJjX2FkYXB0ZXIoZCkgY29udGFp
bmVyX29mKGQsIHN0cnVjdCBpMmNfYWRhcHRlciwgZGV2KQogCi0tIAoxLjcuMTIucmMyLjE4Lmc2
MWI0NzJlCgo=
--20cf300faf81f571fb04d42a1b31
Content-Type: application/octet-stream;
	name="0002-i2c-designware-Provide-i2c-bus-recovery-support.patch"
Content-Disposition: attachment;
	filename="0002-i2c-designware-Provide-i2c-bus-recovery-support.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hceayibo2

RnJvbSA2ZWEzZjQ0M2Y2NjhjYTg3ZGMzZWMxZjMwMjU1MWMzMGQ1MzJlNWMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NmVhM2Y0NDNmNjY4Y2E4N2RjM2VjMWYzMDI1NTFj
MzBkNTMyZTVjMS4xMzU5MTc3MDk5LmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KSW4tUmVw
bHktVG86IDw2OGYxZGVhNWU1ODVhN2NmNGQ3MTkyMzJmZjk0YzAyYWVmODYyMGU2LjEzNTkxNzcw
OTkuZ2l0LnZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPgpSZWZlcmVuY2VzOiA8NjhmMWRlYTVlNTg1
YTdjZjRkNzE5MjMyZmY5NGMwMmFlZjg2MjBlNi4xMzU5MTc3MDk5LmdpdC52aXJlc2gua3VtYXJA
bGluYXJvLm9yZz4KRnJvbTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4K
RGF0ZTogV2VkLCAyOSBGZWIgMjAxMiAyMzoxNjoxNSArMDUzMApTdWJqZWN0OiBbUEFUQ0ggVjEx
IDIvMl0gaTJjL2Rlc2lnbndhcmU6IFByb3ZpZGUgaTJjIGJ1cyByZWNvdmVyeSBzdXBwb3J0CgpB
ZGQgYnVzIHJlY292ZXJ5IHN1cHBvcnQgZm9yIGRlc2lnbndhcmVfaTJjIGNvbnRyb2xsZXIuIEl0
IHVzZXMgZ2VuZXJpYyBncGlvCmJhc2VkIGkyY19ncGlvX3JlY292ZXJfYnVzKCkgcm91dGluZS4g
UGxhdGZvcm1zIG5lZWQgdG8gcGFzcyBzdHJ1Y3QKaTJjX2J1c19yZWNvdmVyeV9pbmZvIGFzIHBs
YXRmb3JtIGRhdGEgdG8gZGVzaWdud2FyZSBJMkMgY29udHJvbGxlci4KClNpZ25lZC1vZmYtYnk6
IFZpbmNlbnpvIEZyYXNjaW5vIDx2aW5jZW56by5mcmFzY2lub0BzdC5jb20+ClNpZ25lZC1vZmYt
Ynk6IFNoaXJheiBIYXNoaW0gPHNoaXJhei5oYXNoaW1Ac3QuY29tPgpTaWduZWQtb2ZmLWJ5OiBW
aXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvaTJjL2J1
c3Nlcy9pMmMtZGVzaWdud2FyZS1jb3JlLmMgICAgfCA1ICsrKystCiBkcml2ZXJzL2kyYy9idXNz
ZXMvaTJjLWRlc2lnbndhcmUtcGxhdGRydi5jIHwgNiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1jb3JlLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRl
c2lnbndhcmUtY29yZS5jCmluZGV4IGY1MjU4YzIuLmQwNDIzZWYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1jb3JlLmMKKysrIGIvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1kZXNpZ253YXJlLWNvcmUuYwpAQCAtNTM5LDcgKzUzOSwxMCBAQCBpMmNfZHdfeGZl
cihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIHN0cnVjdCBpMmNfbXNnIG1zZ3NbXSwgaW50IG51
bSkKIAlyZXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGVfdGltZW91dCgmZGV2
LT5jbWRfY29tcGxldGUsIEhaKTsKIAlpZiAocmV0ID09IDApIHsKIAkJZGV2X2VycihkZXYtPmRl
diwgImNvbnRyb2xsZXIgdGltZWQgb3V0XG4iKTsKLQkJaTJjX2R3X2luaXQoZGV2KTsKKworCQlp
ZiAoaTJjX3JlY292ZXJfYnVzKGFkYXApIDwgMCkKKwkJCWkyY19kd19pbml0KGRldik7CisKIAkJ
cmV0ID0gLUVUSU1FRE9VVDsKIAkJZ290byBkb25lOwogCX0gZWxzZSBpZiAocmV0IDwgMCkKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1wbGF0ZHJ2LmMgYi9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtcGxhdGRydi5jCmluZGV4IDM0MzM1N2Eu
LjkxNDJmMGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1w
bGF0ZHJ2LmMKKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLXBsYXRkcnYu
YwpAQCAtMTQxLDYgKzE0MSwxMiBAQCBzdGF0aWMgaW50IGR3X2kyY19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogCWFkYXAtPmRldi5wYXJlbnQgPSAmcGRldi0+ZGV2OwogCWFk
YXAtPmRldi5vZl9ub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7CiAKKwkvKiBCdXMgcmVjb3Zlcnkg
c3VwcG9ydCAqLworCWFkYXAtPmJ1c19yZWNvdmVyeV9pbmZvID0gZGV2X2dldF9wbGF0ZGF0YSgm
cGRldi0+ZGV2KTsKKwlpZiAoYWRhcC0+YnVzX3JlY292ZXJ5X2luZm8pCisJCWFkYXAtPmJ1c19y
ZWNvdmVyeV9pbmZvLT5yZWNvdmVyX2J1cyA9CisJCQlpMmNfZ2VuZXJpY19ncGlvX3JlY292ZXJ5
OworCiAJYWRhcC0+bnIgPSBwZGV2LT5pZDsKIAlyID0gaTJjX2FkZF9udW1iZXJlZF9hZGFwdGVy
KGFkYXApOwogCWlmIChyKSB7Ci0tIAoxLjcuMTIucmMyLjE4Lmc2MWI0NzJlCgo=
--20cf300faf81f571fb04d42a1b31--
