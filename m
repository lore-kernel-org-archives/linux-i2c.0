From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Trickle charging for rtc-bq32k
Date: Fri, 22 Aug 2014 09:28:52 -0500
Message-ID: <20140822142852.GA1545@katana>
References: <20140822131150.GA26724@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140822131150.GA26724@amd>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> _But_ this should probably be enabled using device tree entry, right?
> Unfortunately, the driver is i2c driver, not platform one, so I don't
> see how to do that easily...

Trickle charging is usually depending on the hardware setup, so
devicetree is actually a good place to put it. We'd just need generic
bindings so that they could be applied to various RTC. Just guessing,
resistor value would probably be one such property? We would not need
putting plain register values into DT.

There should be no difference regarding DT between i2c and platform
drivers.

You should add the devicetree ML for discussing such things.

> Or would module parameter be acceptable?

No, this is device dependent, not module dependent.

>   * Copyright (C) 2009 Semihalf.
> + * Copyright (C) 2014 Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>

IMO, such a small improvement does not justify claiming copyright on the
driver.


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT91OkAAoJEBQN5MwUoCm2NxkQAKXsavr8KG5W7aKhJKLzlmSj
bAoTge2kV5thmC+Jg1ePHYmC+L5WnSrMbHgCQ7RcHmbzb9uO6BCJeDrOoSQsRwR8
OVs6fruuvhfF/3ASShKKa0P+JFBf1rCU0eU0pmd3Y4YLU1lnx6EbXAQnGv+jtaaO
tkq1nVOUMHf191GY+4fuCz96EplJ636eh/xtgREFnYQBGYI+JmCJgIaPYucUu1ux
/dL1MoCSHQzHAqNp8Hth1mdRrPRXArxpKRkiNpyJ82L4HhPcso6nNTBIK/DAHXM3
xtBmmtpw9TzI14xXO5bWuwZ1c2Es9gXGqnRz2aZf6giTIHCCHfi64kS0ojeBDK2F
KJebaBCgGaY1y8oZ2YzPLTxNNwnF5GY+reohgzM+qynNdGzEAG+dPziBHZfgahuW
OTulNubtpbijNwQ+xNAv7sR1rvY7uXYsGNt+rCj/07c/AQ8AVJKgFOv0xU5unE1I
2ZwFWhmIKUgxFJa9YTPx5mrNEEJZcwgGgisQ4wTZc4Fqsf4I455zpcOTKGHsFI29
fAxhGiwzqlte4RfeZkgMLVNzQ47tDCk6YAGhpF3tCKUw7AoFOTW6rLG692lDSWEZ
10lOdsrTVDz2bNqOjR+w+IPT65IC38X6vYie0NuAC7l1Jm/Q650b4GWUZSSD2IuF
J1QOtNzmk4Mpz45Sf1hC
=RglU
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
