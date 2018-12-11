From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c-axxia: check for error conditions first
Date: Tue, 11 Dec 2018 21:05:27 +0100
Message-ID: <20181211200527.t42yj5xcv4ijuoaj@ninjato>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2trzgsti2cxbi6h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>
Cc: "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org


--v2trzgsti2cxbi6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 03:01:27PM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> It was observed that when using seqentional mode contrary to the
> documentation, the SS bit (which is supposed to only be set if
> automatic/sequence command completed normally), is sometimes set
> together with NA (NAK in address phase) causing transfer to falsely be
> considered successful.
>=20
> My assumption is that this does not happen during manual mode since the
> controller is stopping its work the moment it sets NA/ND bit in status
> register. This is not the case in Automatic/Sequentional mode where it
> is still working to send STOP condition and the actual status we get
> depends on the time when the ISR is run.
>=20
> This patch changes the order of checking status bits in ISR - error
> conditions are checked first and only if none of them occurred, the
> transfer may be considered successful. This is required to introduce
> using of sequentional mode in next patch.
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Applied to for-next, thanks!


--v2trzgsti2cxbi6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGIYACgkQFA3kzBSg
KbYrpA//cyXc4G0XUB9HpGQS645etLcUQTo3h0wf9DojLPegTXn2EiCm8SZ1eOvT
voMrmQ9mlkB46ewdn6u2UYZB/QZvVE/IZRP0Wwv5vARxpjcCpMYHK6gdomSwe1YH
Y6NyfW6JAopk+WOkB3zEWAjwo5Kaf329vbIWOLImBpIJGwrg36V8gD0qJRGTfz4E
Dmws4jAeAz0tH/2PhSHualquiObcHO4XWnmEgp9nf7Z4mhfpN7/LQ4R1u7P6wtuk
xiQS5w+jl1iBtBTsIirnNBxi8QlezuqUHqN8/XDM2tmBAFz2OC1wsKMTyWDtIhnZ
SB0Z58uj2zOCZF6fbv6A9C6rJw/umoV0qx41IqngGdCQS8mdICycLWIELz90nwZo
7JyT0Ec1yMvobHoOrrJaDbylyI33Bl4YPjdiEdoRxFHa/zUHIfWK5VmqdiWC/V+K
yJEbumyQc5OaV/T3J4HtCwFEjSZKDMguKmYdmJpIVKgK+Rx/13qiSBVjHdmdGqbj
PAA1OBEH0+VCZBX53WPRMaW/RBJuvN77uTgfuVLD2b2ET/WU0J0vee3yitvF+eTw
6gFDxfCoMyaPSdx2na6gFc5v/DOvi0bnjXiSQnj2wcDiSH5WwQYz+Kt6A84rIuZx
UUD/pj+G2gciiGYINS9UNibnpCmdQ2mK6Rz/QFbs5qpUTp9dVEg=
=jTOb
-----END PGP SIGNATURE-----

--v2trzgsti2cxbi6h--
