From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/6] i2c: at91: Send bus clear command if SDA is down
Date: Sat, 22 Feb 2020 12:44:33 +0100
Message-ID: <20200222114433.GC1716@kunai>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-4-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-4-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kamel.bouhara@bootlin.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org, peda@axentia.se, linux@armlinux.org.uk
List-Id: linux-i2c@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 01:54:19PM +0200, Codrin Ciubotariu wrote:
> After a transfer timeout, some faulty I2C slave devices might hold down
> the SDA pin. We can generate a bus clear command, hoping that the slave
> might release the pins.
> If the CLEAR command is not supported, we will use gpio recovery, if
> available, to reset the bus.
>=20
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

One thing to improve:

> +	/*
> +	 * some faulty I2C slave devices might hold SDA down;
> +	 * we can send a bus clear command, hoping that the pins will be
> +	 * released
> +	 */
> +	if (has_clear_cmd) {
> +		if (!(dev->transfer_status & AT91_TWI_SDA)) {
> +			dev_dbg(dev->dev,
> +				"SDA is down; sending bus clear command\n");
> +			if (dev->use_alt_cmd) {
> +				unsigned int acr;
> +
> +				acr =3D at91_twi_read(dev, AT91_TWI_ACR);
> +				acr &=3D ~AT91_TWI_ACR_DATAL_MASK;
> +				at91_twi_write(dev, AT91_TWI_ACR, acr);
> +			}
> +			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_CLEAR);
> +		}

The inner if-block should be a seperate function, then you could do in
probe:

	if (has_clear_cmd)
		rinfo->recover_bus =3D <the above function>;
	else
		rinfo->recover_bus =3D i2c_generic_scl_recovery;

Then, i2c_recover_bus() will always do the right thing. More readable
and better maintainable IMO.

If this is not possible (maybe I overlooked some logic), then maybe this
will work:

	rinfo->recover_bus =3D <your custom function>;

and put the

	if (has_clear_cmd)

block there.


--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5RFCEACgkQFA3kzBSg
KbawZQ//djH+GtmK3cq1f/dFHYW7brVxy999V22SKk3jREpntfZkN3nb23ARpOvR
JxIHA71f3FR5XIIyLWV0xzU04ZsmwZctcQ5jS15KPNHzHShSRgXWq0ioGAjzxkX2
AKqutS55+2qUGELcX7C/KKeIaLLOfzdvrol4ZPqowCaMrP/DbqcNh/7qL2JB244N
5giSlvyaOmOMIO8ZdMqrA85G+OwHMDcChti8Ba9TxzSmDJRas46XQ9HkwvEEpdca
iUoPbSj3hFaAlplTUVs/j4NlOV0fIjxeC3fGYgXTVIGOD1KvGfh4+f+YI2lV9YDx
lAHcIM6fUTx0+uC4dFWJdaqq+9QfyxHPnCOiH8wIr8XKDvOQbAIu2kP/C80QvhL3
WeK3fl/JMwxLC3b4fFeAvki9Kdzt42IFK2EDXw/uWyDa39Vl1smk3vRDqHkDzKoB
DUZ+BWF9VB/y5qdgN2lvT510u0oiCMW0EuaOgZHrvvB08+e7Z5PNZvJb+JzUaXYo
oSVCsdevMNE7yBX+aBjjOegU8p2ip9jIHCGRiKALM1ab1Vr1co/x3U02hecgTBNd
VOfHwyBQbdukaExvFAmcrCBeWDOCLUj1F6Wy8g38hBhwKcT1kG/xqYflmQdeTKJk
taBIAgbnPcMxpcqh+yphRZv69GXo3KQ9fwygszyHw4KWp4d0p50=
=P68w
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
