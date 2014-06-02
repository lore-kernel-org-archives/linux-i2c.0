From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C: mpc: insert DR read in i2c_fixup()
Date: Mon, 2 Jun 2014 18:27:20 +0200
Message-ID: <20140602162719.GI2654@katana>
References: <1400247398-23778-1-git-send-email-valentin.longchamp@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400247398-23778-1-git-send-email-valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Cox <adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org>, Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2014 at 03:36:38PM +0200, Valentin Longchamp wrote:
> The mpc_i2c_fixup function is called when the bus is not released by a
> slave. The function generates 9 pulses that should lead the slave
> to release the bus.
>=20
> The sequence that generates the pulses disables/enables the I2C module
> that controls the blocked bus. We have found out on the P2041 SoC that
> this could cause the CPU to hang (for a short delay).
>=20
> To avoid this, this patch introduces a read to the I2CDR register
> between the re-enablement of the I2C module in master mode and its
> returning to the slave mode instead of the delay (the final delay,
> between the pulses is kept), as proposed in procedure from the P2041
> reference manual (16.6.2.3).
>=20
> Signed-off-by: Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

Have you checked other manuals if this always has been the proposed
procedure?

> ---
>=20
>  drivers/i2c/busses/i2c-mpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index f539163..3655af7 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -107,6 +107,7 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>  {
>  	int k;
> +	u8 dr;

Looks like we can drop this variable since the value read is not used?

>  	u32 delay_val =3D 1000000 / i2c->real_clk + 1;
> =20
>  	if (delay_val < 2)
> @@ -115,7 +116,7 @@ static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>  	for (k =3D 9; k; k--) {
>  		writeccr(i2c, 0);
>  		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> -		udelay(delay_val);
> +		dr =3D readb(i2c->base + MPC_I2C_DR);
>  		writeccr(i2c, CCR_MEN);
>  		udelay(delay_val << 1);
>  	}
> --=20
> 1.8.0.1
>=20

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjKXnAAoJEBQN5MwUoCm20icP/iHqG2WgGscXQobJcKx84W+G
3Y/mna8LjW0EwPhquRchQkk93BSajv9rlmB2aUMY+JjBWmbbkCTnPs4LZTRzIqVt
rtrltLpxItSf85bbZ7QVKAo4Gx3F+gNj7v4hw7UNqCf0Hv8Z7owIxFIJUs1IYzIy
OnmlEhWo2TUoVw5xICyjWez7nU6WgCw4+og80603WLLljoSkn0nHpShvTcPQxMEA
eEFESm0Y7egLSpJEOwYioVzAGYaQY+GXKqdDUeDWBrHsUEH/rfyF3zLE+mFioM+c
8NtwXdMokGeqiDCBAc9XbF+JtVQLh75uwTIxuagOJYCFDLW1VjMPHCa+xB/OILeX
3V4fP9pBwPG/1ZXh1y0eQRcdbns7gd0Y0MCy/IwkD9BmoQ5EsR1WQu1ld/e40nwF
viCKw6NayioZpmJfbo6vOyv/Rxjhsf9Ws1PyEPt376e8uG/I9YdMyiaTaRsys4FJ
p1Zs3pkHA2ZYWHcV5a47rsm2GukUXe9fXwSEYtdIbLo/d1Q7ECkxG9rJfITo1lhQ
Xoi0/f5x4Kj4cQWYYp1r9ee9JDcSx2GQRFSlGSQiK7GtDfBREzht552VEvHjd6yp
ArZUH0r8rLaGWjpD+Wk1PiTPulSpWJymlfKK7KNvossAqMCERPlG8yxKwJPaEvtM
6A9kjjUjCkFABRT8QV1R
=y+Ma
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
