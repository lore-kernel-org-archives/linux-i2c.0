From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: algo-bit: add support for I2C_M_STOP
Date: Tue, 20 Jun 2017 19:28:10 +0200
Message-ID: <20170620172810.h2anac45n5u3oova@ninjato>
References: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
 <20170619103002.5d502c92@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="br77qta5po6srfth"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170619103002.5d502c92@endymion>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--br77qta5po6srfth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > +		bool did_stop =3D false;
>=20
> I'm pretty certain you want to declare and initialize this variable
> outside the loop.

Why? Well, it doesn't matter anymore but what is wrong with limiting the
variable like this?

> > +		if (pmsg->flags & I2C_M_STOP && i !=3D num - 1) {
>=20
> I recommend adding parentheses around the bit matching when combined
> with &&. I know it is not strictly needed and the compiler doesn't
> care, but I find it easier to read, and there seems to be a consensus
> (90 %) on that in the kernel tree.

Either both in parens, or none ;) But doesn't matter as well anymore.

> 1* Repeated start happens between messages of a same transaction, and
> you handle that case above. However in the case of 10-bit address
> clients, there is also a repeated start happening during the address
> phase of the transaction, if the first message is a read. Did you check
> what the SCCB protocol expects in that case?

SCCB defines addresses to be 7 bit.

> 2* I'm not sure why you add the enforced stop at the end of one
> iteration and the start at the beginning of the next iteration. It
> would be more simple and efficient to do both at the beginning of the
> next iteration. The only case where it would make a difference is if
> both I2C_M_NOSTART and I2C_M_STOP are specified. In this case you
> currently emit a stop condition but no start, which I don't think can
> work at all.

Ehrm, probably I was just too tied to the ordering of "first start -
then data - then stop - then next loop" :)

> What about something like that instead? Or I am missing something?

No, I did miss it.

> --- linux-4.11.orig/drivers/i2c/algos/i2c-algo-bit.c	2017-06-19 09:57:17.=
949074198 +0200
> +++ linux-4.11/drivers/i2c/algos/i2c-algo-bit.c	2017-06-19 10:23:26.71108=
8536 +0200
> @@ -553,8 +553,17 @@ static int bit_xfer(struct i2c_adapter *
>  		nak_ok =3D pmsg->flags & I2C_M_IGNORE_NAK;
>  		if (!(pmsg->flags & I2C_M_NOSTART)) {
>  			if (i) {
> -				bit_dbg(3, &i2c_adap->dev, "emitting "
> -					"repeated start condition\n");
> +				if (msgs[i - 1].flags & I2C_M_STOP) {
> +					bit_dbg(3, &i2c_adap->dev,
> +						"emitting enforced stop condition\n");
> +					i2c_stop(adap);
> +					bit_dbg(3, &i2c_adap->dev,
> +						"emitting start condition\n");
> +					i2c_start(adap);
> +				}

else

> +
> +				bit_dbg(3, &i2c_adap->dev,
> +					"emitting repeated start condition\n");
>  				i2c_repstart(adap);
>  			}
>  			ret =3D bit_doAddress(i2c_adap, pmsg);

A lot better! I like it very much. And also

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Do you want to cook up a patch or shall I? I'd just need a SoB then.

Thanks for the improvement!

   Wolfram


--br77qta5po6srfth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllJWyYACgkQFA3kzBSg
KbZjixAAnvO/UoYAe+YjqB9KzZmPUOwQeC9/s6AcVcBHMLan8D4II+f5Q8r2wiZr
eY3ED11GJZU/8XUZxQORxS4hfUwlHisDRZuGeAhxxJqbX5OBwQXsHM0H4wtXWtA3
EuJExwhdntmEcVgfplkaHnwfA9tDTj0tygl/SvMgXbY5c3duLtepTFiDl8aRUMGT
GmnmPNLOr+rBvuQxn3l9YDA5kUOfwThqjo2FiC8nKCEMhfx1ydRIuHoaB9gCec4X
w5nU7j++NyekTDrrM6tHLGBhIqcD/UVtJx3LSgC/b6Me7Jjm/C2bEmoOeEPf87y8
Z7rIIyv/nCaVmIFS5HWIEKhk7k31VCYYOzAX4w604bX8LOZcvULAwFDVcdijciqB
USK6u3ZRiGygvf4Jbd3jjW6hIJ0NmSfTpZIi50LdeQa77hE5c+5IiIPbp6vB0XUt
ioVB1IfqSFNBmH9WPpWt93DX28B51VI7gGM+DV9QqahhCgKi/yvTh/RhVajVdSCc
tOzNrUQx4Hibtl/hgQC1NxR4vDoGzmTHgqTt/F81V/dIULLkqFHLzKaAkSuGdMhp
FTB0OScMWmnupAFoqYH2bhJGU2R3q379rCwReIghbYRdvDXmJW480fGguLfbTqF2
rNnyuKkbglpA9wnSRrua5Vc25VCTJEnEp1d6p7cc6ppin72owm4=
=60wx
-----END PGP SIGNATURE-----

--br77qta5po6srfth--
