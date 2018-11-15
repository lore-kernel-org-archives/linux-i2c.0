From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3] drm/bridge/sii902x: Fix EDID readback
Date: Thu, 15 Nov 2018 11:16:11 +0100
Message-ID: <20181115111611.783e5c42@bbrezillon>
References: <1541505156-8097-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CACRpkda+YcxCOQeSo=2Jk5S2b4Sa7WcROeaJitzgPcBzM1qBrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CACRpkda+YcxCOQeSo=2Jk5S2b4Sa7WcROeaJitzgPcBzM1qBrA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Dave Airlie <airlied@linux.ie>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

T24gVGh1LCAxNSBOb3YgMjAxOCAxMToxMzo1MiArMDEwMApMaW51cyBXYWxsZWlqIDxsaW51cy53
YWxsZWlqQGxpbmFyby5vcmc+IHdyb3RlOgoKPiBPbiBUdWUsIE5vdiA2LCAyMDE4IGF0IDEyOjUy
IFBNIEZhYnJpemlvIENhc3Rybwo+IDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5jb20+IHdy
b3RlOgo+IAo+ID4gV2hpbGUgYWRkaW5nIFNpSTkwMjJBIHN1cHBvcnQgdG8gdGhlIGl3ZzIzcyBi
b2FyZCwgaXQgY2FtZQo+ID4gdXAgdGhhdCB3aGVuIHRoZSBIRE1JIHRyYW5zbWl0dGVyIGlzIGlu
IHBhc3MgdGhyb3VnaCBtb2RlIHRoZQo+ID4gZGV2aWNlIGlzIG5vdCBjb21wbGlhbnQgd2l0aCB0
aGUgSTJDIHNwZWNpZmljYXRpb24gYW55bW9yZSwKPiA+IGFzIGl0IHJlcXVpcmVzIGEgZmFyIGJp
Z2dlciB0YnVmLCBkdWUgdG8gYSBkZWxheSB0aGUgSERNSQo+ID4gdHJhbnNtaXR0ZXIgaXMgYWRk
aW5nIHdoZW4gcmVsYXlpbmcgdGhlIFNUT1AgY29uZGl0aW9uIG9uIHRoZQo+ID4gbW9uaXRvciBp
MmMgc2lkZSBvZiB0aGluZ3MuCj4gPgo+ID4gV2hlbiBub3QgcHJvdmlkaW5nIGFuIGFwcHJvcHJp
YXRlIGRlbGF5IGFmdGVyIHRoZSBTVE9QIGNvbmRpdGlvbgo+ID4gdGhlIGkyYyBidXMgd291bGQg
Z2V0IHN0dWNrLiBBbHNvLCBhbnkgb3RoZXIgdHJhZmZpYyBvbiB0aGUgYnVzCj4gPiB3aGlsZSB0
YWxraW5nIHRvIHRoZSBtb25pdG9yIG1heSBjYXVzZSB0aGUgdHJhbnNhY3Rpb24gdG8gZmFpbAo+
ID4gb3IgZXZlbiBjYXVzZSBpc3N1ZXMgd2l0aCB0aGUgaTJjIGJ1cyBhcyB3ZWxsLgo+ID4KPiA+
IEkyYy1nYXRlcyBzZWVtZWQgdG8gcmVhY2ggY29uc2VudCBhcyBhIHBvc3NpYmxlIHdheSB0byBh
ZGRyZXNzCj4gPiB0aGVzZSBpc3N1ZXMsIGFuZCBhcyBzdWNoIHRoaXMgcGF0Y2ggaXMgaW1wbGVt
ZW50aW5nIGEgc29sdXRpb24KPiA+IGJhc2VkIG9uIHRoYXQuIFNpbmNlIG90aGVycyBhcmUgY2xl
YXJseSByZWx5aW5nIG9uIHRoZSBjdXJyZW50Cj4gPiBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZHJp
dmVyLCB0aGlzIHBhdGNoIHdvbid0IHJlcXVpcmUgYW55IERUCj4gPiBjaGFuZ2VzLgo+ID4KPiA+
IFNpbmNlIHdlIGRvbid0IHdhbnQgYW55IGludGVyZmVyZW5jZSBkdXJpbmcgdGhlIEREQyBCdXMK
PiA+IFJlcXVlc3QvR3JhbnQgcHJvY2VkdXJlIGFuZCB3aGlsZSB0YWxraW5nIHRvIHRoZSBtb25p
dG9yLCB3ZQo+ID4gaGF2ZSB0byB1c2UgdGhlIGFkYXB0ZXIgbG9ja2luZyBwcmltaXRpdmVzIHJh
dGhlciB0aGFuIHRoZQo+ID4gaTJjLW11eCBsb2NraW5nIHByaW1pdGl2ZXMuCj4gPgo+ID4gU2ln
bmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5j
b20+Cj4gPgo+ID4gLS0tCj4gPiB2Mi0+djM6Cj4gPiAqIEluY29ycG9yYXRlZCBjb21tZW50cyBm
cm9tIEJvcmlzIEJyZXppbGxvbiBhbmQgUGV0ZXIgUm9zaW4gIAo+IAo+IEFja2VkLWJ5OiBMaW51
cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Cj4gCj4gRG8geW91IG5lZWQgaGVs
cCB0byBhcHBseSB0aGlzIHRvIGRybS1taXNjIG9yIGRvIHlvdQo+IGhhdmUgY29tbWl0IGFjY2Vz
cz8KCkkgY2FuIGRvIGl0IGlmIG5lZWRlZC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
