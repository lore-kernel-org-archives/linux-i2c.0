From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
Date: Wed, 23 Jan 2013 15:14:45 +0100
Message-ID: <20130123141445.GA2758@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
 <20130123125001.GG16264@pengutronix.de>
 <CA+8Hj80=Mk1gMSC9gcRT_XPFrEdRxifaB9FNMtkn3BkUkv9bGA@mail.gmail.com>
 <20130123134936.GH16264@pengutronix.de>
 <CA+8Hj83n+pC+a6bYOOH1b61DTqSjpKsxyKDgDL2pCRKxTq4EXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+8Hj83n+pC+a6bYOOH1b61DTqSjpKsxyKDgDL2pCRKxTq4EXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liu Ying <liu.y.victor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The names of the two entries are not the same, one is "24c512", the
> other is "24c512b".

I do understand that. There are TONS of 24c512 variants out there.

> My original idea to add the new entry is to count on the name
> difference to do different system reset operations.

Your devicetree may have both names, but at24 doesn't need it since
there is no code involved handling the difference.

> The commit message of the patch which adds 24c32 support for MX28EVK
> tells that "mx28evk has a free slot U50 that can be used to populate
> an I2C EEPROM.".

I do know that, too. You can put other things there, too. But well, not
worth the hazzle...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlD/8FUACgkQD27XaX1/VRsmGgCeJZCaByj0gw37lr753wxW0npY
06oAn0WAmYiUabRNgQ6eAmcO7Ky3f1U4
=JSKP
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
