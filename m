From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: designware: Allow build Baytrail semaphore
 support when IOSF_MBI=m
Date: Sun, 19 Jun 2016 19:31:13 +0200
Message-ID: <20160619173113.GG2933@tetsubishi>
References: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59156 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcFSRbT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 13:31:19 -0400
Content-Disposition: inline
In-Reply-To: <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2015 at 01:48:44PM +0200, Jarkko Nikula wrote:
> I believe i2c-designware-baytrail.c doesn't have strict dependency that
> Intel SoC IOSF Sideband support must be always built-in in order to be
> able to compile support for Intel Baytrail I2C bus sharing HW semaphore.
>=20
> Redefine build dependencies so that CONFIG_IOSF_MBI=3Dy is required only
> when CONFIG_I2C_DESIGNWARE_PLATFORM is built-in.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Finally applied to for-next, thanks!


--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZtbhAAoJEBQN5MwUoCm2NT4P/1CnrNj9EzNCVpNhhEp0S+Sr
qp7358dvpO5nI9D5jhcmw8ny1Z/7McjWnEnrTGOGZwdKHfYs47WIMBtdc9CRK6ix
PTvkWibybIdVZDofBDX27AD1uyUkzueez1mBvdNVs7NGNT/U08i0R7GyFz+2ArgP
YQx142UI8RH5z2d90OyEEHcwsSVCV+qGLDIhgKYygs8kthY9fOgyULjtXQBEWQ8e
Fo687cn2E4AuVyZnC1sWVJYeEmF7BSMrZ6Uc/AMeD2ExrC0CfT5qO5yKWIYi6Mu0
B9IHS4ZzzhecS+RLMASLLrHY9lcHkaw+VGDK5kGA3ZYYHerYR42MQS+vTPlwByWN
a2dMAJiMAipAmlrte2d4h+FyR2gilImDmMVIJHMnVqnKU2cPhD1UR2IZI1pOlc+n
aLzvtrwDPKxYmY2IoRs1zsWn5LmNl6x2SNNKjI9qEArzKd9kCz1uWmtEJyLjTPAt
JL3kOdWG8dIijVwxIlDVEJ2s3ExwNtCtzCLN9hhY7QPTBAAcBHXGzR5lF1XaBLsr
PbjDOmM1SQaSSS1sw/PmwVYLUt7raWbbbX3XG0yJU0IyuYoU4fy3O6ZGWDFwHL/V
wiQwwsXj6M879l4v+yFFvh4/xKZW72Qw7IizTVCv+ObMAJEpnbUlDFa7qdXi3DD3
d1EAlbcLbtg7Cnlfawmi
=p7ex
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
