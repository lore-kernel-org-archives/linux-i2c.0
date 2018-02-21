From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 06/16] of: unittest: changeset helpers
Date: Wed, 21 Feb 2018 17:49:10 -0600
Message-ID: <CAL_JsqLR06_1=39JUXOyrSPP-p3LssWasZz2m=cgoHKaXh=Mhw@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-7-laurent.pinchart+renesas@ideasonboard.com>
 <CAL_Jsq+D4wwPSZbSXrJpwcNvB1Xth=Cn-bTyXL2RkSOb9s+d_A@mail.gmail.com>
 <4098480.WkPaFBmRlF@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <4098480.WkPaFBmRlF@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

T24gV2VkLCBGZWIgMjEsIDIwMTggYXQgNTozOSBQTSwgTGF1cmVudCBQaW5jaGFydAo8bGF1cmVu
dC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPiB3cm90ZToKPiBIaSBSb2IsCj4KPiBPbiBUaHVy
c2RheSwgMjIgRmVicnVhcnkgMjAxOCAwMToxMDoyNSBFRVQgUm9iIEhlcnJpbmcgd3JvdGU6Cj4+
IE9uIFR1ZSwgRmViIDIwLCAyMDE4IGF0IDU6MTAgUE0sIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6
Cj4+ID4gRnJvbTogUGFudGVsaXMgQW50b25pb3UgPHBhbnRlbGlzLmFudG9uaW91QGtvbnN1bGtv
LmNvbT4KPj4gPgo+PiA+IEFkZCBhIHVuaXRlc3Qgc3BlY2lmaWMgZm9yIHRoZSBuZXcgY2hhbmdl
c2V0IGhlbHBlcnMuCj4+ID4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBQYW50ZWxpcyBBbnRvbmlvdSA8
cGFudGVsaXMuYW50b25pb3VAa29uc3Vsa28uY29tPgo+PiA+IFNpZ25lZC1vZmYtYnk6IExhdXJl
bnQgUGluY2hhcnQKPj4gPiA8bGF1cmVudC5waW5jaGFydCtyZW5lc2FzQGlkZWFzb25ib2FyZC5j
b20+Cj4+ID4gLS0tCj4+ID4KPj4gPiAgZHJpdmVycy9vZi91bml0dGVzdC5jIHwgNTQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiA+ICAxIGZpbGUgY2hh
bmdlZCwgNTQgaW5zZXJ0aW9ucygrKQo+PiA+Cj4+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvb2Yv
dW5pdHRlc3QuYyBiL2RyaXZlcnMvb2YvdW5pdHRlc3QuYwo+PiA+IGluZGV4IDdhOWFiYWFlODc0
ZC4uMWIyMWQyYzU0OWE4IDEwMDY0NAo+PiA+IC0tLSBhL2RyaXZlcnMvb2YvdW5pdHRlc3QuYwo+
PiA+ICsrKyBiL2RyaXZlcnMvb2YvdW5pdHRlc3QuYwo+PiA+IEBAIC02MDksNiArNjA5LDU5IEBA
IHN0YXRpYyB2b2lkIF9faW5pdCBvZl91bml0dGVzdF9jaGFuZ2VzZXQodm9pZCkKPj4gPgo+PiA+
ICAjZW5kaWYKPj4gPiAgfQo+PiA+Cj4+ID4gK3N0YXRpYyB2b2lkIF9faW5pdCBvZl91bml0dGVz
dF9jaGFuZ2VzZXRfaGVscGVyKHZvaWQpCj4+ID4gK3sKPj4gPiArI2lmZGVmIENPTkZJR19PRl9E
WU5BTUlDCj4+Cj4+IEkgdGhpbmsgdGhpcyBjYW4gYmU6Cj4+Cj4+IGlmICghSVNfRU5BQkxFRChD
T05GSUdfT0ZfRFlOQU1JQykpCj4+ICAgcmV0dXJuOwo+Cj4gTm90IHF1aXRlLCBhcyB0aGVyZSBh
cmUgZnVuY3Rpb25zIHVzZWQgYmVsb3cgKHN1Y2ggYXMgb2ZfY2hhbmdlc2V0X2luaXQoKSkKPiB0
aGF0IGFyZSBub3QgZGVmaW5lZCBpZiBDT05GSUdfT0ZfRFlOQU1JQyBpc24ndCBlbmFibGVkLiBX
ZSBjb3VsZCBjcmVhdGUgc3R1YnMKPiBpbiB0aGF0IGNhc2UgYnV0IEkgYmVsaWV2ZSB0aGF0J3Mg
b3V0IG9mIHNjb3BlIGZvciB0aGlzIHBhdGNoIHNlcmllcy4KCk9rYXkuIEkgdGhvdWdodCB3ZSBo
YWQgdGhlIG5lY2Vzc2FyeSBzdHVicywgYnV0IGRpZG4ndCBjaGVjayB0b28gY2xvc2VseS4KCj4K
Pj4gT3RoZXJ3aXNlLAo+Pgo+PiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4KPgo+IC0tCj4gUmVnYXJkcywKPgo+IExhdXJlbnQgUGluY2hhcnQKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
