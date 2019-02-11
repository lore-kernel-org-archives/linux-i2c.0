From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 5/5] i2c:ocores: checkpatch fixes
Date: Mon, 11 Feb 2019 17:19:43 +0100
Message-ID: <20190211161942.ckuys4vyagbwaklq@ninjato>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
 <20190211160529.23858-6-federico.vaga@cern.ch>
 <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ilmmbb5oktml3kgo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Federico Vaga <federico.vaga@cern.ch>, Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--ilmmbb5oktml3kgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +	ctrl =3D oc_getreg(i2c, OCI2C_CONTROL);
>=20
> There's a pointless double oc_getreg(i2c, OCI2C_CONTROL).

In case you need to resend, please update $subject of all patches to
have a space after "i2c:"


--ilmmbb5oktml3kgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhoJoACgkQFA3kzBSg
Kba1Jg//Y2TAKnvmcdIGORStIcuiD/0IlmwxPPAVZeBtUgU2an8cczAtGq/dNPNl
gN1bCNz/GsHf4f/52RFV8VIQGBUfEYCLeS5vnaIAUefnG6IT7+i6OSwDAucnxWz4
zsJBJ5VFmojraNVuIo3x5RjOBHqeuKhMyIlwcl4GkRYMTp/vwqXs09GwIMltsq8c
hJ71wJMHD61J1U2zv5aOuzXrlnn+WqSQsaOWv+zF5AcdxCkSrWyZMBKa00EBBxAM
u+h7Y8zwDy28MO92ZLRngAUHsdM6zA2sjGFCelg9XYUl/3mgcABiIXfDVuYbuiv/
DmYfRILT6voASocPS2kLInjjNpKBojw9FuWnDt1fos9i/KU9Hd1hR8sialiLOL46
0EpDuOAx0D7PmAHiOiNbBi6jM5N/cPj+ZeacpCwdGaHuF6IdrUwBrtkrM9ZDw8jm
+yEQyvhVwQrAZaFBqHunsC0CMnMbuT/xxyTxMWxBcZCub6e2bSBHaAFEfuodT1Yh
gLJZ8FBlMTl/5pJsCzN+EcPUqGWQEmUbFK4BmmJUmPYboa3syz2C7W2l3hmu/6Xk
9BzKkFWz2MBnRp/d2aKl7LZ2NaZhwNjvJriXBcBSsU+wtTA80ylCI8bdyyMclPPi
uHl127swpiVim4KgBYjAQFIeNbv8AlovjRle8C9R8Cj5F8kO0/o=
=GpBh
-----END PGP SIGNATURE-----

--ilmmbb5oktml3kgo--
