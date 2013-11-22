From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Fri, 22 Nov 2013 15:33:51 +0100
Message-ID: <20131122143350.GA7420@katana>
References: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385129228-11225-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2013 at 03:07:08PM +0100, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>=20
> There are still I2C unexpected behaviors which are solved by reducing TWI
> internal frequency.
>=20
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> #3.10+
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

I think the commit message needs more details. Is this a true bugfix
because the real bus frequency was too high because of the wrong
divider? Is this a workaround which makes things work but will make the
bus frequency slower than it should be?

> ---
>  arch/arm/mach-at91/sama5d3.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> index 4012797..4ee0de5 100644
> --- a/arch/arm/mach-at91/sama5d3.c
> +++ b/arch/arm/mach-at91/sama5d3.c
> @@ -95,19 +95,19 @@ static struct clk twi0_clk =3D {
>  	.name		=3D "twi0_clk",
>  	.pid		=3D SAMA5D3_ID_TWI0,
>  	.type		=3D CLK_TYPE_PERIPHERAL,
> -	.div		=3D AT91_PMC_PCR_DIV2,
> +	.div		=3D AT91_PMC_PCR_DIV8,
>  };
>  static struct clk twi1_clk =3D {
>  	.name		=3D "twi1_clk",
>  	.pid		=3D SAMA5D3_ID_TWI1,
>  	.type		=3D CLK_TYPE_PERIPHERAL,
> -	.div		=3D AT91_PMC_PCR_DIV2,
> +	.div		=3D AT91_PMC_PCR_DIV8,
>  };
>  static struct clk twi2_clk =3D {
>  	.name		=3D "twi2_clk",
>  	.pid		=3D SAMA5D3_ID_TWI2,
>  	.type		=3D CLK_TYPE_PERIPHERAL,
> -	.div		=3D AT91_PMC_PCR_DIV2,
> +	.div		=3D AT91_PMC_PCR_DIV8,
>  };
>  static struct clk mmc0_clk =3D {
>  	.name		=3D "mci0_clk",
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSj2tOAAoJEBQN5MwUoCm2aTUP/ihqVYLtE6hKusP8jRuKzvT6
EdGC6gayAY64FDjPy+/m7gUsFH49cUbJ6hzsp7E7OVAKpJTbtxjdyeHoFkLTVdtz
Vih6qh62k3stIylA649z30qLiI083N3g3RjgAGhZzdaWJvAmewZWabJACVjKmhcG
BRZoa41Op6uZJxKscDfSdi9GVTst5mEgdZIlhWdEjwHEe3oALoZEfJlZ2cJAdc8w
JvQCt6TwFFh/kxOeQwxzZFyEb9bRP238oGIALQS77Ky859oedBqrieu6DI0mlwHX
+EY+PMT7yC3y05glnS9c7uiNZPrJpLKB0JPBjQF629PiRYuwFZ4iCuKZQUViOsDS
PGGUi7vR0+B55o6j5apOOpRY5omD13ysT7pWc1dpK9o/l70m/krO4IMSKp9mISUg
H3rJ0/BY6+MRAJUOIDRrfiI9tbaIO6r1oeLp2c1xmAZm/0BMq1AI2neKtODpmPqW
S9rxS1AjAx/juksCOHQ1vbzAlNeQvuDWPjxTLqgFfgPbPUy4egYChgTeMBcfcLNI
fLEhO2Oouh8wOPlUHtoJJuG6nvPyOBfFTIHq2ag0iC8tDXg2wmcE8zcswCI0JHSF
v+RdL/Gyr7HZ98RUMfL2B2C3FmfF7bzq0KFgzAAl2oYyp2wmSf6IjT4FzM9yJxO4
dvmcrzlrNvwsGn5oyeeG
=2fAa
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
