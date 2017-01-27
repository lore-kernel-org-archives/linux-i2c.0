From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 10/13] i2c: designware-baytrail: Call
 pmic_bus_access_notifier_chain
Date: Fri, 27 Jan 2017 13:35:19 +0200
Message-ID: <64668e0e-fbf3-e9ab-5c4b-546d9742a217@linux.intel.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
 <20170123210958.18410-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170123210958.18410-11-hdegoede@redhat.com>
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

T24gMDEvMjMvMjAxNyAxMTowOSBQTSwgSGFucyBkZSBHb2VkZSB3cm90ZToKPiBDYWxsIHRoZSBp
b3NmX21iaSBwbWljX2J1c19hY2Nlc3Nfbm90aWZpZXJfY2hhaW4gb24gYnVzIGFjcXVpcmUgLyBy
ZWxlYXNlLgo+Cj4gQnVnTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0xNTUyNDEKPiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPgo+IFRlc3RlZC1ieTogdGFnb3JlcmVkZHkgPHRhZ29yZS5jaGFuZGFuQGdtYWls
LmNvbT4KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+Cj4gQWNrZWQtYnk6IFdvbGZyYW0gU2FuZyA8d3NhQHRoZS1kcmVhbXMu
ZGU+Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MjoKPiAtU3BlbGxpbmc6IFAtVW5pdCwgUE1JQwo+IC0t
LQo+ICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtYmF5dHJhaWwuYyB8IDQgKysr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KCkFja2VkLWJ5OiBKYXJra28g
TmlrdWxhIDxqYXJra28ubmlrdWxhQGxpbnV4LmludGVsLmNvbT4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRl
bC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
