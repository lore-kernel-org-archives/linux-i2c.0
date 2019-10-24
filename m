From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 0/9] i2c: add support for filters
Date: Thu, 24 Oct 2019 20:30:35 +0200
Message-ID: <20191024183035.GA1870@kunai>
References: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2213004300415883606=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eugen.Hristev@microchip.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org, peda@axentia.se, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============2213004300415883606==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 08:24:14AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Hello,
>=20
> This series adds support for analog and digital filters for i2c controlle=
rs
>=20
> This series is based on the series:
> [PATCH v2 0/9] i2c: at91: filters support for at91 SoCs
> and later
> [PATCH v4 0/9] i2c: add support for filters
> and enhanced to add the bindings for all controllers plus an extra bindin=
gs
> for the width of the spikes in nanoseconds (digital filters) and cut-off
> frequency (analog filters)
>=20
> First, bindings are created for
> 'i2c-analog-filter'
> 'i2c-digital-filter'
> 'i2c-digital-filter-width-ns'
> 'i2c-analog-filter-cutoff-frequency'
>=20
> The support is added in the i2c core to retrieve filter width/cutoff freq=
uency
> and add it to the timings structure.
> Next, the at91 driver is enhanced for supporting digital filter, advanced
> digital filter (with selectable spike width) and the analog filter.
>=20
> Finally the device tree for two boards are modified to make use of the
> new properties.
>=20
> This series is the result of the comments on the ML in the direction
> requested: to make the bindings globally available for i2c drivers.

Applied patches 1-7 to for-next (patch 3 is v6). Thanks for your
patience and thanks to Ludovic and Peter for the review! Patches 8-9
should go via the at91 tree.


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2x7ccACgkQFA3kzBSg
Kba+Dg//cHsbTuGv5z7zSiIUbnmUbVpJKyL+PUx03ES4RnXIjjdVJRM/sgyTocpE
zkokcnhPi9H4kv7O7CFo8VGVsQ1v1aBOgLSF9sRvdGB0kdEwRDJGypFLdmYFPpSE
fwxxDvhwCtKkxBtKwxCAmx7aP5wemaNemm1l2dTkC0dLZsfSce/HZQ7Q11MK5V7Y
I7gJMneVuUIw98wcLnut83YULvXC5HJNyKyhmRRivqE5+TZoJTwVIhxiFswjCTNO
Br6JoVz0ODQBmGUOCH4dFkI5X5CsBSRwRNC4V4x0ygr2iIjR/Rd/TU422wqylJk2
91d7wRXozOk/4f//UCxt3nlTeCXhgSUsO+7j6ljkjCHFxY3ONXdJ05lTMPZXJUAc
m0qVQjU73ZMl08RAItQOwcaQi1qiGcNHXJN40aJu3/z7dLjLgCPCKAUjnQTDWrrz
rwZejgvmHmTOd+zM3mmweCFu5v9qkuEeL7UCqLrGYyUHQPF3ycm5N96FkMbgbVnX
lROYUlXXOXp3QBSzqZ/EavNT26siD6joTXpKZMPml5u4VgmJ9MJ1AW7iTHwPZyYk
vqubo6pR02wJ95b9vyEr7OohP5sewbrNpHsk+8Tzyp4AlbcmdoIqMPgVb/77mpKN
frMOQ5tiehviyqrYqbv1IbJANmRg3UQD7RzDRX0lMIMW/BMyHxw=
=u9NZ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--


--===============2213004300415883606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2213004300415883606==--
