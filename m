From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
Date: Fri, 14 Jun 2013 16:01:40 +0200
Message-ID: <20130614140140.GB2929@katana>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <3315236.ZNXhyxmCRd@wuerfel>
 <20130612113849.GG16699@lukather>
 <201306121438.12549.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201306121438.12549.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The weird thing is that the only difference between the two controllers
> > is the register offsets, and that's it. The state numbers, bit index,
> > etc, are exactly the same.
>=20
> Ok, cool. Great someone noticed!

:) First thing I do when reviewing new drivers is a manual fuzzy search
for already known register sets.


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuyJEAAoJEBQN5MwUoCm20+IP/31917+CLHnLb64vVj8F95/O
NCd6eygPfnzjQEkWcQ89lh1FdIsMqrOZgSKXY/OqdoJaYW0clsDY7OZzWthjOHNI
2OVye6SeG0fYrNzOXN2JkdjlVcFfz+eABawBoMREFktw7Fy7jFKxGE/fPGDOUOBg
oX7+ls4anDkKXxYM78QA/7ck2ObTSnutnImD5YnaMWBmwMSHmJETBbB/Dfv1X1eS
1z2hbT64zE0ITQv2OGNKfiCdg/Vnw7u24CyfCNebc3cU7ByrcGXWM2odTTD5bBDS
NYoizMIbM+fkztKlaO8Sk8liLAeqkN9rueBBzwmLnNz+hev2Cc9fVIKVztNfOuAW
fdUwLzwBgSR/SU5lKooNO+YC/H531Q0U+Wstw738Yu87fo0qiDsdk0H5BzvJq6Jm
Pd00x6RXTaN9ZMogH3n4m6h9Kd26k/46w2eo0ug49qu7Q1G2UROFAbzOk08InuLo
8seCQHUdhDyGhbKFXv0Lh3W4yg7Vs6jH5YzmN1Yd6OqtmfBMK4xLueHvMaY2WLZl
AO98vONYYaN63wFMRe/+lmjVOlwjzKXr9QAc/h/UE0ggpfxnMZQsWUyXMf0ozpWb
0Y3ADzo8tygYwCme3eLT3BlqOrpO7VApHcoMk5ag9e/v9Gf0Tz3BgbKB0ldv7LJw
4aTu2s+8SDN9xYY+tN/J
=npl8
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
