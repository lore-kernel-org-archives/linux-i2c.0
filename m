From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2] i2c: busses: i2c-bcm2835: limits cdiv to allowed values
Date: Mon, 01 Jun 2015 11:07:07 -0700
Message-ID: <87pp5f5mlw.fsf@eliezer.anholt.net>
References: <1432895204-19924-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7730466036931941888=="
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1432895204-19924-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============7730466036931941888==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org> writes:

> Adds: make sure bits 16-31 of DIV register are always 0
> Adds: assume minimal divider of 2 if divider resulted in 0
>       (bcm2835 sets divider to 32768 if cdiv is set to 0)
>
> See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Periph=
erals.pdf
>
> Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bc=
m2835.c
> index c9336a3..8195b04 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -50,6 +50,9 @@
>  #define BCM2835_I2C_S_CLKT	BIT(9)
>  #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
>=20=20
> +#define BCM2835_I2C_CDIV_MIN	0x0002
> +#define BCM2835_I2C_CDIV_MAX	0xFFFE
> +
>  #define BCM2835_I2C_TIMEOUT (msecs_to_jiffies(1000))
>=20=20
>  struct bcm2835_i2c_dev {
> @@ -252,12 +255,22 @@ static int bcm2835_i2c_probe(struct platform_device=
 *pdev)
>=20=20
>  	divider =3D DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
>  	/*
> +	 * Divider results in 0 by extremely high bus_clk_rate values
> +	 * such as bus_clk_rate >=3D 4044967297 and core_clock =3D 250MHz.
> +	 * In such a case assume the minimal possible divider since
> +	 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
> +	 */
> +	if (divider < BCM2835_I2C_CDIV_MIN)
> +		divider =3D BCM2835_I2C_CDIV_MIN;
> +	/*
>  	 * Per the datasheet, the register is always interpreted as an even
>  	 * number, by rounding down. In other words, the LSB is ignored. So,
>  	 * if the LSB is set, increment the divider to avoid any issue.
>  	 */
>  	if (divider & 1)
>  		divider++;
> +	if (divider > BCM2835_I2C_CDIV_MAX)
> +		divider =3D BCM2835_I2C_CDIV_MAX;
>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);

I'm not clear on the motivation of this patch. If the bus_clk_rate is
something totally unreasonable (125MHz?  3.8KHz?) it seems like
something is misconfigured and we should at best just fail the probe.
Does this fix some particular problem you've run into?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVbJ9MAAoJELXWKTbR/J7oOUEP+wfJr8wZ0x+C7La76/xIiEc3
tYmyshxniVFPN/mzRNSSia/mQRuRwjYQ/I/VxsNTYEp74yuIoEXASgNZei8kCJTT
2F6QU5u7wajbHgKbp9MoGCk6hwqbyFd70gBAsCROx8oFdEOXglKhvHZ7ip6CdZC8
Dfn2JtHmCLnk6jsCSwyXRQw5vSlSak06GtKCz+oEnGWRJdE9QfikufPGXwUA0RXg
gG5wcObD5NqD/77hDXaEPMBBQJlrxGeTlayJ/tuYAeoEQmVm0lJgFKTNdzSUf59T
ivd7kdVGmLP1JQ6/8wyAfNRVX7YeTDgGRFJZd5C1D3rFW1aa/zh7RAauqGpZBzv/
saEcBL6XQilDqyZV+OjCc6w0QB2PIE7e9+zT8/nYBmhiRivTKNo8hvWLRGeQc9eU
R6jSj2SckvXv2Z+Gywqhabs0FeA8jnbMex14V1F2G/VrH+h7MTxgb5iQOhox7Tp3
+JJh4Cf0uyy1kky+x9Sbltq5vabhejVrG0v3cA/QLs4pM0sW4BKyzypiG9ZfDjGP
nmcLW+TxlDybX0gupAh+cDpJx3s15D+aDN2bxgS96PU6IGbvFiyUzBYiewhUhyyc
c/rLbo5QOsMQwbtC6jrvQjnwDiWgIef+AhiEMpmLbLRcualZgf0VG0G+QQrTm2ek
b7Kz8Y5qzqnrOeqNeD5/
=ZCpJ
-----END PGP SIGNATURE-----
--=-=-=--


--===============7730466036931941888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============7730466036931941888==--
