From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 09/13] i2c: designware-baytrail: Acquire
 P-Unit access on bus acquire
Date: Fri, 27 Jan 2017 13:29:30 +0200
Message-ID: <c2721a62-a428-39bf-3f5c-0d25866f425c@linux.intel.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
 <20170123210958.18410-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170123210958.18410-10-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

T24gMDEvMjMvMjAxNyAxMTowOSBQTSwgSGFucyBkZSBHb2VkZSB3cm90ZToKPiBBY3F1aXJlIFAt
VW5pdCBhY2Nlc3MgdG8gc3RvcCBvdGhlcnMgZnJvbSBhY2Nlc3NpbmcgdGhlIFAtVW5pdCB3aGls
ZSB0aGUKPiBQTUlDIGkyYyBidXMgaXMgaW4gdXNlLiBUaGlzIGlzIG5lY2Vzc2FyeSBiZWNhdXNl
IGFjY2Vzc2luZyB0aGUgUC1Vbml0Cj4gZnJvbSB0aGUga2VybmVsIG1heSByZXN1bHQgaW4gdGhl
IFAtVW5pdCB0cnlpbmcgdG8gYWNjZXNzIHRoZSBQTUlDIGkyYwo+IGJ1cywgd2hpY2ggcmVzdWx0
cyBpbiBhIGhhbmcgd2hlbiBpdCBoYXBwZW5zIHdoaWxlIHdlIG93biB0aGUgUE1JQyBpMmMKPiBi
dXMgc2VtYXBob3JlLgo+Cj4gQnVnTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0xNTUyNDEKPiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVn
b2VkZUByZWRoYXQuY29tPgo+IFRlc3RlZC1ieTogdGFnb3JlcmVkZHkgPHRhZ29yZS5jaGFuZGFu
QGdtYWlsLmNvbT4KPiBBY2tlZC1ieTogV29sZnJhbSBTYW5nIDx3c2FAdGhlLWRyZWFtcy5kZT4K
PiAtLS0KPiBDaGFuZ2VzIGluIHYyOgo+IC1TcGVsbGluZzogUC1Vbml0LCBQTUlDCj4gLUFkanVz
dCBmb3IgaW9zZl9tYmlfcHVuaXRfbG9jay9fdW5sb2NrIHRvIF9hY3F1aXJlL19yZWxlYXNlIHJl
bmFtZQo+IC0tLQo+ICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtYmF5dHJhaWwu
YyB8IDQgKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KCkFja2VkLWJ5
OiBKYXJra28gTmlrdWxhIDxqYXJra28ubmlrdWxhQGxpbnV4LmludGVsLmNvbT4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcg
bGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
