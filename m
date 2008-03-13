From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] I2C driver for IMX
Date: Thu, 13 Mar 2008 22:05:46 +0100
Message-ID: <20080313210546.GA4483@pengutronix.de>
References: <frbjjv$ndk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1131604006643805358=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <frbjjv$ndk$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============1131604006643805358==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2008 at 06:07:45PM +0200, Darius wrote:

Hello,

(I know I am myself quite new here. I don't want to boast, just trying
to be a little bit helpful.)

I found some things concerning the formal side:

> + * History: 2002/2/07 use msgs[]
I have been told here that histories are not wanted as they are achieved
through git.

> +static struct platform_driver i2c_imx_driver =3D {
> +	.probe		=3D i2c_imx_probe,
> +	.remove		=3D i2c_imx_remove,
> +	.driver		=3D {
> +		.name	=3D DRIVER_NAME,
> +        .owner	=3D THIS_MODULE,
Indentation seems wrong here and in some other places...

> +struct imx_i2c_struct {
> +    struct i2c_adapter  adapter;
> +	struct resource		*res;
> +	void   __iomem		*base;
=2E..like here and so on.

> +    #ifdef CONFIG_I2C_DEBUG_BUS
> +        printk("I2C: <i2c_imx_bus_busy>\n");
> +    #endif
Maybe you can define a debug-printing-macro that only prints when
DEBUG_BUS is set and is simply empty when it is unset? This should make
the code more readable, I think (or use pr_debug).

> +	// chech or i2c bus is not busy
CodingStyle suggests not using //.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH2ZcqD27XaX1/VRsRAml2AKDB/LWdk9I6qg900YaKrvCKF6KdRgCfS6Px
lS+2OwtqKZMfiP8khwtiFeY=
=qge9
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


--===============1131604006643805358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1131604006643805358==--
