From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fixed PIO NACK error instead of timeout (1000ms)
Date: Sat, 20 Sep 2014 14:49:36 +0200
Message-ID: <20140920124935.GF3850@katana>
References: <1410279571-4552-1-git-send-email-j.uzycki@elproma.com.pl>
 <1410279571-4552-2-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410279571-4552-2-git-send-email-j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2014 at 06:19:31PM +0200, Janusz Uzycki wrote:
> i2cdetect scanned i2c bus very slow if address was not occupied by any de=
vice.
>=20
> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>

I would apply this patch and produce a fitting commit message out of the
text you already sent, so you get an idea what is apropriate. However, I
can't apply the patch. How did you create it?

> ---
>  drivers/i2c/busses/i2c-mxs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 87ee72d..35ae448 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -307,6 +307,10 @@ static int mxs_i2c_pio_wait_xfer_end(struct mxs_i2c_=
dev *i2c)

=2E.. the 307,10 here should be 307,9. Did you manually edit it?

>  	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
> =20
>  	while (readl(i2c->regs + MXS_I2C_CTRL0) & MXS_I2C_CTRL0_RUN) {
> +		if (readl(i2c->regs + MXS_I2C_CTRL1) &
> +				MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ)
> +			return -ENXIO;
>  		if (time_after(jiffies, timeout))
>  			return -ETIMEDOUT;
>  		cond_resched();
> --=20
> 1.7.11.3
>=20

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXfeAAoJEBQN5MwUoCm207YQAISP3JyX9dauBVT8hLKr3yRd
G/hmGaMw/z6mHdDGTSzJkv913qRBkT96AuJHaVeVYkWcqOsCVEh2+g+ruqFSey/q
/Jo3KSg6UV5oAVD3WQg8ztwpdnyp1LcSRZLiV2nyzqkGtUOzXtZYeEyUstD97SSS
wQcKWHMjjbuhIfY+BekQEY3owwR9CQ2HYPefoEln+qbt7+qLsHZTI7lfNYlPbjS8
faBJS7xgN2S3zFhrXylios5EQc4SKxTUiESpWP4imDeVrTKYZqmdkF0YkP40sAib
AHw+B8C47Xt7MwMKObCDtjheG48P+WC7C3QJrm/nKh/TKn1qOw8TNH+uB8Sqf3nz
x3XU+iQqI/FY0yNTn4eCUlslzcX0tulJ9g4CRX7kZrT8g40ufqDEbOim/OfBlw6g
ksrcj2TvTrr0s6wh5tvA1ILkG1y3axInd1PzJahYGLxYWgGeZhAo+5hxzLiLtn3Y
AKjYSZqjmwfuVbvdVR0Ym4wxVpm3o+YtoroaepkmoRzFB0cgEPHCRypZAWs0ZYs5
PodRfxnNU34SuYbE3WMv2kznfYAd9i//5ivM2YpQ7nrelj93xFWks1yHWO1j1BtH
teICet0RghGETzd0ynd8XOyqQUbyGMQcJRqrRSJt7p5MKigObGW4jcafrK6OykJp
TAaal2hEI7TOOnoizKdg
=zwGF
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
