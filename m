From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: Only include slave support if selected
Date: Mon, 26 Jan 2015 22:05:52 +0100
Message-ID: <20150126210551.GD28095@katana>
References: <20150126205931.25e1f648@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150126205931.25e1f648-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 08:59:31PM +0100, Jean Delvare wrote:
> Make the slave support depend on CONFIG_I2C_SLAVE. Otherwise it gets
> included unconditionally, even when it is not needed.
>=20
> I2C bus drivers which implement slave support must select
> I2C_SLAVE.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-current, thanks!


--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxqwvAAoJEBQN5MwUoCm2SAsP/ixy9pW15BspvFMcczyhshYV
/+UNwCMS4PCmgnUJdhAjo6HEAPjSz0xBDqHoiWuziY2MnF0zptlR/ClTSFrP3le1
Mw6S+tYfXaBUY0MIyXNUqpfUY8TSOtiekqIEW/vpWshVWotxG9WDlJ0yz9jBYiZ9
4EuzNpaErPNg3siwCjX7eEfDtdo6dPtNPSZQAxbFREpiLZjVH7Rbz1LsoMx+fM7h
K32ouej5kwKSJ/lDvBtUOExUf/AcLGriyTSVUgTvZn29PRYTCIH99JrnmXI8Y1Ob
Ya7uxGzznA7ajxQeLTrLXiHFqMDuf5NKnd45AwlodfrpJNKVKFnBuxKbtMGbr1jw
pWJXmQAYTFYZ5ny0RgP43vxXZ6F8stQce/2F2Xieh2MT4Vnn8qvOPyUAzt2isMkW
8obnUSiGqVOPdlIGAm6yOtD1o19KAZWdgnUrGGc+v1CbezrRhM9rk/qGls1NBM9M
2Cq7C0v9x18mrnetrQNJEZkPXmW41aIJ2VOpwtJOStZTxfpYM/eNAl9y8+p3tzHu
ah96aXpBdqVWj6OkdD8bEqlpNfM+IXZH/MO3pOk474AW9jwc7oICj/0QVM8+MyRV
/QajYeAcxma3Hlu2FYUhMO6+cnDlE8+ZvnLJMRbFH1y0TNkbxibWBkT9mu+jBdWY
8Yu7gnIS9GHQUqLSD8Yv
=hVAr
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
