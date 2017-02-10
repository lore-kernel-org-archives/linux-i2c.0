From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 05/12] i2c: designware-baytrail: Only check
	iosf_mbi_available() for shared hosts
Date: Fri, 10 Feb 2017 11:27:55 +0100
Message-ID: <20170210102802.20898-6-hdegoede@redhat.com>
References: <20170210102802.20898-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170210102802.20898-1-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

SWYgKCFzaGFyZWRfaG9zdCkgc2ltcGx5IHJldHVybiAwLCB0aGlzIGF2b2lkcyBkZWxheWluZyB0
aGUgcHJvYmUgaWYKaW9zZl9tYmlfYXZhaWxhYmxlKCkgcmV0dXJucyBmYWxzZSB3aGVuIGFuIGky
YyBidXMgaXMgbm90IHVzaW5nIHRoZQpwdW5pdCBzZW1hcGhvcmUuCgpBbHNvIG1vdmUgdGhlIGlm
ICghaW9zZl9tYmlfYXZhaWxhYmxlKCkpIGNoZWNrIHRvIGFib3ZlIHRoZQpkZXZfaW5mbywgc28g
dGhhdCB3ZSBkbyBub3QgcmVwZWF0IHRoZSBkZXZfaW5mbyBvbiBldmVyeSBwcm9iZQp1bnRpbCBp
b3NmX21iaV9hdmFpbGFibGUoKSByZXR1cm5zIHRydWUuCgpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRl
IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+CkFja2VkLWJ5OiBKYXJra28gTmlr
dWxhIDxqYXJra28ubmlrdWxhQGxpbnV4LmludGVsLmNvbT4KVGVzdGVkLWJ5OiBUYWthc2hpIEl3
YWkgPHRpd2FpQHN1c2UuZGU+CkFja2VkLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYUB0aGUtZHJlYW1z
LmRlPgotLS0KQ2hhbmdlcyBpbiB2MjoKLU5ldyBwYXRjaCBpbiB2MiBvZiB0aGlzIHNldApDaGFu
Z2VzIGluIHYzOgotVXNlIGlmICghc2hhcmVkX2hvc3QpIHJldHVybiAwLCB0byBzaW1wbGlmeSB0
aGUgbm9uLXNoYXJlZF9ob3N0IHBhdGgKIGFuZCB0byBhdm9pZCBuZXN0ZWQgaWZzCi0tLQogZHJp
dmVycy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLWJheXRyYWlsLmMgfCAxMyArKysrKysrLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1iYXl0cmFpbC5jIGIv
ZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLWJheXRyYWlsLmMKaW5kZXggYTNmNTgx
Yy4uY2YwMjIyMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJl
LWJheXRyYWlsLmMKKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLWJheXRy
YWlsLmMKQEAgLTEzOCwxNSArMTM4LDE2IEBAIGludCBpMmNfZHdfZXZhbF9sb2NrX3N1cHBvcnQo
c3RydWN0IGR3X2kyY19kZXYgKmRldikKIAlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpCiAJCXJl
dHVybiAwOwogCi0JaWYgKHNoYXJlZF9ob3N0KSB7Ci0JCWRldl9pbmZvKGRldi0+ZGV2LCAiSTJD
IGJ1cyBtYW5hZ2VkIGJ5IFBVTklUXG4iKTsKLQkJZGV2LT5hY3F1aXJlX2xvY2sgPSBiYXl0cmFp
bF9pMmNfYWNxdWlyZTsKLQkJZGV2LT5yZWxlYXNlX2xvY2sgPSBiYXl0cmFpbF9pMmNfcmVsZWFz
ZTsKLQkJZGV2LT5wbV9ydW50aW1lX2Rpc2FibGVkID0gdHJ1ZTsKLQl9CisJaWYgKCFzaGFyZWRf
aG9zdCkKKwkJcmV0dXJuIDA7CiAKIAlpZiAoIWlvc2ZfbWJpX2F2YWlsYWJsZSgpKQogCQlyZXR1
cm4gLUVQUk9CRV9ERUZFUjsKIAorCWRldl9pbmZvKGRldi0+ZGV2LCAiSTJDIGJ1cyBtYW5hZ2Vk
IGJ5IFBVTklUXG4iKTsKKwlkZXYtPmFjcXVpcmVfbG9jayA9IGJheXRyYWlsX2kyY19hY3F1aXJl
OworCWRldi0+cmVsZWFzZV9sb2NrID0gYmF5dHJhaWxfaTJjX3JlbGVhc2U7CisJZGV2LT5wbV9y
dW50aW1lX2Rpc2FibGVkID0gdHJ1ZTsKKwogCXJldHVybiAwOwogfQotLSAKMi45LjMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWls
aW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
