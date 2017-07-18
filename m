From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/5] x86/io: Rely on asm-generic/io.h
Date: Tue, 18 Jul 2017 18:52:53 +0300
Message-ID: <1500393173.29303.84.camel@linux.intel.com>
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
List-Id: linux-i2c@vger.kernel.org

T24gRnJpLCAyMDE3LTA2LTMwIGF0IDIwOjA5ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gVGhlIHNlcmllcyBicmluZ3MgYSBiaXQgb2Ygb3JkZXIgdG8gYXJjaC94ODYvaW5jbHVkZS9h
c20vaW8uaCBieSByZS0KPiB1c2luZwo+IGRlZmluaXRpb25zIGluIHRoZSBnZW5lcmljIGhlYWRl
ci4KPiAKPiBUaGUgc2VyaWVzIGhhcyBiZWVuIHRlc3RlZCBvbiBJbnRlbCBCcm94dG9uIGhhcmR3
YXJlIGluIDMyLSBhbmQgNjQtYml0IAo+IG1vZGVzLgoKQW55IGNvbW1lbnRzPwpTaGFsbCBJIHJl
c2VuZCB0aGlzPwoKPiAKPiBTaW5jZSB2MjoKPiAtIGFkZCBjbGVhbnVwIHBhdGNoZXMgaW4gYWNj
b3JkYW5jZSB0byByZS11c2Ugd2hhdCdzIGRlZmluZWQgaW4KPiBnZW5lcmljIGhlYWRlcgo+IC0g
c3BsaXQgdG8gZmV3IHBhdGNoZXMKPiAtIGhvcGVmdWxseSBuYWlsIGRvd24gYW4gaXNzdWUga2J1
aWxkIGJvdCBjb21wbGFpbmVkIGFib3V0Cj4gLSBhcHBlbmQgdGFncyAoV29sZnJhbSkKPiAKPiBB
bmR5IFNoZXZjaGVua28gKDUpOgo+IMKgIHg4Ni9pbzogRGVmaW5lIElPIGFjY2Vzc29ycyBieSBw
cmVwcm9jZXNzb3IKPiDCoCB4ODYvaW86IEluY2x1ZGUgYXNtLWdlbmVyaWMvaW8uaCB0byBhcmNo
aXRlY3R1cmFsIGNvZGUKPiDCoCB4ODYvaW86IFJlbW92ZSBtZW0qaW8oKSBkdXBsaWNhdGlvbnMK
PiDCoCB4ODYvaW86IFJlbW92ZSB4bGF0ZV9kZXZfa21lbV9wdHIoKSBkdXBsaWNhdGlvbgo+IMKg
IHg4Ni9pbzogTWFrZSByZWFkcSgpIC8gd3JpdGVxKCkgQVBJIGNvbnNpc3RlbnQKPiAKPiDCoGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2lvLmggfCA5OCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLQo+IC0tLS0tLS0tLQo+IMKgaW5jbHVkZS9hc20tZ2VuZXJpYy9pby5owqDCoHwg
MjcgKysrKysrKysrKysrKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCA1
MSBkZWxldGlvbnMoLSkKPiAKCi0tIApBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbT4KSW50ZWwgRmlubGFuZCBPeQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9pbnRlbC1nZngK
