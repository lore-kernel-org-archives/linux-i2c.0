From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 01/11] i2c: Export of_i2c_get_board_info()
Date: Sat, 24 Mar 2018 23:38:32 +0100
Message-ID: <20180324223832.7wvhghw77ech4orn@ninjato>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-2-boris.brezillon@bootlin.com>
 <20180324223518.g5jsi5zvoxa75psy@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o4bfgnh3t6tv5z4f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180324223518.g5jsi5zvoxa75psy@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
List-Id: linux-i2c@vger.kernel.org


--o4bfgnh3t6tv5z4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -	info.archdata =3D &dev_ad;
>=20
> Why did you drop this?

If the removal is safe, it should be a seperate patch, I mean.


--o4bfgnh3t6tv5z4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq202gACgkQFA3kzBSg
KbZS0A/+Lxx+NqaVVtw4RxyUPhSWqMVhhNa7swJZTt0ufwzzE9KofdnKTTx04CT5
spVxRVG8F6vb2fg2bzzEUGlj34ZZsdoN7cno1Y5jybrrumyrUj5n4FFrn8bbG21D
uOZanhBrEsRR10OPB+hQTNo/O7zX6d3akaqhfzxMmFRZoAJFHIKeJgokXAscv0A1
/AV//KCOx1vBHAKQdOBnRYDi8SuK210Zi3DNs2i6k3IOsFQZiCeNMFiFCrEgOGii
DJx6sc84xtZLHJz4F80wG2hYMH6eT1cLN2l91H2P4hqoHj6dxJIp7WZrKJZM8Q2a
3Ps09Rsar5Bkb1O0r4PCatjJeRqizKY4FfeswIE0npGTPD9FKKgvD21k9FYHut/c
59XvhVtFVsfER3D0pXstnlj2Amqs9fDrorhEKY5VqoFpSdkVuA5Ff60PwPsu2IJs
CszhIxfgB0DvLj9dsMTwLrjbI2tD5EjPIytUeG/wru+B7vwCJ1Y4jLY8zVWtVnhv
qQtGJFTcq48NEex834+nGynGGPryLN7pvMpTx8Z5wUEZ4Dzm7WBiElqkVUUthaVO
FxtlK2yz/E1p6Kvk3Hnes2VEpjuhFKqQURLpbejEVxpDSeyqcyu7WGvHBETg2G/+
SC08ebAJVGkUQn5FVcheAZ7t2qcZFrrIBCUoF6f7C1JHH2aZ0VI=
=3Qtg
-----END PGP SIGNATURE-----

--o4bfgnh3t6tv5z4f--
