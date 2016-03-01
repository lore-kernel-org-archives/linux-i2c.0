From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH 9/9] iio: imu: inv_mpu6050: Fix deadlock between i2c
 adapter lock and mpu lock
Date: Tue, 1 Mar 2016 21:50:52 +0100
Message-ID: <20160301205052.GD1488@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-10-git-send-email-daniel.baluta@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455810794-3188-10-git-send-email-daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ggao-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org, adi.reus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org, mwelling-EkmVulN54Sk@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 05:53:14PM +0200, Daniel Baluta wrote:
> From: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> This deadlock occurs if the accel/gyro and the sensor on the auxiliary
> I2C (in my setup it's an ak8975) are working at the same time.
>=20
> Scenario:
>=20
>       T1					T2
>      =3D=3D=3D=3D				       =3D=3D=3D=3D
> inv_mpu6050_read_fifo                  aux sensor op (eg. ak8975_read_raw)
>         |                                     |
> mutex_lock(&indio_dev->mlock)           i2c_transfer
>         |                                     |
> i2c transaction                         i2c adapter lock
>         |                                     |
> i2c adapter lock                        i2c_mux_master_xfer
>                                               |
>                                         inv_mpu6050_select_bypass
>                                               |
>                                         mutex_lock(&indio_dev->mlock)
>=20
> When we operate on an mpu sensor the order of locking is mpu lock
> followed by the i2c adapter lock. However, when we operate the auxiliary
> sensor the order of locking is the other way around.
>=20
> In order to avoid this enable the bypass mux bit once in the beginning
> and remove the select/deselect_bypass functions.
>=20
> This patch moves the bypass enabling in a separate function
> that is called once at probe and removes the functionality from
> inv_mpu_select/deselect_bypass.
>=20
> Another advantage of this approach is that power-wise the mpu chip isn't
> powered up at each auxiliary sensor i2c transaction so if only the
> compass is used this would be more power efficient.

I think the comments (power must be enabled on select) rendered this
solution not acceptable. What about using mutex_trylock in
inv_mpu6050_select_bypass() and returning -EAGAIN if the lock is already
held?


--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1gCsAAoJEBQN5MwUoCm2cK0P/jWqZfS0mQCj/XlMOvVPXoGm
k0Mo92yVOOjiUm+LFKcAc5q8MWC5SdjTELEPP3V/Ai+ByToRnLi1tq+ZId8ogTWY
Aytq/GFt6GUAuZTUOwS6STDa38+54tq/p6FKkzfA3NMMXw0yCTXwifGhNg6cmUay
nsosV1/5X8qrLgGzebA5/RzHlWxzt0NpOStkl6oY1rlWWFzIx7736jeY175ibOx1
MloYwjEmbP0FaIMTZWvRpdYPH3AayiA8+OZlHFWdrvCZSRbJtosw96IfDeYuGA8Y
keKE8eNppYMrTngJWp2rhk3L3wXCyuBqONjY/NHf8lEzi11rIEYSdhktZkhCCsYW
jMJmooZKY0VCEOypwTLSPqMM4MOnvd+6ZZjlrkQcQhOGjR5S22VP6yzfCwAzTzQC
L9BkrQN0joMoFRLkBDOMLlDGYDhOgnr9l1aH9ZUcOtMTzzXCObR409hD4BAiI8x5
8sRimJyxlzLJaP/S951y4QYiwIjcsvw2+K39xzhX9Vrr1titN7snhvKyUnb2wOrR
ZPEeFmPC4mty3bEK1Y0BKYeFbWim98NRe5SwvPOZ7rxi/UozdU1QKD9fPb6i0iTj
BCoGuqgrx+77ytnC7lwO6IMJd9U1nzHBaXXZrcMO4EHOT1pwFariivn7d+2ELOPp
/F3ypwlJLbEhKVs+IZjY
=aRsR
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
