From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [RFC] drm/bridge/sii902x: Fix EDID readback
Date: Fri, 2 Nov 2018 12:05:05 +0000
Message-ID: <OSBPR01MB1766BE0BE66B3CE2644F059DC0CF0@OSBPR01MB1766.jpnprd01.prod.outlook.com>
References: <1540990667-14109-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CACRpkdarsCKrb4OepC+7LNi9epRks48b4F_5eXJ_on1OJ+h1Mg@mail.gmail.com>
 <TY1PR01MB177051AC6C2B556E32AC08AEC0CD0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20181101112117.GA6425@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181101112117.GA6425@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Dave Airlie <airlied@linux.ie>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

SGVsbG8gTWFyaywKClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayEKCj4gU3ViamVjdDogUmU6
IFtSRkNdIGRybS9icmlkZ2Uvc2lpOTAyeDogRml4IEVESUQgcmVhZGJhY2sKPgo+IE9uIFdlZCwg
T2N0IDMxLCAyMDE4IGF0IDA0OjU1OjUzUE0gKzAwMDAsIEZhYnJpemlvIENhc3RybyB3cm90ZToK
Pgo+ID4gSGF2aW5nIHRoZSBvcHRpb24gb2YgdXNpbmcgInVubG9ja2VkIiBmbGF2b3VycyBvZiBy
ZWFkcyBhbmQgd3JpdGVzCj4gPiBpcyB3aGF0IHdlIG5lZWQgaGVyZSwgYnV0IGxvb2tpbmcgYXQg
ZHJpdmVycy9iYXNlL3JlZ21hcC9yZWdtYXAtaTJjLmMKPiA+IEkgY291bGRuJ3QgZmluZCBhbnl0
aGluZyBzdWl0YWJsZSBmb3IgbXkgY2FzZSwgbWF5YmUgTWFyayBjb3VsZCBhZHZpc2UKPiA+IG9u
IHRoaXMgb25lPyBJIGFtIHN1cmUgSSBvdmVybG9va2VkIHNvbWV0aGluZyBoZXJlLCBpcyB0aGVy
ZSBhIGJldHRlcgo+ID4gd2F5IHRvIGFkZHJlc3MgdGhpcz8KPgo+IEFzIExpbnVzIHNhaWQgeW91
IGNhbiBnbyBhcyBmYXIgYXMgd3JpdGluZyB5b3VyIG93biByZWFkIGFuZCB3cml0ZQo+IGZ1bmN0
aW9ucyBpZiB5b3Ugd2FudCB0by4gIFRoYXQgc2VlbXMgdG8gYmUgdGhlIGVhc2llc3QgdGhpbmcs
IHRob3VnaCBJCj4gYW0gc3VzcGljb3VzIHRoYXQgeW91J3JlIGhhdmluZyB0byB1c2UgdGhlIEky
QyBmcmFtZXdvcmsgaW4gdGhpcyB3YXkgLQo+IGl0IGRvZXNuJ3Qgc291bmQgdGVycmlibHkgY2xl
dmVyLiAgWW91IGNvdWxkIEkgZ3Vlc3MgYWxzbyBqdXN0IGhhdmUgYQo+IGN1c3RvbSBmdW5jdGlv
biBmb3Igd2hhdGV2ZXIgcmVnaXN0ZXIgaXMgZG9pbmcgYWxsIHRoaXMgc3R1ZmYgdGhhdCBqdXN0
Cj4gaWdub3JlcyByZWdtYXAgYW5kIGJvZGdlIHRoaW5ncyB0aGF0IHdheSB3aGlsZSB1c2luZyBy
ZWdtYXAgYXMgbm9ybWFsCj4gZm9yIGV2ZXJ5dGhpbmcgZWxzZS4KCkkgYWdyZWUsIEkgaGF2ZSBw
cm90b3R5cGVkIGl0IGFuZCBpdCBzZWVtcyB0byBiZSB3b3JraW5nIGp1c3QgZmluZS4KV2lsbCBz
ZW5kIGEgcGF0Y2ggYWRkcmVzc2luZyBhbGwgb2YgdGhlIGNvbW1lbnRzLCBpbmNsdWRpbmcgdGhp
cyBvbmUuCgpGYWIKCgoKUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtlcyBNZWFk
b3csIE1pbGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNMOCA1Rkgs
IFVLLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVkIE5vLiAw
NDU4NjcwOS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
