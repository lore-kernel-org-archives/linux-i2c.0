From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cros_ec: Remove EC_I2C_FLAG_10BIT
Date: Fri, 27 Jun 2014 17:59:19 +0200
Message-ID: <20140627155918.GA2637@katana>
References: <1403558406-14519-1-git-send-email-dianders@chromium.org>
 <20140627123443.GC29156@katana>
 <CAD=FV=WLw2D3sw2LaWt0SJXNEFSBk08eKOCa9O_zt=58UN+MLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WLw2D3sw2LaWt0SJXNEFSBk08eKOCa9O_zt=58UN+MLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Thanks, that sounds reasonable to me.  Lee has Acked the whole series
> and Simon Glass has reviewed it too, so I'd imagine that we're just
> waiting on the input subsystem's Ack on a few of the patches.

OK. I assume it will go in via the same tree as the cleanup series to
simplify dependencies; if it shall go in via I2C ping me again.


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrZTWAAoJEBQN5MwUoCm2/30QAIUPL1T2DHZ6X5pDarXV5h+5
qv6vvhyZ7ZyFz0u2nrUL+SusOUc0CYaH+EQEcjr5zpKo2tMPSjFLrSMVsBjjhRWG
CFDTES7+sRRsirHwTUtKcYiENGXj2lNsyt9uDxGRh9UvJRcnyqg6Y3B2gE9BLPn3
j8aCrFiqXJr0UorWftTbpR0Pr8WHDROOdTrZ0ojN2ARnWqhFkcmiGjiE71uUCvov
GAPxhjI0jNgDwag0Tudgs8bsQWmNeQr0vlk2p5GcbLg33UmqUhogtaIxlA1O5tGj
yRuhB7YvnitYjRxgCKIY17rMIvTLYQjbQJHN48GHl/gtlTwXMt+/XolTNQQOSPUJ
hqXwO1s1Xvyd3vVjnCgwd+uOM0QHVQwkMuEWw4tv+kPK5ZvYjFdJw/EuzYTVeDIH
M/tHmuVCPLX/7t2cFtSXPS6ZqquS7I8QygJM38aCWARCY1sAEJHaE+AFNJEkpYS/
NDlw4xxO4IO86yjq88KV4hGyuZIEOfOeQkX4oRPOVoF0VLc/x4f9SSDLBglhg+RW
c99PxhYd2ewaEQcJlekrpngRSSi5FFwsMerybIa1oTZGv/CfsynRzBmEcVBijuVv
xHoe4pOBcRpjE03MecsPU2USKjmQL19llVbtAGFF9fu2b3NqwRuY+bubC4NxmuvM
TH9dT2KLHHkfKrHzEc/j
=lsS9
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
