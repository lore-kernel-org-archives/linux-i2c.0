From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3 V4] i2c: mxs: Rework the PIO mode operation
Date: Sun, 6 Oct 2013 15:51:35 +0200
Message-ID: <20131006135135.GB4173@katana>
References: <20131004052052.GA3194@katana>
 <1381060933-11111-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381060933-11111-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2013 at 02:02:13PM +0200, Marek Vasut wrote:
> Analyze and rework the PIO mode operation. The PIO mode operation
> was unreliable on MX28, by analyzing the bus with LA, the checks
> for when data were available or were to be sent were wrong.
>=20
> The PIO WRITE has to be completely reworked as it multiple problems.
> The MX23 datasheet helped here, see comments in the code for details.
> The problems boil down to:
> - RUN bit in CTRL0 must be set after DATA register was written
> - The PIO transfer must be 4 bytes long tops, otherwise use
>   clock stretching.
> Both of these fixes are implemented.
>=20
> The PIO READ operation can only be done for up to four bytes as
> we are unable to read out the data from the DATA register fast
> enough.
>=20
> This patch also tries to document the investigation within the
> code.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Applied the series to for-next, thanks!

>     (and fixed my local pre-commit hook)

Yay :)


--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSUWrnAAoJEBQN5MwUoCm2VYgP/0mQE9sjxUCWRCuC9PiO+zi7
8aaeq8li5FNALo+xO7maVAUVgpcfVNXiWjgFSQamTo+BE0LRmzOciWIFcP7munAB
lhb9GpBTQ103979NcLigiAu4BLsxPWyrX3EdTTtxLqRMKVGdXClHW0LVUBwApL8/
VLko+gXMb4BgJRKizOoybkCYIjhJS9ftQpg5MH38hLWsERCxZkGopRgSpJ84Azvu
WuWnoAPyVk399W80IW7YnWlwpFVZryADv9KOIxD5QsI4moTmS9XF+KbHtZSjtaPJ
GqjcCKw0v34Tjoen9ffUQ6E23ntXGL9F+6vv5IDoCoSrByROTlXyct+tsMo6+SFZ
1+rgv+jxQ5wDaHqqGssbZaU4fYuAP2DmNUzYFyJdwDIZGVFH78Ti3UYtGOiom6vU
LP8TlCBHWj31z8wXdD5oezlFff5kxVsqGa8S6VUUgcdJ9Aw0mvPhIeSUOhuKLCtJ
luENAZakyVZexe5VRBEAft7im7AkEEai2cAcoVAgFj/e35d/hGcYoercUI/DdqKp
xaVj3n1dW+XDvFpW3E+BoR70DbfHtP9e99Qb34VuKm8yhva3lWy6wtpVzqG2+EFR
/2dxlxXhlpr4+6A+/4nb0dIS9ADcjyNx8BaxwA0aWiGnBIE4zfiqYtmY+3x2RBin
qtUZ9nOIXB+LxxxIIuUO
=VXKl
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
