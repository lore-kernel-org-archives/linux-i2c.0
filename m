From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 00/24] i2c mux cleanup and locking update
Date: Mon, 11 Apr 2016 14:39:59 +0200
Message-ID: <20160411123959.GA4719@katana>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459673574-11440-1-git-send-email-peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt
List-Id: linux-i2c@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

> To summarize the series, there's some i2c-mux infrastructure cleanup work
> first (I think that part stands by itself as desireable regardless), the
> locking changes are in 16/24 and after with the real meat in 18/24. There
> is some documentation added in 19/24 while 20/24 and after are cleanups to
> existing drivers utilizing the new stuff.

My idea is to review and pull in the infrastructure work for 4.7 and the
locking changes to 4.8. This gives us one cycle to fix regressions (if
any) in the infrastructure work first. Is that okay with you?

Thanks,

   Wolfram


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC5sfAAoJEBQN5MwUoCm2kUAP/jQGfszmD3bynHq8tQGbqTIh
+jYVRM0/CXpQCPklXZgusOuo99Aq8PqHnuQz8FA4s8OJbdbJcYqlxUFzoFOWwRu2
1OU4hQRfFKEgcbn8uDdH0nkV+Gzs9TLKQX1PJDOQEITi19kK7nncaOJanY1PWhc3
5ySA/jXCjB43IGOicUNyOt9uJKv/+tL2UzZmYB6vR8HaFhlVSneBuVMERsDrDjBl
8IZnUHxPrehmgQCRB/2mc7+8X2Urm1tayi0wslLrFxKr9++as3+UPK3cJ+7GT/Hu
IvuuC20hlyjW2H5e/KhN60rP/sXmz10nZeZk662VpAkC2Y0euqBQbcnT7eO5VCKx
Ovk5cs1VIYpMIn/0QR0ZAMM246v7M+Pjk+6Wi+v+TavG9Fxprd1iNcjD5dz9wi1L
lz/5P3McULOS09SPbUTF4YhqcPPpma0JsMTjz5MqiEryXbqd0Zv/xx3PIzQ6czVA
/PBHtZkkAp3Brmc0Xh7suVwuayxNBypCKHk61/Ka7dO1UYHQsK3kL+GFEbMeky00
2J7jGXyW/HLvQRPHBAn1PJ8feFpNL0PqYY/i1M9HobHeb1PFOh3yndX3TXaBlVDA
L2dASNJ4hfMqjkp2TqoO7LmFnR7ccQLBI9XezCSRQtrOQdQA3Ym3MvRKKsFAR6uE
+1TcE5VAF4XveeTtw0qp
=D4yv
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
