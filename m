From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 09/12] i2c: designware-baytrail: Acquire
	P-Unit access on bus acquire
Date: Fri, 10 Feb 2017 11:27:59 +0100
Message-ID: <20170210102802.20898-10-hdegoede@redhat.com>
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

QWNxdWlyZSBQLVVuaXQgYWNjZXNzIHRvIHN0b3Agb3RoZXJzIGZyb20gYWNjZXNzaW5nIHRoZSBQ
LVVuaXQgd2hpbGUgdGhlClBNSUMgaTJjIGJ1cyBpcyBpbiB1c2UuIFRoaXMgaXMgbmVjZXNzYXJ5
IGJlY2F1c2UgYWNjZXNzaW5nIHRoZSBQLVVuaXQKZnJvbSB0aGUga2VybmVsIG1heSByZXN1bHQg
aW4gdGhlIFAtVW5pdCB0cnlpbmcgdG8gYWNjZXNzIHRoZSBQTUlDIGkyYwpidXMsIHdoaWNoIHJl
c3VsdHMgaW4gYSBoYW5nIHdoZW4gaXQgaGFwcGVucyB3aGlsZSB3ZSBvd24gdGhlIFBNSUMgaTJj
CmJ1cyBzZW1hcGhvcmUuCgpCdWdMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hv
d19idWcuY2dpP2lkPTE1NTI0MQpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2Vk
ZUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IHRhZ29yZXJlZGR5IDx0YWdvcmUuY2hhbmRhbkBnbWFp
bC5jb20+CkFja2VkLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYUB0aGUtZHJlYW1zLmRlPgpBY2tlZC1i
eTogSmFya2tvIE5pa3VsYSA8amFya2tvLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+Ci0tLQpDaGFu
Z2VzIGluIHYyOgotU3BlbGxpbmc6IFAtVW5pdCwgUE1JQwotQWRqdXN0IGZvciBpb3NmX21iaV9w
dW5pdF9sb2NrL191bmxvY2sgdG8gX2FjcXVpcmUvX3JlbGVhc2UgcmVuYW1lCi0tLQogZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLWJheXRyYWlsLmMgfCA0ICsrKysKIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMv
aTJjLWRlc2lnbndhcmUtYmF5dHJhaWwuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdu
d2FyZS1iYXl0cmFpbC5jCmluZGV4IDNlZmZjOWEuLjdlZGRjM2IgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1iYXl0cmFpbC5jCisrKyBiL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1iYXl0cmFpbC5jCkBAIC02Miw2ICs2Miw4IEBAIHN0YXRp
YyB2b2lkIHJlc2V0X3NlbWFwaG9yZShzdHJ1Y3QgZHdfaTJjX2RldiAqZGV2KQogCQlkZXZfZXJy
KGRldi0+ZGV2LCAiaW9zZiBmYWlsZWQgdG8gcmVzZXQgcHVuaXQgc2VtYXBob3JlIGR1cmluZyB3
cml0ZVxuIik7CiAKIAlwbV9xb3NfdXBkYXRlX3JlcXVlc3QoJmRldi0+cG1fcW9zLCBQTV9RT1Nf
REVGQVVMVF9WQUxVRSk7CisKKwlpb3NmX21iaV9wdW5pdF9yZWxlYXNlKCk7CiB9CiAKIHN0YXRp
YyBpbnQgYmF5dHJhaWxfaTJjX2FjcXVpcmUoc3RydWN0IGR3X2kyY19kZXYgKmRldikKQEAgLTc5
LDYgKzgxLDggQEAgc3RhdGljIGludCBiYXl0cmFpbF9pMmNfYWNxdWlyZShzdHJ1Y3QgZHdfaTJj
X2RldiAqZGV2KQogCWlmICghZGV2LT5yZWxlYXNlX2xvY2spCiAJCXJldHVybiAwOwogCisJaW9z
Zl9tYmlfcHVuaXRfYWNxdWlyZSgpOworCiAJLyoKIAkgKiBEaXNhbGxvdyB0aGUgQ1BVIHRvIGVu
dGVyIEM2IG9yIEM3IHN0YXRlLCBlbnRlcmluZyB0aGVzZSBzdGF0ZXMKIAkgKiByZXF1aXJlcyB0
aGUgcHVuaXQgdG8gdGFsayB0byB0aGUgcG1pYyBhbmQgaWYgdGhpcyBoYXBwZW5zIHdoaWxlCi0t
IAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
SW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
