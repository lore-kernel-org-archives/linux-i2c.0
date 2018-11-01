From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] drm/bridge/sii902x: Fix EDID readback
Date: Thu, 1 Nov 2018 11:21:17 +0000
Message-ID: <20181101112117.GA6425@sirena.org.uk>
References: <1540990667-14109-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CACRpkdarsCKrb4OepC+7LNi9epRks48b4F_5eXJ_on1OJ+h1Mg@mail.gmail.com>
 <TY1PR01MB177051AC6C2B556E32AC08AEC0CD0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1251761829=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <TY1PR01MB177051AC6C2B556E32AC08AEC0CD0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Dave Airlie <airlied@linux.ie>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============1251761829==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2018 at 04:55:53PM +0000, Fabrizio Castro wrote:

> Having the option of using "unlocked" flavours of reads and writes
> is what we need here, but looking at drivers/base/regmap/regmap-i2c.c
> I couldn't find anything suitable for my case, maybe Mark could advise
> on this one? I am sure I overlooked something here, is there a better
> way to address this?

As Linus said you can go as far as writing your own read and write
functions if you want to.  That seems to be the easiest thing, though I
am suspicous that you're having to use the I2C framework in this way -
it doesn't sound terribly clever.  You could I guess also just have a
custom function for whatever register is doing all this stuff that just
ignores regmap and bodge things that way while using regmap as normal
for everything else.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlva4akACgkQJNaLcl1U
h9DKhQf/YICRTIBGlEtOiNrPdVAyHW+fyf6uzw449B9rJr5gT8xALK+/7MttSSjI
8tDB20nxgt4bYyG3FH7OtVwS2EzDS+ZL3ChcXHmlBgRqfoV/yOZIsK3XnOmXDGUi
zAfTxvDb/RG2S6Qhm3S2v5wTlQ48GrSrTZHbaV5ma0JuESJlajuO/ere+ymR5czC
nkSBsSCQh1URtZaQyc8RHf5GKBdMvCydHtwKOTwE5BIOimHw5NCcJAkyhWQmpj2Q
u76nnLPs/k063m0SbrW426cbwIbdHIs667exkekMm7fjt2NIACtS0HBAzj6CrUj6
CY6Ftar70dfdukyFj/TYN07tF9MS5Q==
=Xdnj
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--===============1251761829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1251761829==--
