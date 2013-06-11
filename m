From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: use platform_{get,set}_drvdata()
Date: Tue, 11 Jun 2013 21:45:04 +0200
Message-ID: <20130611194503.GH3376@katana>
References: <002501ce579f$745d4810$5d17d830$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002501ce579f$745d4810$5d17d830$@samsung.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jochen Friedrich' <jochen-NIgtFMG+Po8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2013 at 07:22:40PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!



--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt34/AAoJEBQN5MwUoCm2SjoP/RwmrTiS+H9Bv5XKkhXgYrcR
fHoPC/g0vUXzBjrrh6o4IXyIrFkeNcUimeL6dt5xJGW7B9O2FP1u4crZ4Spd6b3i
gZWsJsHgcT+ECYWNtmpqixe+5huMACweFkQrolzIus9CevNkNFJV8uZ069pQY2pL
chg3wCdO2oE361oz7EmXD4ayxi/CEy/YUo/ra+uElkh+DGgLIN3WKYSRSGIczRZx
TsDjL/xwEr0tP6rsS3Z8+lrN8O14kppa64D5Yzwm+Gnzg8wKuI9vqIG7iAT1WLEv
2oHYqIKaKs+g6cu7Pl/IXWTyYiEC4c0qPWJNS91DzA767s6MyAuqZhhRe42PCovF
1nHuVB320KxD3x0fWJqtET0EtEYqSGBVQoPmBv86bdwciCx33C7U0jFGOltR3q9b
TLBY6PIkoura+MI/yXbaxaBaxFGkEvsRvEs/ioaLfEL7ebAZ7XgsV5AtTljZiWAQ
YHrmgqKJqbUsfcaF6Vt4unRInS8UFcl4xfX6CxT3OYeEpeSyB7HOg03+DLkHw15b
9xZsLSaXgU1Ut9UliKTpTh+sWaCg4BSJMHDDxPqvZoe4x3lQUMNw7qy6xvN7wb45
OBT+M6JZIR/08PmZ2fl70rLya2LsWHmYaSqKZilK2Mr0qf22toUM7JcwTJVk95mF
6k4a+3v/A8TXiI/AJ4Ws
=SqEt
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--
