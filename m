From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] x86/io: Include asm-generic/io.h to
	architectural code
Date: Fri, 30 Jun 2017 20:09:31 +0300
Message-ID: <20170630170934.83028-3-andriy.shevchenko@linux.intel.com>
References: <20170630170934.83028-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170630170934.83028-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@spreadtrum.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, intel-gfx@lists.freedesktop.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

YXNtLWdlbmVyaWMvaW8uaCBkZWZpbmVzIGZldyBoZWxwZXJzIHdoaWNoIHdvdWxkIGJlIHVzZWZ1
bCBpbiB0aGUgZHJpdmVycywKc3VjaCBhcyB3cml0ZXNiKCkgYW5kIHJlYWRzYigpLgoKSW5jbHVk
ZSBpdCB0byB0aGUgYXNtL2lvLmggaW4gYXJjaGl0ZWN0dXJhbCBmb2xkZXIuCgpBY2tlZC1ieTog
V29sZnJhbSBTYW5nIDx3c2FAdGhlLWRyZWFtcy5kZT4KU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2
Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Ci0tLQogYXJjaC94ODYv
aW5jbHVkZS9hc20vaW8uaCB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vaW8uaCBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2lvLmgKaW5kZXggYzFjMDg4MDc2OGY3Li4wNTU4ZDgxYzE3N2UgMTAwNjQ0Ci0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2lvLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaW8u
aApAQCAtNDA2LDYgKzQwNiw5IEBAIGV4dGVybiBib29sIHhlbl9iaW92ZWNfcGh5c19tZXJnZWFi
bGUoY29uc3Qgc3RydWN0IGJpb192ZWMgKnZlYzEsCiAKICNkZWZpbmUgSU9fU1BBQ0VfTElNSVQg
MHhmZmZmCiAKKyNpbmNsdWRlIDxhc20tZ2VuZXJpYy9pby5oPgorI3VuZGVmIFBDSV9JT0JBU0UK
KwogI2lmZGVmIENPTkZJR19NVFJSCiBleHRlcm4gaW50IF9fbXVzdF9jaGVjayBhcmNoX3BoeXNf
d2NfaW5kZXgoaW50IGhhbmRsZSk7CiAjZGVmaW5lIGFyY2hfcGh5c193Y19pbmRleCBhcmNoX3Bo
eXNfd2NfaW5kZXgKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW50ZWwtZ2Z4Cg==
