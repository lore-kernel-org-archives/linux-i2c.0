From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] drm/bridge/sii902x: Fix EDID readback
Date: Fri, 2 Nov 2018 15:18:30 +0000
Message-ID: <OSBPR01MB1766A7CE698738CDB36A3F26C0CF0@OSBPR01MB1766.jpnprd01.prod.outlook.com>
References: <1541160827-14255-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <2f970e6a-3ff1-1788-f454-781c7baca62d@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2f970e6a-3ff1-1788-f454-781c7baca62d@axentia.se>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>
Cc: Chris Paterson <Chris.Paterson2@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Boris Brezillon <boris.brezillon@free-electrons.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

SGVsbG8gUGV0ZXIsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiA+ICtzdGF0
aWMgaW50IHNpaTkwMnhfaTJjX2J5cGFzc19zZWxlY3Qoc3RydWN0IGkyY19tdXhfY29yZSAqbXV4
LCB1MzIgY2hhbl9pZCkNCj4gPiArew0KPiA+ICtzdHJ1Y3Qgc2lpOTAyeCAqc2lpOTAyeCA9IGky
Y19tdXhfcHJpdihtdXgpOw0KPiA+ICtzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmc2lpOTAyeC0+aTJj
LT5kZXY7DQo+ID4gK3Vuc2lnbmVkIGxvbmcgdGltZW91dDsNCj4gPiArdTggc3RhdHVzOw0KPiA+
ICtpbnQgcmV0Ow0KPiA+ICsNCj4gPiArcmV0ID0gc2lpOTAyeF91cGRhdGVfYml0c191bmxvY2tl
ZChzaWk5MDJ4LT5pMmMsIFNJSTkwMlhfU1lTX0NUUkxfREFUQSwNCj4gPiArICAgU0lJOTAyWF9T
WVNfQ1RSTF9ERENfQlVTX1JFUSwNCj4gPiArICAgU0lJOTAyWF9TWVNfQ1RSTF9ERENfQlVTX1JF
USk7DQo+DQo+IEhlcmUgKGFuZCBhbHNvIGluIHNpaTkwMnhfaTJjX2J5cGFzc19kZXNlbGVjdCkg
eW91IGRvIGEgcm13IGFjY2VzcyB0byB0aGUNCj4gU0lJOTAyWF9TWVNfQ1RSTF9EQVRBIHJlZ2lz
dGVyIHdpdGhvdXQgY29vcmRpbmF0aW5nIHdpdGggcmVnbWFwLiBSZWdtYXAgaXMNCj4gYWxzbyBk
b2luZyBybXcgYWNjZXNzZXMgdG8gdGhhdCByZWdpc3RlciBpbiBvdGhlciBwYXJ0cyBvZiB0aGUg
ZHJpdmVyLiBJDQo+IHRoaW5rIHlvdSBuZWVkIHRvIGVpdGhlciBhZGQgY29tbWVudCBhcyB0byB3
aHkgdGhhdCBpcyBzYWZlIChtYXliZSBvdGhlcg0KPiB0aGluZ3MgbWFrZSBpdCBpbXBvc3NpYmxl
IGZvciB0aGUgdHdvIHJtdyBhY2Nlc3NlcyB0byBjcm9zcz8pLCBvciBhZGQgdGhlDQo+IG1pc3Np
bmcgY29vcmRpbmF0aW9uLg0KPg0KDQpUaGUgb3RoZXIgdHdvIHBsYWNlcyB3aGVyZSBTSUk5MDJY
X1NZU19DVFJMX0RBVEEgaXMgYmVpbmcgaGFuZGxlZCBhcmUNCnNpaTkwMnhfYnJpZGdlX2Rpc2Fi
bGUgYW5kIHNpaTkwMnhfYnJpZGdlX2VuYWJsZSwgSSBkaWRu4oCZdCB0aGluayB0aGVyZSBpcw0K
YW55IGNoYW5jZSBvZiB0aGUgbW9kZXMgYmVpbmcgcHJvYmVkIHdoaWxlIHRoZSBicmlkZ2UgZ2V0
cyBlbmFibGVkL2Rpc2FibGVkLA0KYnV0IG5vdyB0aGF0IHlvdSBtYWtlIG1lIHRoaW5rIGFib3V0
IGl0IHVzZXIgc3BhY2UgbWF5IHRyaWdnZXIgdGhlIHJlYWRiYWNrDQpvZiB0aGUgRURJRCBhdCB0
aGUgbW9zdCBpbmNvbnZlbmllbnQgdGltZXMuIEFueXdheSwgdGhpcyBpcyBhIGdvb2QgcG9pbnQs
IGFuZA0Kc2luY2UgSSBkb24ndCB0aGluayBJIGFtIHN1cHBvc2VkIHRvIGFjY2VzcyByZWdtYXAn
cyBsb2NrIGZyb20gb3V0c2lkZSB0aGUgQVBJcywNCkkgY291bGQgc3dpdGNoIHRvIHRoZSB1bmxv
Y2tlZCB2ZXJzaW9uIG9mIHVwZGF0ZV9iaXRzIGZyb20gd2l0aGluIHNpaTkwMnhfYnJpZGdlX2Rp
c2FibGUNCmFuZCBzaWk5MDJ4X2JyaWRnZV9lbmFibGUsIGFuZCBtYW51YWxseSBncmFiIHRoZSBp
MmMgYWRhcHRlciBsb2NrLCB3aGF0IGRvIHlvdSB0aGluaz8NCg0KRmFiDQoNCg0KDQpSZW5lc2Fz
IEVsZWN0cm9uaWNzIEV1cm9wZSBMdGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJv
dXJuZSBFbmQsIEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5n
bGFuZCAmIFdhbGVzIHVuZGVyIFJlZ2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
