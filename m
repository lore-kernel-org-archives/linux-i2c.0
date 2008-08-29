From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: s390 allmodconfig
Date: Fri, 29 Aug 2008 11:09:18 +0200
Message-ID: <20080829090918.GP16696@tekkaman>
References: <20080829005217.509a6c23.akpm@linux-foundation.org>
	<20080829104533.0e65f43a@hyperion.delvare>
	<20080829020409.2880013b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2321852155781429214=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080829020409.2880013b.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============2321852155781429214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YV7D9JCVdz8QpFLW"
Content-Disposition: inline


--YV7D9JCVdz8QpFLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2008 at 02:04:09AM -0700, Andrew Morton wrote:
> On Fri, 29 Aug 2008 10:45:33 +0200 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
>=20
> > Hi Andrew,
> >=20
> > On Fri, 29 Aug 2008 00:52:17 -0700, Andrew Morton wrote:
> > > drivers/i2c/busses/i2c-ocores.c: In function 'oc_setreg':
> > > drivers/i2c/busses/i2c-ocores.c:68: error: implicit declaration of fu=
nction 'iowrite8'
> > > drivers/i2c/busses/i2c-ocores.c: In function 'oc_getreg':
> > > drivers/i2c/busses/i2c-ocores.c:73: error: implicit declaration of fu=
nction 'ioread8'
> > > drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_probe':
> > > drivers/i2c/busses/i2c-ocores.c:243: error: implicit declaration of f=
unction 'ioremap'
> > > drivers/i2c/busses/i2c-ocores.c:243: warning: assignment makes pointe=
r from integer without a cast
> > > drivers/i2c/busses/i2c-ocores.c:279: error: implicit declaration of f=
unction 'iounmap'
> > >=20
> > > Some missing Kconfig dependency.  s390 can't do IO :)
> >=20
> > Where is this failure happening? In Linus' tree, I2C depends on
> > HAS_IOMEM (which s390 doesn't have), and I2C_OCORES depends on I2C. So
> > I fail to see how a make allmodconfig can select I2C_OCORES on s390.
> > Can you share the .config file?
> >=20
>=20
> <bisects>
>=20
> It's
> power-support-for-texas-instruments-bq27x00-battery-managers.patch,
> which does
>=20
> --- a/drivers/power/Kconfig~power-support-for-texas-instruments-bq27x00-b=
attery-managers
> +++ a/drivers/power/Kconfig
> @@ -62,4 +62,17 @@ config BATTERY_PALMTX
>  	help
>  	  Say Y to enable support for the battery in Palm T|X.
> =20
> +config BATTERY_BQ27x00
> +	tristate "BQ27x00 battery driver"
> +	help
> +	  Say Y here to enable support for batteries with BQ27000 or
> +	  BQ27200 chip.
> +
> +config BATTERY_BQ27200
> +	bool "BQ27200 battery driver"
> +	depends on BATTERY_BQ27x00
> +	select I2C
> +	help
> +	  Say Y here to enable support for batteries with BQ27200(I2C) chip.
> +
>=20
>=20
> which enables I2C stuff in s390 allmodconfig.  Should it be `depends on'?

Yes.

	depends on I2C && BATTERY_BQ27x00

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--YV7D9JCVdz8QpFLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIt7y+QaTCYNJaVjMRAhc1AJ0RlBYVKsU4MD+sC6GadT3t4bgrewCgj1i2
i69YdqQZeRmNUOkyhYdn/Bo=
=d4en
-----END PGP SIGNATURE-----

--YV7D9JCVdz8QpFLW--


--===============2321852155781429214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2321852155781429214==--
