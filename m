From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge/sii902x: Fix EDID readback
Date: Mon, 5 Nov 2018 22:15:23 +0100
Message-ID: <20181105221523.4b90c87e@bbrezillon>
References: <1541426208-25434-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1541426208-25434-1-git-send-email-fabrizio.castro@bp.renesas.com>
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, David Airlie <airlied@linux.ie>, Boris Brezillon <boris.brezillon@free-electrons.com>, Chris Paterson <Chris.Paterson2@renesas.com>, dri-devel@lists.freedesktop.org, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

SGkgRmFicml6aW8sCgpUaGFua3MgZm9yIHdvcmtpbmcgb24gdGhhdC4gSSB0aGluayB5b3VyIHNv
bHV0aW9uIGZpeGVzIHRoZSBpc3N1ZSB3ZSBoYWQKb24gYXRtZWwgYm9hcmRzIFsxXSBpbiBhIGNs
ZWFuIHdheSAoc3RpbGwgaGF2ZSB0byBmaW5kIHNvbWUgdGltZSB0bwp0ZXN0IGl0KS4KCk9uIE1v
biwgIDUgTm92IDIwMTggMTM6NTY6NDggKzAwMDAKRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5j
YXN0cm9AYnAucmVuZXNhcy5jb20+IHdyb3RlOgoKPiBAQCAtNDQxLDYgKzU1OCw5IEBAIHN0YXRp
YyBpbnQgc2lpOTAyeF9yZW1vdmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkKPiAgewo+ICAJ
c3RydWN0IHNpaTkwMnggKnNpaTkwMnggPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKPiAg
Cj4gKwlpZiAoc2lpOTAyeC0+aTJjbXV4KQo+ICsJCWkyY19tdXhfZGVsX2FkYXB0ZXJzKHNpaTkw
MngtPmkyY211eCk7Cj4gKwoKSnVzdCBvbmUgdGlueSBkZXRhaWw6IEkgdGhpbmsgeW91IGNhbiBz
YWZlbHkgY2FsbCBpMmNfbXV4X2RlbF9hZGFwdGVycygpCnVuY29uZGl0aW9uYWxseSBzaW5jZSAt
PnJlbW92ZSgpIHdpbGwgb25seSBiZSBjYWxsZWQgaWYgLT5wcm9iZSgpCnN1Y2NlZWRlZCwgd2hp
Y2ggZ3VhcmFudGVlcyB0aGF0IHNpaTkwMngtPmkyY211eCAhPSBOVUxMLgoKCj4gIAlkcm1fYnJp
ZGdlX3JlbW92ZSgmc2lpOTAyeC0+YnJpZGdlKTsKPiAgCj4gIAlyZXR1cm4gMDsKClsxXWh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTUzMjAwNS8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
