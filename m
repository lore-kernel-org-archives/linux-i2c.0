From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: rcar-i2c: always reads a byte
Date: Mon, 5 May 2014 15:21:11 +0200
Message-ID: <20140505132111.GA13467@katana>
References: <531F3686.7050808@codethink.co.uk>
 <53201A83.7040605@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53201A83.7040605-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >I have noticed the following behaviour with the i2c-rcar driver
> >with the following single i2c_msg structure:
> >
> >	msg[0].addr =3D 0x12;
> >	msg[0].flags =3D I2C_M_RD;
> >	msg[0].len =3D 0;
> >	msg[0].buf =3D data;
>=20
> isn't this illegal?
> This should lead to 50% chance of blocked bus: After sending
> read-bit the slave ACK's and puts first data bit onto SDL.

It is not illegal, SMBUS_QUICK is described in the SMBus specs and can
bee seen as a kind of 1-bit transfer. Yet, you should only issue it for
devices which require exactly this kind of transfer. Which is true for
most I2C transaction types.


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTZ5BHAAoJEBQN5MwUoCm2eVsP+wfaHKiMIJtOqWwu34DXeemo
2XYNAIifMhLAozmp0vNPMEWqeczqZfg4P2SKYCqm6GB1221srZYuxy0BbCLoJtvK
AfEn3CNv81OF07EhEObiSahbMLEUfx8ri7w+tud/ma2z9a9fHHVJcOXpvBWscuH+
P6TAsjzEB0xI1RcNGdBK/DlRsc5/zKtYnVw1YWuNj6r+lkzdVRYy0rh5MKOc2S0R
jU03X1rrUTtyICCEFr+Ail6lOH/uQ2Mffnmqj1UygmjNoWVNaKjPBBD23EoliEQE
y37eHo8f0kF7BQ9pCxQmn0DhcxJr4srOAxhNXC8WSjH4vPQpZkBgoPLEtQtzpjzQ
tXm+O+6e75CHdb94w9lzVCITANWE8Svfy8N4YVUlCdlj3Z7HtU/0x0b6RBmwFnPf
/JOqV6sorggMobET0BiF17uwrhrw5OEoI3REIWLqth6X7I/HUXda69vW4RXOrM2t
ky7F8Xz6hejOoSIAaVksE0CUI9fkhOUjolSEAO5DWuPcGu51Yk2CjQB07iLk/bHr
IJzAtqLlmSo+JHuYDPiE3q9l1LkMHZFPIh7pMkCOb1xP1CzPbbxw6OVOm2GA4eNO
/uDkmgFZlGGuUkN7HaTnRXHLhbgcfFwcEbE6mZPNrCJci16wCId0Ve83XiTmwDdz
cnWv9huokRfQR+H4Sv+n
=xC0U
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
