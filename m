From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Add i2c mux for by pass
Date: Fri, 5 Dec 2014 08:03:13 +0100
Message-ID: <20141205070313.GA1197@katana>
References: <1417734625-13739-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1417734625-13739-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417734625-13739-2-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 03:10:25PM -0800, Srinivas Pandruvada wrote:
> This chip allows some limited number of sensors connected to it as
> slaves, which can be directly accessed by register interface of this
> driver.But the current upstream driver doesn't support such mode.
> To attach such slaves to main processor i2c bus, chip has to be set
> up in bypass mode. This change adds i2c mux, which will enable/disable
> this mode for transaction to/from such slave devices.
> This was discussed for a while in mailing list, this was the outcome:
> Reference:
> http://www.spinics.net/lists/linux-iio/msg12126.html
> http://comments.gmane.org/gmane.linux.kernel.iio/11470
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Only minor nits, in general:

Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

> +static int inv_mpu6050_create_mux(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D st->client;
> +
> +	st->mux_adapter =3D i2c_add_mux_adapter(client->adapter,
> +					      &client->dev,
> +					      indio_dev,
> +					      0, 0, 0,
> +					      inv_mpu6050_select_bypass,
> +					      inv_mpu6050_deselect_bypass);
> +	if (st->mux_adapter =3D=3D NULL) {
> +		dev_err(&st->client->dev, "Mux create Failed\n");

i2c_add_mux_adapter prints error messages on its own, so this is not
needed.

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void inv_mpu6050_destroy_mux(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu6050_state *mpu_st =3D iio_priv(indio_dev);
> +
> +	if (mpu_st->mux_adapter)
> +		i2c_del_mux_adapter(mpu_st->mux_adapter);
> +}

Since those two functions are only called once and don't encapsulate
much, I'd rather put the commands directly into the calling functions.


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgVixAAoJEBQN5MwUoCm2G5MP/161OTKVAacj/Koq/hCKekFi
kSQ8Hx/zQmZ/FBwlfstKQ0V6PiQCKERMjszKrnANDlSN+2XyqPjugp7i4kiEeDjC
YUIOmdnIit9njA17ofeJ2iYsrb0k4vddnbzMa0DOiQX4/XCFyOr39RmzGKDgRJU2
dpQE2H6REfUZJaHX/cdpeiM01zGCzmlDTVsqYj1KJPBfdoLoNvVzRTb42fR7/waH
x40woytbXoeaW29wXQt4k5mbhD9ro6xBOeGwGP+ltaCZhTkapUrEQqqRP0q4IGv3
5zZZ+fKvGGHbO0G+hRbklyULBy7LNu7sYPF28UccQv6tJt5PbAsFmzZGYOh0Rii/
+AoL1n/aJEZLMuGb/0yzJ9EPM2FDAKKCiTJoJl/gqmm3Rum2MqlUbFsTKlVNDwMk
4tGm7JLBCfCFkM9A2wJm31BKz8Rk5kYpWGgrczdEznRs6UIcsBeGSK1M6sSGUbQd
VhOCO9qmzZewB0huKZUwGuQbEcjDY3z/Yfk7gmXEXEjNUd/n0i1KIbNDt1SaxcaC
/Xjaaatn3Qna4NueNvh1kMWWF0N5mSp7y0bih2iDHVVTGNy6V5slXdzcjNrp5JXs
3DCe8fGdKjMwmOO5pDRC3+Njn3KC2G6uGnUhrwZhEnyuM4sifJpcZse3Xl/A0ynx
pcIf0Kc4eqvoF+FZDMS/
=Vt+N
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
