From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: Complex I2C device
Date: Thu, 31 Jan 2008 10:16:19 +0100
Message-ID: <20080131091619.GI9444@enneenne.com>
References: <20080130144657.GA9444@enneenne.com>
	<Pine.LNX.4.64.0801302126150.6547@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3190690982019334618=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801302126150.6547-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============3190690982019334618==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3duvV/J7KUqO/slB"
Content-Disposition: inline


--3duvV/J7KUqO/slB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2008 at 09:32:38PM +0100, Guennadi Liakhovetski wrote:
> Hi Rodolfo,
>=20
> On Wed, 30 Jan 2008, Rodolfo Giometti wrote:
>=20
> > my custom board has a =ABcomplex=BB device... let me explain better: it=
's
> > formed by a custom I2C device and an I/O extender PCA9539.
> >=20
> > Ascii art:
> >=20
> >=20
> >                 +---------+
> >           --+---+         |
> >             |   | PCA9539 |
> >             |   +---------+
> > Bus I2C ->> |      | | |
> >             |      | | | <<--- GPIOs
> >             |      | | |
> >             |   +---------+
> >             +---+         |
> >                 |   CHIP  |
> >                 +---------+ =20
> >=20
> > Some input GPIOs of CHIP are managed by the PCA9539. So fisically I
> > have two devices but logically they are merged together into one.
> >=20
> > I can send commands to CHIP by both I2C bus and the GPIOs, which in
> > turn are controlled by the PCA9539.
> >=20
> > Can you please suggest me the best way to manage this problem? My
> > solution was to provide PCA9539's driver of some exported symbols and
> > using them into the CHIP's driver. Is that right? Or, can I "call" (in
> > any way) PCA9539 driver's methods from CHIP's driver?
>=20
> First, you want to use gpiolib, which in -mm tree now lives under=20
> drivers/gpio and includes a driver for pca9539. With it the pca9539 drive=
r=20
> registers a gpio controller with the system, and then your driver for the=
=20
> other part can just request respective GPIOs as if they were normal CPU=
=20
> GPIOs or whatever else. And toggle them using the standard API. I will=20
> (hopefully tomorrow) post an example of exactly this to the=20
> video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org list. In my case this other chip is a CMOS=20
> camera.

Great, this would be a good solution for this scenario... but I'm
looking something more "general". A related problem of mine is on
another custom board which has the following:


                 +---------+
           --+---+ Battery |
             |   | Manager |
             |   +---------+
 Bus I2C ->> |
             |
             |
             |   +---------+
             +---+         |
                 |  CHIP   |
                 +---------+

A (complex) battery pack are managed by a "battery manager" and a
custom chip connected by the I2C bus (my hardware designer _loves_ I2C
bus :). Even these devices can be logically considered as only one
(big) battery...

Looking at I2C code, which uses the new style driver model, I see the
function i2c_register_board_info() where we can specify the bus number
and the devices list attached on that I2C bus, so I suppose we can add
a function as:

	struct i2c_client *i2c_find_client(int busnum, unsigned short addr);

which can return the i2c_client struct associated to the given bus
number and i2c address.

This should resolve any possible problem related to every I2C
"complex" device. Shouldn't it?

Thanks for your help,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                             giometti-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org
Embedded Systems                     		giometti-k2GhghHVRtY@public.gmane.org
UNIX programming                     phone:     +39 349 2432127

--3duvV/J7KUqO/slB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHoZHiQaTCYNJaVjMRAi9KAKCvtzVFBx+rve22cp6zCHVuJxN65wCfW4AB
4cgP7GBn/U2Ix1LglEHKDQk=
=7INp
-----END PGP SIGNATURE-----

--3duvV/J7KUqO/slB--


--===============3190690982019334618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3190690982019334618==--
