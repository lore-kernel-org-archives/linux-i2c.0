From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 06/16] of: unittest: changeset helpers
Date: Thu, 22 Feb 2018 01:39:58 +0200
Message-ID: <4098480.WkPaFBmRlF@avalon>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-7-laurent.pinchart+renesas@ideasonboard.com>
 <CAL_Jsq+D4wwPSZbSXrJpwcNvB1Xth=Cn-bTyXL2RkSOb9s+d_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAL_Jsq+D4wwPSZbSXrJpwcNvB1Xth=Cn-bTyXL2RkSOb9s+d_A@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Herring <robh@kernel.org>
Cc: Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

SGkgUm9iLAoKT24gVGh1cnNkYXksIDIyIEZlYnJ1YXJ5IDIwMTggMDE6MTA6MjUgRUVUIFJvYiBI
ZXJyaW5nIHdyb3RlOgo+IE9uIFR1ZSwgRmViIDIwLCAyMDE4IGF0IDU6MTAgUE0sIExhdXJlbnQg
UGluY2hhcnQgd3JvdGU6Cj4gPiBGcm9tOiBQYW50ZWxpcyBBbnRvbmlvdSA8cGFudGVsaXMuYW50
b25pb3VAa29uc3Vsa28uY29tPgo+ID4gCj4gPiBBZGQgYSB1bml0ZXN0IHNwZWNpZmljIGZvciB0
aGUgbmV3IGNoYW5nZXNldCBoZWxwZXJzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYW50ZWxp
cyBBbnRvbmlvdSA8cGFudGVsaXMuYW50b25pb3VAa29uc3Vsa28uY29tPgo+ID4gU2lnbmVkLW9m
Zi1ieTogTGF1cmVudCBQaW5jaGFydAo+ID4gPGxhdXJlbnQucGluY2hhcnQrcmVuZXNhc0BpZGVh
c29uYm9hcmQuY29tPgo+ID4gLS0tCj4gPiAKPiA+ICBkcml2ZXJzL29mL3VuaXR0ZXN0LmMgfCA1
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvb2YvdW5pdHRlc3QuYyBiL2RyaXZlcnMvb2YvdW5pdHRlc3QuYwo+ID4gaW5kZXggN2E5YWJh
YWU4NzRkLi4xYjIxZDJjNTQ5YTggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL29mL3VuaXR0ZXN0
LmMKPiA+ICsrKyBiL2RyaXZlcnMvb2YvdW5pdHRlc3QuYwo+ID4gQEAgLTYwOSw2ICs2MDksNTkg
QEAgc3RhdGljIHZvaWQgX19pbml0IG9mX3VuaXR0ZXN0X2NoYW5nZXNldCh2b2lkKQo+ID4gCj4g
PiAgI2VuZGlmCj4gPiAgfQo+ID4gCj4gPiArc3RhdGljIHZvaWQgX19pbml0IG9mX3VuaXR0ZXN0
X2NoYW5nZXNldF9oZWxwZXIodm9pZCkKPiA+ICt7Cj4gPiArI2lmZGVmIENPTkZJR19PRl9EWU5B
TUlDCj4gCj4gSSB0aGluayB0aGlzIGNhbiBiZToKPiAKPiBpZiAoIUlTX0VOQUJMRUQoQ09ORklH
X09GX0RZTkFNSUMpKQo+ICAgcmV0dXJuOwoKTm90IHF1aXRlLCBhcyB0aGVyZSBhcmUgZnVuY3Rp
b25zIHVzZWQgYmVsb3cgKHN1Y2ggYXMgb2ZfY2hhbmdlc2V0X2luaXQoKSkgCnRoYXQgYXJlIG5v
dCBkZWZpbmVkIGlmIENPTkZJR19PRl9EWU5BTUlDIGlzbid0IGVuYWJsZWQuIFdlIGNvdWxkIGNy
ZWF0ZSBzdHVicyAKaW4gdGhhdCBjYXNlIGJ1dCBJIGJlbGlldmUgdGhhdCdzIG91dCBvZiBzY29w
ZSBmb3IgdGhpcyBwYXRjaCBzZXJpZXMuCgo+IE90aGVyd2lzZSwKPiAKPiBSZXZpZXdlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KCi0tIApSZWdhcmRzLAoKTGF1cmVudCBQaW5j
aGFydAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
