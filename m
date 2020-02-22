From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: i2c: at91: document optional bus
 recovery properties
Date: Sat, 22 Feb 2020 12:33:01 +0100
Message-ID: <20200222113301.GA1716@kunai>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-2-codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, Ludovic.Desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 01:54:17PM +0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>=20
> The at91 I2C controller can support bus recovery by re-assigning SCL
> and SDA to gpios. Add the optional pinctrl and gpio properties to do
> so.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> [codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org: rebased]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5REWUACgkQFA3kzBSg
KbYSSQ/+Og6OQ8KKYGzfH/m0bVgrt4ZZ6XseXHSbqLqZPLwt0ZdTqJRwTTC4nGoA
VwQTF8w/OteA1gO2MIX9aibT9CAiqVM3lgPKBNyABF9IAHKVLjkm2eqwe3HoGfbX
30iL3vfiJqkXsgN/l+WQiFzEB0Pzb3XfUJd1WDoKyMRckdKsYiUlMX8tQyP8XN2a
qHebhGgDLLIy4Lf/mYdTYmVsa5U+RHT8oTfMlwDUaYNs+u6cx6CuHdN2bkVvKMqE
0BMoSi6MNpE1jY1C3VrfooxqVlGFoxYIC2mlIxDYY1B6pRJRXuot3cNdvudVPC82
B/+MOeJRCRsMAmZ/eOP8sGBV+D978ackCQvKJtHDaOedf7eIzoeTA7BouAQvpqp/
/KY6mcfNB4JQCjQOWnL0gKPfLTf5p2/C8F1ozdefav+en0CyxGA957KStiXy6YBJ
DeJbJz5TMmEbPzFvysflXbFr9h8kfDbPMuiBJjm1ICS3KJMPmMPAoDQPoTPREHRC
F5vK00iTwuiFTHm8NnmD4FT0qN0XJBC3JCU+eVkPlCCd1Jb9WGZVYP78/vXRmYKx
AAn1SO2fM1MzgxEaE84V3CwCRltuMkE7h9EBTPLCO2iKAFMW1ww2F/Mc2zhs1tbt
wMPhow+wsY9KonG0r4xTplzJjry9EcECTXCJUnti9RNZ3Zdzbao=
=+3Bp
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
