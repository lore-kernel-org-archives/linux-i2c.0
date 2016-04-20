From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 08/19] i2c: octeon: Enable High-Level Controller
Date: Wed, 20 Apr 2016 23:43:54 +0200
Message-ID: <20160420214354.GD1546@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <34aac0bb7c0ae1c0ef7ca43d087059d04d9d8b09.1460387640.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45872 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbcDTVn7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Apr 2016 17:43:59 -0400
Content-Disposition: inline
In-Reply-To: <34aac0bb7c0ae1c0ef7ca43d087059d04d9d8b09.1460387640.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 05:28:39PM +0200, Jan Glauber wrote:
> From: David Daney <ddaney@caviumnetworks.com>
>=20
> Use High-Level Controller (HLC) when possible. The HLC can read/write
> up to 8 bytes and is completely optional. The most important difference
> of the HLC is that it only requires one interrupt for a transfer
> (up to 8 bytes) where the low-level read/write requires 2 interrupts
> plus one interrupt per transferred byte. Since the interrupts are costly
> using the HLC improves the performance. Also, the HLC provides improved e=
rror
> handling.

Much better description, thanks!

> +	while (1) {
> +		val =3D octeon_i2c_ctl_read(i2c);
> +		if (!(val & (TWSI_CTL_STA | TWSI_CTL_STP)));
> +			break;
> +
> +		/* clear IFLG event */
> +		if (val & TWSI_CTL_IFLG)
> +			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
> +
> +		if (try++ > 100) {
> +			pr_err("%s: giving up\n", __func__);
> +			break;
> +		}
> +
> +		/* spin until any start/stop has finished */
> +		udelay(10);
> +	}

Maybe you can use one of the readx_poll_timeout() functions?

> +/**
> + * octeon_i2c_hlc_wait - wait for an HLC operation to complete
> + * @i2c: The struct octeon_i2c
> + *
> + * Returns 0 on success, otherwise a negative errno.
> + */
> +static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
> +{
> +	int time_left;
> +
> +	octeon_i2c_hlc_int_enable(i2c);
> +	time_left =3D wait_event_interruptible_timeout(i2c->queue,
> +					octeon_i2c_hlc_test_ready(i2c),
> +					i2c->adap.timeout);

Have you tested signal handling thoroughly? Most driver dropped the
_interruptible after a while. Mostly they found out that the state
machine of the interrupt handler couldn't gracefully deal with it and
nobody really needed the interruptible. Just saying.

> +	octeon_i2c_int_disable(i2c);
> +	if (!time_left) {
> +		octeon_i2c_hlc_int_clear(i2c);
> +		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (time_left < 0) {
> +		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
> +		return time_left;
> +	}
> +	return 0;
> +}

Drop the debug messages?

I can't say much about the HW details, of course. Didn't spot anything
suspicious there.


--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXF/gaAAoJEBQN5MwUoCm2fTcP/1QdHCxtgvuM4yIBzwlDWy5t
XVb639eIvUmWUNX1ElNox0HClezRTPnYl8X6MKb9YEt4p4b6fKfWgjkcSS9Onpy6
T3eCalFqMrWCw8T3QHnRpsKUxnMlNmrsGocv+SmZWnWZt01MExgnN6M/C03ai3S/
KAcO6srpOi1YWtDPJNot0CEQbwoVG0IsB8BUAwwCp7/CNRN2+87ajyrE1d8GUkUj
FRov1JPaWiY5YbizytOvU2HKBaEsboqih9NemuGULJuG6HE6TFGGg8M8NPpUAt6c
rai5w3fUb+p/XpCxVIiiriyjLU4GXO3Yx2oSRP2+uzzffcss4YwKDpOz/Nus0N3k
jzaODPep1WTUDOKwfA2U6JTziiAU0PwgyHKjGSy/dWG5YsGrQQR/7aC5Ixx2HGnb
+9seaJgXgwH5SrVTMP5jIUIQIP52+aw0jmzjRikzQL5uZ7fJwhkOuAgJjgdZsaVK
xXS5sUJDQNz62QESVQvit1ioLFiinPU2G7n0FWr/TxU8xQCNcWfT49QB9O3qpc9m
J4cHwkVUYI79OKRbX5o6Wr5Ft1G5Pk3GG6U4XF8YR5+F4H5H/VZyWb0fQO9N0YdS
OFLjD7yidEZyDSkaez2tTSr4dawE9JZ1yCB/daeK4htvh7r2XSyAqI3oZX9uIZnX
Rs9M72k4wMD3GckMvMGV
=f7bZ
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
