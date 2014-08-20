From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: deduce speed mode from device tree
 setting
Date: Wed, 20 Aug 2014 07:32:11 -0500
Message-ID: <20140820123210.GA1373@katana>
References: <20140820092257.GA21174@leverpostej>
 <944257148.1724.1408528177642.JavaMail.root@abilis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <944257148.1724.1408528177642.JavaMail.root-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, mika westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, grant likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, rafael j wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, delicious quinoa <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> With the patch "i2c designware add support of I2C standard mode" I already proposed:
> - I2C standard mode is selected with 100kHz clock frequency.
> - I2C fast mode is selected with 400kHy clock frequency.
> - EINVAL error is returned if clock frequency is not 100000 and not 400000.

You forgot to send this patch to the i2c list. So, it didn't get into
patchwork which I rely on for tracking patches.

Please resend an updated version to the latest codebase. I like that it
has the EINVAL error checking.

> What about the other patch "i2c designware make SCL and SDA falling time configurable" ?

6468276b22069d4442aafcd8c59e5d8ccae23f5f upstream.


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT9JVKAAoJEBQN5MwUoCm2H3sQAIJTQq4H42z9vdiU5cIB5Z55
nmKDv0oi/VlZzrVrgfbF3fdr0oin06Y5WbD70WvWGyEGZEb+GhpDEHlrqx8xLFNR
EutzYS1Qfc3A12204V2xghnhLGneLGY0bZuiNjAV390wEbnBCq1J1ehsPDVAQBeE
1bUi1kFslH9Lk1fd0tYCPR3bq5OjF1BqqipGRMpcbhGVUyG0YikgIDDVzZrMz8Tf
7RFaXZC8ScHT2ZpiHclmN7A3aZmirIgdz2ItCP3ZsOz+5v3WNKwIkCVZlG8hCn5K
RS3nXr2tgzop7KXB2/awpuNmZVVfa2tS1GHqvq1vEL2yL8CV1oMhOdX57KegK4sU
p189MwzAjAGRF8fEDO6I23NZz1T3Ad2ABLxE2LYG26yhC+Om89mxQj9rSNataslt
AwJUT5CMZ9XbtFHSPj28sEUyaXESOl2c2nl6fdPBXKvt9A/DmYtFujLxd9oWHWJu
AjKVAD0ReY5cO7Gt/dzt+8e/dQdaBBarXyKswxfksl5SkY+FXRc4lOyV/i2RlBv6
I8NLJ2k5kyr0sF7TZbI+m+G8ghoEV5ZdOynmvfWfsze+Spk3TPjhehCQOF7fZ1lu
Xo0ysoh8pVT+TA3cmkq0N1DCQuQNu8qBWDrUfrKruF7byfSA3YBSd7OzhMr4U9vm
kMXDUShBMaOslR6esLYj
=EIDY
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
