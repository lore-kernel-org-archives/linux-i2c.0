From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Fri, 14 Feb 2014 21:36:29 +0100
Message-ID: <20140214203629.GE15350@lukather>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140213082630.GA3119@katana>
 <20140213225248.GB15350@lukather>
 <20140214074407.GA2569@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140214074407.GA2569@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2014 at 08:44:07AM +0100, Wolfram Sang wrote:
>=20
> > > For non-a10, That should be at least
> > >=20
> > > 	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-a10-i2c";
> > >=20
> > > or
> > >=20
> > > 	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-i2c";
> > >=20
> > > depending on the outcome above.
> > >=20
> > > Or is my knowledge outdated already?
> > >=20
> >=20
> > Since they are strictly compatible, we don't need to introduce any
> > different compatible string here.
>=20
> You never know all errata in advance. From what I know, one should
> always use the specfic naming first, and then the generic fallback. So,
> in case a distinction is needed later (think errata), then one doesn't
> need to change the devicetrees.
>=20

And adding a A13-specific compatible wouldn't change anything, because
it does work on at least one revision of them, so if you'd have to
deal with an errata, you'd have to introduce a new compatible for this
revision only anyway.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS/n5MAAoJEBx+YmzsjxAgvgEP/jrMIukfhVaVsB1DprslgOzU
61BunqOcoLwrgfzldncHKkYwrSwqfm6ZPPqcHBbExOBLIeSEEXDPDOcT3VtM1KHz
NGaQVbqFYKTVebkEfKw/4obg3SG1G/3RTh+asKXOGs0LoN0/vbTK8BxSbxy5vdcF
ifSkqCfYC20ehRGpIDea/s3JItqryxWJ0qyIlNk0FH/ZaQGPXYU223U6fqHoALJt
bSGFAJ8N64kSoVUYmHlMiP8Z3+mA6PoXyqp1dbLmzSQZiUh/GU0BV4KsR36UrRW/
yPi87f59lGZoavX1zz6RHV0nxi/ln/+AB9rccpYjaho7OmzuSWgvDpMQmAJuP4A5
/eaLMScRXJ6z7Zxt2QZj/JT22l0EQjcrnOOl/5TNdACe4IInqq7XE4d8p1AVtnJW
SaffYW0VUjzFVCbGZ/Dq4P9/7OD9+t1S7RjgtYoDuvTm8yTUJUKi+3hAF7a9IspD
35qryHO+79LyUSlY54PxDBps8AwIsjBa+nz0vFKto1BzbAcIULv6eOqjCHzzEgyX
u/bpn23mtszOZ9y6ZSmOpJKAiU5xa3MpuubJ0ejL8wUPHbLhmt9jzWLUFJl63Vlp
w/1LF4nhxCjD6DLWQ9CIGB3wt3r+oEuukZJCZBdcvLzs+OGmUBKiDmnFonGpFY6j
JHecunF1ykJDA8ah38To
=R/tH
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
