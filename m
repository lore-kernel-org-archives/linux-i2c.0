From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] drm/bridge/sii902x: Fix EDID readback
Date: Mon, 5 Nov 2018 13:53:47 +0000
Message-ID: <TY1PR01MB1770D4949EAB042643CD866AC0CA0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1541160827-14255-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <2f970e6a-3ff1-1788-f454-781c7baca62d@axentia.se>
 <OSBPR01MB1766A7CE698738CDB36A3F26C0CF0@OSBPR01MB1766.jpnprd01.prod.outlook.com>
 <OSBPR01MB176626F352D6F020DA349166C0CF0@OSBPR01MB1766.jpnprd01.prod.outlook.com>
 <0a9bbdf1-7f8c-683b-7ef3-427200755b80@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <0a9bbdf1-7f8c-683b-7ef3-427200755b80@axentia.se>
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

SGVsbG8gUGV0ZXIsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYnJpZGdlL3NpaTkwMng6IEZpeCBFRElEIHJlYWRiYWNrDQo+DQpz
bmlwDQo+DQo+IElmIHRoZSB0aGluZ3MgeW91IHdyaXRlIGFib3V0IHRoZSBiaXRzIGFyZSB0cnVl
IChoYXZlbid0IGxvb2tlZCBjbG9zZWx5KSwgSSB3b3VsZG4ndA0KPiBhZGQgYW55IHJlZ21hcCBj
b29yZGluYXRpb24uIEJ1dCBpZiBJIHdhcyB0aGUgbWFpbnRhaW5lciwgSSdkIGxpa2UgYSBjb21t
ZW50IGFib3V0DQo+IHRoaXMgc28gdGhhdCB0aGUgbmV4dCBjb250cmlidXRvciBoYXMgYSBiZXR0
ZXIgY2hhbmNlIHRvIHVuZGVyc3RhbmQgdGhlIHN1YnRsZXR5Lg0KPg0KPiBCdXQgSSdtIG5vdCB0
aGUgbWFpbnRhaW5lciwgc28gdGhpcyBpcyBub3QgbXkgY2FsbCwgYnV0IGJ5IGFkZGluZyB0aGUg
Y29tbWVudCB5b3UNCj4gYWxzbyBjbGFyaWZ5IHRoZSBzaXR1YXRpb24gZm9yIHRoZSBtYWludGFp
bmVyLCB3aGljaCBpcyBzb21ldGhpbmcgdGhhdCBpcyBsaWtlbHkNCj4gdG8gYmUgYXBwcmVjaWF0
ZWQuDQoNCkknbGwgYWRkIGNvbW1lbnRzIHRoZW4uDQoNCkNoZWVycywNCkZhYg0KDQo+DQo+IENo
ZWVycywNCj4gUGV0ZXINCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwgRHVr
ZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJlLCBT
TDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0ZXJl
ZCBOby4gMDQ1ODY3MDkuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
