From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
Date: Sun, 27 Jan 2019 13:26:35 +0100
Message-ID: <CAMpxmJW+ODrqCTSaQMOgRG2d3Qy2SipzYQU3JRPbJE_Wn85H0w@mail.gmail.com>
References: <20190108091539.16674-1-brgl@bgdev.pl>
 <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
 <20190122122228.GA2736@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190122122228.GA2736@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, LKML <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

d3QuLCAyMiBzdHkgMjAxOSBvIDEzOjIyIEdyZWcgS3JvYWgtSGFydG1hbgo8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IG5hcGlzYcWCKGEpOgo+Cj4gT24gVGh1LCBKYW4gMTAsIDIwMTkgYXQg
MDc6NDM6NDdQTSArMDUzMCwgU2VraGFyIE5vcmkgd3JvdGU6Cj4gPiBIaSBCYXJ0b3N6LAo+ID4K
PiA+IE9uIDA4LzAxLzE5IDI6NDUgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6Cj4gPiA+
IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4g
PiA+Cj4gPiA+IEhpIFNla2hhciwKPiA+ID4KPiA+ID4gbm93IHRoYXQgYWxsIGRlcGVuZGVuY2ll
cyBhcmUgaW4gYW5kIHY1LjAtcmMxIGlzIHRhZ2dlZCwgcGxlYXNlIGNvbnNpZGVyCj4gPiA+IHBp
Y2tpbmcgdXAgdGhlIHNlY29uZCBiYXRjaCBvZiBkYXZpbmNpLXNwZWNpZmljIGNoYW5nZXMgaW50
byB5b3VyIHRyZWUuCj4gPiA+IE9uY2UgdGhhdCdzIGRvbmUsIHBsZWFzZSBwcm92aWRlIG1lIHdp
dGggYW4gaW1tdXRhYmxlIGJyYW5jaCBmb3IgbWUgdG8KPiA+ID4gYXBwbHkgdGhlIGxhc3QgcGF0
Y2ggdG8gbXkgYXQyNCB0cmVlLgo+ID4KPiA+IFlvdSBjYW4gdXNlIGJyYW5jaCB2NS4xL2VlcHJv
bS1mb3ItYmFydG9zeiBpbiBteSB0cmVlIGZvciB0aGlzIChjb21taXQKPiA+IGU0MzA2ODVmNDk2
OSkuCj4gPgo+ID4gPgo+ID4gPiBUaGlzIGlzIHRoZSBzZWNvbmQgcGFydCBvZiB0aGUgZWZmb3J0
IHRvIG1vZGVybml6ZSB0aGUgYXQyNCBkcml2ZXIgYW5kCj4gPiA+IHJlbW92ZSB0aGUgbGVnYWN5
IHBsYXRmb3JtIGRhdGEgc3RydWN0dXJlIGluIGZhdm9yIG9mIGRldmljZSBwcm9wZXJ0aWVzLgo+
ID4gPiBJdCByZXF1aXJlZCBnZXR0aW5nIHJpZCBvZiB0aGUgYXQyNCBzZXR1cCBjYWxsYmFjayBp
biBmYXZvciBvZiBudm1lbQo+ID4gPiBsb29rdXBzLgo+ID4gPgo+ID4gPiBSZS10ZXN0ZWQgd2l0
aCBkYTg1MC1ldm0gYW5kIGRtMzY1LWV2bS4KPiA+Cj4gPiBBcHBsaWVkIHBhdGNoZXMgMS0xMSBm
b3IgdjUuMQo+Cj4gRmVlbCBmcmVlIHRvIHRha2UgcGF0Y2ggMTIgYXMgd2VsbCA6KQoKSGkgR3Jl
ZywKCkkgdG9vayBvdmVyIHRoZSBhdDI0IGRyaXZlciBmcm9tIFdvbGZyYW0gU2FuZy4gSSBjb2xs
ZWN0IHBhdGNoZXMgZm9yCml0IGluIG15IGJyYW5jaCBhbmQgdGhlbiBzZW5kIHB1bGwtcmVxdWVz
dHMgdG8gV29sZnJhbSBkaXJlY3RseS4gSSd2ZQphcHBsaWVkIHRoaXMgcGF0Y2ggdG8gbXkgYnJh
bmNoIGluIGNhc2UgdGhlcmUncyBzb21lIG1vcmUgZGV2ZWxvcG1lbnQKZm9yIGF0MjQgaW4gdGhp
cyBjeWNsZS4gU2VraGFyIHByb3ZpZGVkIG1lIHdpdGggYW4gaW1tdXRhYmxlIGJyYW5jaAp3aXRo
IHRoZSBhcmNoIGNvbW1pdHMgSSBtZXJnZWQgaW4uCgpCZXN0IHJlZ2FyZHMsCkJhcnRvc3ogR29s
YXN6ZXdza2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
