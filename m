From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] drm/bridge/sii902x: Fix EDID readback
Date: Thu, 15 Nov 2018 11:13:52 +0100
Message-ID: <CACRpkda+YcxCOQeSo=2Jk5S2b4Sa7WcROeaJitzgPcBzM1qBrA@mail.gmail.com>
References: <1541505156-8097-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1541505156-8097-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Dave Airlie <airlied@linux.ie>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

T24gVHVlLCBOb3YgNiwgMjAxOCBhdCAxMjo1MiBQTSBGYWJyaXppbyBDYXN0cm8KPGZhYnJpemlv
LmNhc3Ryb0BicC5yZW5lc2FzLmNvbT4gd3JvdGU6Cgo+IFdoaWxlIGFkZGluZyBTaUk5MDIyQSBz
dXBwb3J0IHRvIHRoZSBpd2cyM3MgYm9hcmQsIGl0IGNhbWUKPiB1cCB0aGF0IHdoZW4gdGhlIEhE
TUkgdHJhbnNtaXR0ZXIgaXMgaW4gcGFzcyB0aHJvdWdoIG1vZGUgdGhlCj4gZGV2aWNlIGlzIG5v
dCBjb21wbGlhbnQgd2l0aCB0aGUgSTJDIHNwZWNpZmljYXRpb24gYW55bW9yZSwKPiBhcyBpdCBy
ZXF1aXJlcyBhIGZhciBiaWdnZXIgdGJ1ZiwgZHVlIHRvIGEgZGVsYXkgdGhlIEhETUkKPiB0cmFu
c21pdHRlciBpcyBhZGRpbmcgd2hlbiByZWxheWluZyB0aGUgU1RPUCBjb25kaXRpb24gb24gdGhl
Cj4gbW9uaXRvciBpMmMgc2lkZSBvZiB0aGluZ3MuCj4KPiBXaGVuIG5vdCBwcm92aWRpbmcgYW4g
YXBwcm9wcmlhdGUgZGVsYXkgYWZ0ZXIgdGhlIFNUT1AgY29uZGl0aW9uCj4gdGhlIGkyYyBidXMg
d291bGQgZ2V0IHN0dWNrLiBBbHNvLCBhbnkgb3RoZXIgdHJhZmZpYyBvbiB0aGUgYnVzCj4gd2hp
bGUgdGFsa2luZyB0byB0aGUgbW9uaXRvciBtYXkgY2F1c2UgdGhlIHRyYW5zYWN0aW9uIHRvIGZh
aWwKPiBvciBldmVuIGNhdXNlIGlzc3VlcyB3aXRoIHRoZSBpMmMgYnVzIGFzIHdlbGwuCj4KPiBJ
MmMtZ2F0ZXMgc2VlbWVkIHRvIHJlYWNoIGNvbnNlbnQgYXMgYSBwb3NzaWJsZSB3YXkgdG8gYWRk
cmVzcwo+IHRoZXNlIGlzc3VlcywgYW5kIGFzIHN1Y2ggdGhpcyBwYXRjaCBpcyBpbXBsZW1lbnRp
bmcgYSBzb2x1dGlvbgo+IGJhc2VkIG9uIHRoYXQuIFNpbmNlIG90aGVycyBhcmUgY2xlYXJseSBy
ZWx5aW5nIG9uIHRoZSBjdXJyZW50Cj4gaW1wbGVtZW50YXRpb24gb2YgdGhlIGRyaXZlciwgdGhp
cyBwYXRjaCB3b24ndCByZXF1aXJlIGFueSBEVAo+IGNoYW5nZXMuCj4KPiBTaW5jZSB3ZSBkb24n
dCB3YW50IGFueSBpbnRlcmZlcmVuY2UgZHVyaW5nIHRoZSBEREMgQnVzCj4gUmVxdWVzdC9HcmFu
dCBwcm9jZWR1cmUgYW5kIHdoaWxlIHRhbGtpbmcgdG8gdGhlIG1vbml0b3IsIHdlCj4gaGF2ZSB0
byB1c2UgdGhlIGFkYXB0ZXIgbG9ja2luZyBwcmltaXRpdmVzIHJhdGhlciB0aGFuIHRoZQo+IGky
Yy1tdXggbG9ja2luZyBwcmltaXRpdmVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2Fz
dHJvIDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5jb20+Cj4KPiAtLS0KPiB2Mi0+djM6Cj4g
KiBJbmNvcnBvcmF0ZWQgY29tbWVudHMgZnJvbSBCb3JpcyBCcmV6aWxsb24gYW5kIFBldGVyIFJv
c2luCgpBY2tlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgoK
RG8geW91IG5lZWQgaGVscCB0byBhcHBseSB0aGlzIHRvIGRybS1taXNjIG9yIGRvIHlvdQpoYXZl
IGNvbW1pdCBhY2Nlc3M/CgpZb3VycywKTGludXMgV2FsbGVpagpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
