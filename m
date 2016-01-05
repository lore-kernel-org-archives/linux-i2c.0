From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: linux-next: build failure after merge of the i2c tree
Date: Tue, 5 Jan 2016 02:04:30 +0100
Message-ID: <20160105010430.GA6567@katana>
References: <20151216154813.2566a655@canb.auug.org.au>
 <20160105105507.335a4fae@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59959 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbcAEBEo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 20:04:44 -0500
Content-Disposition: inline
In-Reply-To: <20160105105507.335a4fae@canb.auug.org.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen,

> > After merging the i2c tree, today's linux-next build (powerpc
> > ppc44x_defconfig) failed like this:

Oops, yes.

> >  /* Bus timings (in ns) for bit-banging */
> > -static struct i2c_timings {
> > +static struct ibm_i2c_timings {

I changed it to ibm_iic_timings for consistency reasons...

> >  	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
> > -	const struct i2c_timings* t =3D &timings[dev->fast_mode ? 1 : 0];
> > +	const struct ibm_i2c_timings* t =3D &timings[dev->fast_mode ? 1 : 0];

=2E.. and fixed the placement of the * operator ...

> >  	u8 mask, v, sda;
> >  	int i, res;
> > =20
> > --=20
> > 2.6.2
>=20
> Ping?

=2E.. and applied to for-next, thanks! The patch got lost because the
i2c-list was not on CC and thus patchwork couldn't catch it.


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWixaeAAoJEBQN5MwUoCm2JJcQAIHL1wGYdv0YSZYrASekCKlH
Fs6K62FFjRcnY2wg9vpqDjkWYSC8yhzMly4ThT1edZ9nY9zS+bgGunXgQ1tW1oVH
J1hUfEas5WJsec8+ptDROMu8+mVtoE8UQ2o41jtiUYJ1sxpoG/cT/dpBZuCcn0Vb
Enpsz4BKlDtTEcLT3+YaLpncTA7eTz0USZ+wZozG0YrWIbI6UrL1gT7gSEb6HWII
VFvigjVpB7RppfyCgdRpZyE3PI2VQbDFsY3eko/RonX54pQZ7mw9BTengBjFI6Pe
/33RQfW2FKCEQ8xELGIKFSd7Hk96P2+KutCbsN+MWsGjAHFVimtd3J+qnktgXJZu
HHSr2aQXoRZtfH8hTQRi6I73Q9ZGuNF3gUX0rXeSR/jbLKmfjXM/twRb8K2a3KS1
VJM0EQWtprtSlYUsZ/9X3rV5075noqnx77yy4CeCMB49gzxUOJuGV9IJ0zwfc0pb
ujniyBWYYYAd8DDZ/5FmfyyEBZtG821YkEOC0BsSXYZK11Vf6y6s1NI8Rs2z1Z37
QImxm3OKPjgg2IlRIkmSr0IalyN92JCokmcIMWF8X/4D/8qII027l6KbG4dvbN+v
SehH7fEpa45oo+qvLpyY2xIYJjEoGAXXWz1WWlwxVwbZB5ln01jg1l4a/YJUX7wr
JRHJ5fiPwNiJZYd23fiq
=XSmr
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
