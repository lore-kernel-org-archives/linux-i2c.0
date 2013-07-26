From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Fri, 26 Jul 2013 01:46:19 +0100
Message-ID: <1374799579.2480.1.camel@deadeye.wl.decadent.org.uk>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com>
	 <CAOMZO5Dyk_5CzcXvG7eJ3h07i=So0DS7MjtMQVHfpfx9Se_Teg@mail.gmail.com>
	 <CAOMZO5A8E54i+hKo5VFWmtuntDHH7O+z6Wb1NL0EkYJ=EQnj5w@mail.gmail.com>
	 <201307240502.36129.marex@denx.de>
	 <CAOMZO5DqeMGgM9uTM5jZ_96_T2dWGBLDUfVf9JNqo2gypLDgvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-hOxLNLt+x4CR5zd00kYH"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5DqeMGgM9uTM5jZ_96_T2dWGBLDUfVf9JNqo2gypLDgvA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, wsa@the-dreams.de, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--=-hOxLNLt+x4CR5zd00kYH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2013-07-24 at 00:09 -0300, Fabio Estevam wrote:
> Hi Marek,
>=20
> On Wed, Jul 24, 2013 at 12:02 AM, Marek Vasut <marex@denx.de> wrote:
>=20
> > Yes, the big question is if we want to use this patch or fix the PIO. I=
 think
> > this one is much less intrusive, so I'd vouch for yours for 3.10 .
>=20
> Correct. Also according to Documentation/stable_kernel_rules.txt :
>=20
> "Rules on what kind of patches are accepted, and which ones are not, into=
 the
> "-stable" tree:
>=20
> ....
>  - It cannot be bigger than 100 lines, with context."
>=20
> Your PIO fix is really appreciated, but it surpasses 100 lines, so it
> would be better if we go with this one first so that it can reach
> 3.10, and then we can use your PIO fix later.

That one is not a hard and fast rule, but small localised fixes are
preferred if possible.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-hOxLNLt+x4CR5zd00kYH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUfHG2+e/yOyVhhEJAQqiIg/+K+Gbtb4Mhb0+s61O7Yl/+KLXYqMskWTM
pAeGuM7/l5A6mmYjb9bNoNKSBBV3h69Klshr46vIfYd8fa38cBZBsr5i5+h1bln5
918Y13VQCkpvMOsM0iwsWOhxmyA2hC6p8aIJS4Vwzu9xQiZN0a2dFHHdKx168El5
jgWtwFh8xRleUYJgJJ9x8Zn5dhVVS0FFV9OOq4UtZ9jEDNYsPl0gCI/GMBEewxAm
wQ6A0xvEO13h/rbsecCUbnv8mcL6+G71vTfJEnlG2uUIxppo+fVCEapPNxdMuvS/
gTZtGkkc6byYiO8EJLUFv1GQMedCD0sylnu/BXECt+h8atpDzVGBMzKL3grXU/fu
rYY4xtMZEvlaJHzra6ai27bfuoqPFl379ICJJSTBYuTeOgYqk0Bd5GqR/Tm/2ruu
V9CnOpDlxWPp7NpCJDQPZ4J/2+bmCwBptf6dN1D5Elx64QKaaVEBDkzNYk9yjkgM
OOk8Vmi4JaRsNNE1DbhverhVGCKNPJj8wBkMAmgFwfdxbHkdpMdd4GBt8bWy2940
NNyikLHc7FXWqg/7BqFS8OhdFRP5mo0Ped2FDgUOvpLOrOO1NTCDB4j4E5S8SlWi
1oQSAw27RyzoXAW+xDdtpVHR6wg4x+BtFNGhm0wicI8i82df9sjFrlNefNOgyTOD
spngjCg7jvM=
=3FCO
-----END PGP SIGNATURE-----

--=-hOxLNLt+x4CR5zd00kYH--
