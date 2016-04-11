From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 00/24] i2c mux cleanup and locking update
Date: Mon, 11 Apr 2016 17:59:06 +0200
Message-ID: <20160411155906.GA1532@katana>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
 <20160411123959.GA4719@katana>
 <570BA845.1060309@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570BA845.1060309-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt
List-Id: linux-i2c@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> can obviously take forever. At the same time, many of the patches are kind
> of mechanical, and feels rather safe.

I agree about the mechanical stuff, thus my suggestion. We do what we
can about testing and reviewing. And once it reaches linux-next
(hopefully next week latest), test coverage will increase significantly
and we can fix issues incrementally from there on. Same goes when it
finally hits Linus' tree, coverage will increase more, but we should be
really at a very sane level then ;)

I will  also pick up patch 15 (the removal) for 4.8. So we have the full
4.7 cycle to revert if something goes very wrong.

> Maybe we should give Antti some more time to re-add his tested-by tags
> on 9-12 before they are merged into non-rewritable branches?

Yes. That would be great. I need to sync with the media maintainers
anyhow. I'd like to push all the patches via my tree.

Thanks,

   Wolfram


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC8nKAAoJEBQN5MwUoCm2FhoP/0DAY/OPBBWUqB5QPDKZVfLt
IGcL/mPQHHV7KoIvPr6lJU05+zF2ntB7jKMgDZ+MUlKsSR+VK09RR92dYCEX5oWq
M35Sd6KHu/eMs+bBQFs03xpyMvO9mYEZJe3zIkJxn857BYCMHH2b0s7IzRHpdx4+
B5nCTq0haWkGrUKMIcHT0dVVszd1AqHBguAHA+TcfzGCvo+FhV+3pud+EgB+cVfy
TDUSP6NRm0uPQZLDq6cspxFuMKwQMIhkgzBoxlx/pCALtpC54vBM3TGtOobAaqnx
bntA5HbSolpyGO5IS9WMaJ0zlnHoLZqpUfcEKdAfoe4I459vjyLUKlDfpznu0Dyj
+cgJpZz66shkbWKrIuhrQ/KVG4VntGfm3BoLzcRH0JSFK0QAZGZq7u9EtghdEHvy
gDGRFG5yL5mFNV6RSm/Fu1cgoeN4E8sHjXJI1ckTczWPq2cWrdaWu05IoXKf6Lci
GQcJ4i2wdUOQMlypF7eaFVMl4ZHVIohMC29prR/NRu5fysUCXfZ3DHlX3yCNeevf
5BuHCTh4L9ZhW4BUpbgcXD2uOtWyjUexXG5XwRG+4uvwePqYdkVEkzPpJ378+iPs
thCQA6+4V+QmcrtVjk8clVzJ05wMUiw5DejpALGu3mKDQ9L4qBBGPfiP7vg4FrN6
B0+I8uxSf+1LLniLZvyB
=4NJ9
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
