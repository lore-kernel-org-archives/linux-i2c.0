From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 10/12] i2c: designware-baytrail: Call
	pmic_bus_access_notifier_chain
Date: Fri, 24 Feb 2017 10:29:10 +0100
Message-ID: <20170224092912.10685-11-hdegoede@redhat.com>
References: <20170224092912.10685-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170224092912.10685-1-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Q2FsbCB0aGUgaW9zZl9tYmkgcG1pY19idXNfYWNjZXNzX25vdGlmaWVyX2NoYWluIG9uIGJ1cyBh
Y3F1aXJlIC8gcmVsZWFzZS4KCkJ1Z0xpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MTU1MjQxClNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdv
ZWRlQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogdGFnb3JlcmVkZHkgPHRhZ29yZS5jaGFuZGFuQGdt
YWlsLmNvbT4KUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29A
bGludXguaW50ZWwuY29tPgpBY2tlZC1ieTogV29sZnJhbSBTYW5nIDx3c2FAdGhlLWRyZWFtcy5k
ZT4KQWNrZWQtYnk6IEphcmtrbyBOaWt1bGEgPGphcmtrby5uaWt1bGFAbGludXguaW50ZWwuY29t
PgotLS0KQ2hhbmdlcyBpbiB2MjoKLVNwZWxsaW5nOiBQLVVuaXQsIFBNSUMKLS0tCiBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtYmF5dHJhaWwuYyB8IDQgKysrKwogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtZGVzaWdud2FyZS1iYXl0cmFpbC5jIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253
YXJlLWJheXRyYWlsLmMKaW5kZXggN2VkZGMzYi4uMTc0OWEwZiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLWJheXRyYWlsLmMKKysrIGIvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1kZXNpZ253YXJlLWJheXRyYWlsLmMKQEAgLTYzLDYgKzYzLDggQEAgc3RhdGlj
IHZvaWQgcmVzZXRfc2VtYXBob3JlKHN0cnVjdCBkd19pMmNfZGV2ICpkZXYpCiAKIAlwbV9xb3Nf
dXBkYXRlX3JlcXVlc3QoJmRldi0+cG1fcW9zLCBQTV9RT1NfREVGQVVMVF9WQUxVRSk7CiAKKwlp
b3NmX21iaV9jYWxsX3BtaWNfYnVzX2FjY2Vzc19ub3RpZmllcl9jaGFpbihNQklfUE1JQ19CVVNf
QUNDRVNTX0VORCwKKwkJCQkJCSAgICAgTlVMTCk7CiAJaW9zZl9tYmlfcHVuaXRfcmVsZWFzZSgp
OwogfQogCkBAIC04Miw2ICs4NCw4IEBAIHN0YXRpYyBpbnQgYmF5dHJhaWxfaTJjX2FjcXVpcmUo
c3RydWN0IGR3X2kyY19kZXYgKmRldikKIAkJcmV0dXJuIDA7CiAKIAlpb3NmX21iaV9wdW5pdF9h
Y3F1aXJlKCk7CisJaW9zZl9tYmlfY2FsbF9wbWljX2J1c19hY2Nlc3Nfbm90aWZpZXJfY2hhaW4o
TUJJX1BNSUNfQlVTX0FDQ0VTU19CRUdJTiwKKwkJCQkJCSAgICAgTlVMTCk7CiAKIAkvKgogCSAq
IERpc2FsbG93IHRoZSBDUFUgdG8gZW50ZXIgQzYgb3IgQzcgc3RhdGUsIGVudGVyaW5nIHRoZXNl
IHN0YXRlcwotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lu
dGVsLWdmeAo=
