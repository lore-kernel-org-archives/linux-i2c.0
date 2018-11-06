From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v2] drm/bridge/sii902x: Fix EDID readback
Date: Tue, 6 Nov 2018 10:25:43 +0000
Message-ID: <TY1PR01MB17705AC915A25FF046375B4EC0CB0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1541426208-25434-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20181105221523.4b90c87e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181105221523.4b90c87e@bbrezillon>
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
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, David Airlie <airlied@linux.ie>, Boris Brezillon <boris.brezillon@free-electrons.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

SGVsbG8gQm9yaXMsCgpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2shCgo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjJdIGRybS9icmlkZ2Uvc2lpOTAyeDogRml4IEVESUQgcmVhZGJhY2sKPgo+IEhp
IEZhYnJpemlvLAo+Cj4gVGhhbmtzIGZvciB3b3JraW5nIG9uIHRoYXQuIEkgdGhpbmsgeW91ciBz
b2x1dGlvbiBmaXhlcyB0aGUgaXNzdWUgd2UgaGFkCj4gb24gYXRtZWwgYm9hcmRzIFsxXSBpbiBh
IGNsZWFuIHdheSAoc3RpbGwgaGF2ZSB0byBmaW5kIHNvbWUgdGltZSB0bwo+IHRlc3QgaXQpLgo+
Cj4gT24gTW9uLCAgNSBOb3YgMjAxOCAxMzo1Njo0OCArMDAwMAo+IEZhYnJpemlvIENhc3RybyA8
ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMuY29tPiB3cm90ZToKPgo+ID4gQEAgLTQ0MSw2ICs1
NTgsOSBAQCBzdGF0aWMgaW50IHNpaTkwMnhfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQpCj4gPiAgewo+ID4gIHN0cnVjdCBzaWk5MDJ4ICpzaWk5MDJ4ID0gaTJjX2dldF9jbGllbnRk
YXRhKGNsaWVudCk7Cj4gPgo+ID4gK2lmIChzaWk5MDJ4LT5pMmNtdXgpCj4gPiAraTJjX211eF9k
ZWxfYWRhcHRlcnMoc2lpOTAyeC0+aTJjbXV4KTsKPiA+ICsKPgo+IEp1c3Qgb25lIHRpbnkgZGV0
YWlsOiBJIHRoaW5rIHlvdSBjYW4gc2FmZWx5IGNhbGwgaTJjX211eF9kZWxfYWRhcHRlcnMoKQo+
IHVuY29uZGl0aW9uYWxseSBzaW5jZSAtPnJlbW92ZSgpIHdpbGwgb25seSBiZSBjYWxsZWQgaWYg
LT5wcm9iZSgpCj4gc3VjY2VlZGVkLCB3aGljaCBndWFyYW50ZWVzIHRoYXQgc2lpOTAyeC0+aTJj
bXV4ICE9IE5VTEwuCgpGYWlyIHBvaW50LCB3aWxsIGNoYW5nZSBpbiB0aGUgbmV4dCB2ZXJzaW9u
LgoKQ2hlZXJzLApGYWIKCj4KPgo+ID4gIGRybV9icmlkZ2VfcmVtb3ZlKCZzaWk5MDJ4LT5icmlk
Z2UpOwo+ID4KPiA+ICByZXR1cm4gMDsKPgo+IFsxXWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvOTUzMjAwNS8KCgoKUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtl
cyBNZWFkb3csIE1pbGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNM
OCA1RkgsIFVLLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVk
IE5vLiAwNDU4NjcwOS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
