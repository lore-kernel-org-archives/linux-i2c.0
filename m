From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3] drm/bridge/sii902x: Fix EDID readback
Date: Wed, 7 Nov 2018 19:14:55 +0000
Message-ID: <7f30cbf2-dcf1-8141-cb13-5af03e23ed1b@axentia.se>
References: <1541505156-8097-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1541505156-8097-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Content-ID: <C249BCCCA22FA8449D21EBB1A1DF10A8@eurprd02.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>
Cc: Chris Paterson <Chris.Paterson2@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Boris Brezillon <boris.brezillon@free-electrons.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

T24gMjAxOC0xMS0wNiAxMjo1MiwgRmFicml6aW8gQ2FzdHJvIHdyb3RlOg0KPiBXaGlsZSBhZGRp
bmcgU2lJOTAyMkEgc3VwcG9ydCB0byB0aGUgaXdnMjNzIGJvYXJkLCBpdCBjYW1lDQo+IHVwIHRo
YXQgd2hlbiB0aGUgSERNSSB0cmFuc21pdHRlciBpcyBpbiBwYXNzIHRocm91Z2ggbW9kZSB0aGUN
Cj4gZGV2aWNlIGlzIG5vdCBjb21wbGlhbnQgd2l0aCB0aGUgSTJDIHNwZWNpZmljYXRpb24gYW55
bW9yZSwNCj4gYXMgaXQgcmVxdWlyZXMgYSBmYXIgYmlnZ2VyIHRidWYsIGR1ZSB0byBhIGRlbGF5
IHRoZSBIRE1JDQo+IHRyYW5zbWl0dGVyIGlzIGFkZGluZyB3aGVuIHJlbGF5aW5nIHRoZSBTVE9Q
IGNvbmRpdGlvbiBvbiB0aGUNCj4gbW9uaXRvciBpMmMgc2lkZSBvZiB0aGluZ3MuDQo+IA0KPiBX
aGVuIG5vdCBwcm92aWRpbmcgYW4gYXBwcm9wcmlhdGUgZGVsYXkgYWZ0ZXIgdGhlIFNUT1AgY29u
ZGl0aW9uDQo+IHRoZSBpMmMgYnVzIHdvdWxkIGdldCBzdHVjay4gQWxzbywgYW55IG90aGVyIHRy
YWZmaWMgb24gdGhlIGJ1cw0KPiB3aGlsZSB0YWxraW5nIHRvIHRoZSBtb25pdG9yIG1heSBjYXVz
ZSB0aGUgdHJhbnNhY3Rpb24gdG8gZmFpbA0KPiBvciBldmVuIGNhdXNlIGlzc3VlcyB3aXRoIHRo
ZSBpMmMgYnVzIGFzIHdlbGwuDQo+IA0KPiBJMmMtZ2F0ZXMgc2VlbWVkIHRvIHJlYWNoIGNvbnNl
bnQgYXMgYSBwb3NzaWJsZSB3YXkgdG8gYWRkcmVzcw0KPiB0aGVzZSBpc3N1ZXMsIGFuZCBhcyBz
dWNoIHRoaXMgcGF0Y2ggaXMgaW1wbGVtZW50aW5nIGEgc29sdXRpb24NCj4gYmFzZWQgb24gdGhh
dC4gU2luY2Ugb3RoZXJzIGFyZSBjbGVhcmx5IHJlbHlpbmcgb24gdGhlIGN1cnJlbnQNCj4gaW1w
bGVtZW50YXRpb24gb2YgdGhlIGRyaXZlciwgdGhpcyBwYXRjaCB3b24ndCByZXF1aXJlIGFueSBE
VA0KPiBjaGFuZ2VzLg0KPiANCj4gU2luY2Ugd2UgZG9uJ3Qgd2FudCBhbnkgaW50ZXJmZXJlbmNl
IGR1cmluZyB0aGUgRERDIEJ1cw0KPiBSZXF1ZXN0L0dyYW50IHByb2NlZHVyZSBhbmQgd2hpbGUg
dGFsa2luZyB0byB0aGUgbW9uaXRvciwgd2UNCj4gaGF2ZSB0byB1c2UgdGhlIGFkYXB0ZXIgbG9j
a2luZyBwcmltaXRpdmVzIHJhdGhlciB0aGFuIHRoZQ0KPiBpMmMtbXV4IGxvY2tpbmcgcHJpbWl0
aXZlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2Fz
dHJvQGJwLnJlbmVzYXMuY29tPg0KDQpSZXZpZXdlZC1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhl
bnRpYS5zZT4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
