From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: designware: Never suspend i2c-busses used
 for accessing the system PMIC
Date: Thu, 9 Mar 2017 15:39:30 +0100
Message-ID: <20170309143930.qd6unynjgqd27jot@ninjato>
References: <20170308084713.4815-1-hdegoede@redhat.com>
 <20170308084713.4815-2-hdegoede@redhat.com>
 <728a5859-c4fe-b22c-0dd2-94c48e131134@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mx2zkraid42c5uv4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46323 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754803AbdCIOtG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 09:49:06 -0500
Content-Disposition: inline
In-Reply-To: <728a5859-c4fe-b22c-0dd2-94c48e131134@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org


--mx2zkraid42c5uv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-baytrail.c |  2 +-
> >  drivers/i2c/busses/i2c-designware-core.c     | 11 +++++++++--
> >  drivers/i2c/busses/i2c-designware-core.h     |  4 ++--
> >  drivers/i2c/busses/i2c-designware-platdrv.c  | 10 ++++------
> >  4 files changed, 16 insertions(+), 11 deletions(-)
> >=20
>=20
> Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by ?


--mx2zkraid42c5uv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBaR4ACgkQFA3kzBSg
KbZMFRAAjBJF6nve8Vp5vkipuS0GsFHOXdRLSTsdtZVlj61IluuWWhJM7cADjXUd
TNGz5W2YjkPSApn1zqIycumsogB1sXQICBGft16QQKY8vVQV0DfXr8qoCBvjeNt3
IT5G4Gizb6AR7ObKIgjLqSPrZ7LWx6ntYYn5M2oNmbtrP4z0MXfP+tq55c2jDcPE
YbdnC2JRs9+WNZf8PHCZLnhFXlRNM2gk86r83T7X2dfQD61d54yNnCgS/3kbOAAN
WPyqbhs80niKiS9mRf2ZfdObpItL6AFrlE87XxWwCAGSYVi4xfq/Ytq4F0V+RuHN
NC1zcw+GH8CNPKKrBoC7BksvCXt8JhT8mRbMy06R4uzSJJ4EhpOsOVvrhhYwNMje
k/xLZOfBgyfb6f9eelgmlQDbkz+pjGxnBFa8uAHGkMy7M8TdOQER1ZsHoOrXvlwh
SQ9xxM6Y/HI23HOyB+YZae4NJvHXyVGXdY+rvy95VsgNHpIIjgPhA8q1fXtfuHJ9
ER8UwFdRl8Uu0fk9N95uO7hcb7/Aadzi62VhIbXmumW1SbNMLe1WNyLJnc6p0uhm
nEM6hJo4vb4q1c0yy1r8KzomVU++Bmo32Jl/ltHMsDaS5gHmH4GyAAlSBfQgQIW5
znswZSSwjmLoLyYJIZMN1+xVKVbV2Je0VaCSrar74o0QrmPN58I=
=/Ret
-----END PGP SIGNATURE-----

--mx2zkraid42c5uv4--
