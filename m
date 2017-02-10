From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 07/12] i2c: designware-baytrail: Fix race when resetting
 the semaphore
Date: Fri, 10 Feb 2017 11:27:57 +0100
Message-ID: <20170210102802.20898-8-hdegoede@redhat.com>
References: <20170210102802.20898-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170210102802.20898-1-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

VXNlIGlvc2ZfbWJpX21vZGlmeSBpbnN0ZWFkIG9mIGlvc2ZfbWJpX3JlYWQgKyBpb3NmX21iaV93
cml0ZSBzbyB0aGF0CndlIGtlZXAgdGhlIGlvc2ZfbWJpX2xvY2sgbG9ja2VkIGR1cmluZyB0aGUg
cmVhZC1tb2RpZnktd3JpdGUgZG9uZSB0bwpyZXNldCB0aGUgc2VtYXBob3JlLgoKU2lnbmVkLW9m
Zi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IEFu
ZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgpBY2tlZC1i
eTogSmFya2tvIE5pa3VsYSA8amFya2tvLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+CkFja2VkLWJ5
OiBXb2xmcmFtIFNhbmcgPHdzYUB0aGUtZHJlYW1zLmRlPgotLS0KQ2hhbmdlcyBpbiB2NToKLU5l
dyBwYXRjaCBpbiB2NSBvZiB0aGlzIHBhdGNoLXNldAotLS0KIGRyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtZGVzaWdud2FyZS1iYXl0cmFpbC5jIHwgMTEgKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
MmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLWJheXRyYWlsLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMv
aTJjLWRlc2lnbndhcmUtYmF5dHJhaWwuYwppbmRleCA2NTBhNzAwLi44ZGY1MjljIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtYmF5dHJhaWwuYworKysgYi9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtYmF5dHJhaWwuYwpAQCAtNDcsMTUgKzQ3
LDggQEAgc3RhdGljIGludCBnZXRfc2VtKHN0cnVjdCBkd19pMmNfZGV2ICpkZXYsIHUzMiAqc2Vt
KQogCiBzdGF0aWMgdm9pZCByZXNldF9zZW1hcGhvcmUoc3RydWN0IGR3X2kyY19kZXYgKmRldikK
IHsKLQl1MzIgZGF0YTsKLQotCWlmIChpb3NmX21iaV9yZWFkKEJUX01CSV9VTklUX1BNQywgTUJJ
X1JFR19SRUFELCBQVU5JVF9TRU1BUEhPUkUsICZkYXRhKSkgewotCQlkZXZfZXJyKGRldi0+ZGV2
LCAiaW9zZiBmYWlsZWQgdG8gcmVzZXQgcHVuaXQgc2VtYXBob3JlIGR1cmluZyByZWFkXG4iKTsK
LQkJcmV0dXJuOwotCX0KLQotCWRhdGEgJj0gflBVTklUX1NFTUFQSE9SRV9CSVQ7Ci0JaWYgKGlv
c2ZfbWJpX3dyaXRlKEJUX01CSV9VTklUX1BNQywgTUJJX1JFR19XUklURSwgUFVOSVRfU0VNQVBI
T1JFLCBkYXRhKSkKKwlpZiAoaW9zZl9tYmlfbW9kaWZ5KEJUX01CSV9VTklUX1BNQywgTUJJX1JF
R19SRUFELCBQVU5JVF9TRU1BUEhPUkUsCisJCQkgICAgMCwgUFVOSVRfU0VNQVBIT1JFX0JJVCkp
CiAJCWRldl9lcnIoZGV2LT5kZXYsICJpb3NmIGZhaWxlZCB0byByZXNldCBwdW5pdCBzZW1hcGhv
cmUgZHVyaW5nIHdyaXRlXG4iKTsKIAogCXBtX3Fvc191cGRhdGVfcmVxdWVzdCgmZGV2LT5wbV9x
b3MsIFBNX1FPU19ERUZBVUxUX1ZBTFVFKTsKLS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
