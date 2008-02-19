From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: Complex I2C device
Date: Tue, 19 Feb 2008 15:10:49 +0100
Message-ID: <20080219141049.GD8190@enneenne.com>
References: <20080130144657.GA9444@enneenne.com>
	<Pine.LNX.4.64.0801302126150.6547@axis700.grange>
	<20080131091619.GI9444@enneenne.com>
	<20080219142133.2e022910@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5555570048078505622=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080219142133.2e022910-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============5555570048078505622==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5ti53D4lDBnXC8k0"
Content-Disposition: inline


--5ti53D4lDBnXC8k0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2008 at 02:21:33PM +0100, Jean Delvare wrote:
>=20
> Guennadi's solution (based on David Brownell's work) is actually pretty
> generic as far as GPIOs are concerned. I like it.

If I well understand it I should use i2c_new_dummy() to simply create
an handler for the alternate address.

> >=20
> >=20
> >                  +---------+
> >            --+---+ Battery |
> >              |   | Manager |
> >              |   +---------+
> >  Bus I2C ->> |
> >              |
> >              |
> >              |   +---------+
> >              +---+         |
> >                  |  CHIP   |
> >                  +---------+
> >=20
> > A (complex) battery pack are managed by a "battery manager" and a
> > custom chip connected by the I2C bus (my hardware designer _loves_ I2C
> > bus :). Even these devices can be logically considered as only one
> > (big) battery...
> >=20

In this situation into the driver of the =ABmain=BB device (the battery
manager) I can use i2c_new_dummy() to get an handler to manage the
other I2C chip. Is that right?

It looks *really* good. :)

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                             giometti-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org
Embedded Systems                     		giometti-k2GhghHVRtY@public.gmane.org
UNIX programming                     phone:     +39 349 2432127

--5ti53D4lDBnXC8k0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHuuNpQaTCYNJaVjMRAnwiAJ9V03Fy7QufO4gxrtDVZmZCg9YjtwCfSFF7
bZLvHP2LVvxir9yIHr8mziM=
=RAWS
-----END PGP SIGNATURE-----

--5ti53D4lDBnXC8k0--


--===============5555570048078505622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5555570048078505622==--
