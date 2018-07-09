From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v2,3/3] i2c: at91: added slave mode support
Date: Mon, 9 Jul 2018 17:51:36 +0200
Message-ID: <20180709155135.bjwhrmbk6j26fx4c@ninjato>
References: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
 <20180602213513.qv45gaq2kogagju3@katana>
 <20180709151504.6phtp4rm7of6b2qc@M43218.corp.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47xjq3ociihvmim2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709151504.6phtp4rm7of6b2qc@M43218.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--47xjq3ociihvmim2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry for having not catched it. If I remember well, it was the only
> issue I had while testing the slave support.
>=20
> >=20
> > BTW maybe I asked already and forgot: is this IP core capable of being
> > master and slave on the same bus?
> >=20
>=20
> No the master and slave modes are exclusive.

Pity.

But thanks for the heads up, any tag you want to give? Ack or Rev?


--47xjq3ociihvmim2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltDhIMACgkQFA3kzBSg
KbYeMg/+JaNlvaVsuFPljHO0/n90DeoEPtgRwQ3GDrGCdbi80+RCL+xTbGEMvTlW
q8hjVhJ610TehLz7+aDXmOiyJ6+ww+3Kr4grMQ7Z03H0AA/qiN2yYPsfvjC+LW9b
HSLweZ3PogTpQ/aY4ySEQani5pttJXtt8FQK8Y5cyMbPNdYBnCu0YM5JTAkHnXeo
A24GRBMznSHGXzYL9s2xkvssVLc1l9wPn+WzaujoDPAfvg5RncJ6/PhyvpjqFJyQ
Y1alASYF+0QboJD24oOezm+AJbWiuMltOK5wt4hTWGV0RlePuJvORVP/SFUcVRWu
VZsa0zQMn2a83a73Y+mHiib5fH5wwzwnWnej/82NLhPllFdG8ShgBlN8CS9JwDFG
qQu1xhBDKsdMZ/SHCHfgAiNHnotB69nDPMF+IGlEVwcfmeMLSiQtXYf8AwedL2jE
Azf8xjJzF/rWyfq7HoTWY+5QHwB4TBXa6ASyx+/0J8ipHErYaPqpiPMLczF1VEHP
usXU+mx1xn0XGCYRnTpfLKOO/43KcUiFnKvs/7v2rF7gtnt6m37Hhh9q8E1jOwD9
25sTRvy485VxvuBS38tATpIrq8Z5Bbz1XayLVfBfHi2toJe873h/4qLlHYgNbCGN
RIDqOHw8oLZOflOQbEA5YpTuItl6rHJQSlMmgEhbNM6RCAdBdbo=
=tV4a
-----END PGP SIGNATURE-----

--47xjq3ociihvmim2--
