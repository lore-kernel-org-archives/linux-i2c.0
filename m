From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND/PATCH] i2c: pxa: Use suspend() and resume() instead of
 the _noirq hooks
Date: Thu, 13 Nov 2014 01:21:40 +0100
Message-ID: <20141113002139.GC2062@katana>
References: <1413829432-7815-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <7hzjcqe9ge.fsf@deeprootsystems.com>
 <54482EB1.9030407@vanguardiasur.com.ar>
 <7hzjcnaazl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7hzjcnaazl.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> suspend/resume order depends on probe ordering, so with deferred probe,
> the probe ordering might be right, but it should be thoroughly tested.

Thanks a lot for the input here, Kevin!


--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY/mTAAoJEBQN5MwUoCm2TXAP/R/Bs4ATy4iJRuUqGibRRkBy
vimsHp4gLPmKpQF3qNRuQgiOLSTrv60TMgH4LVmFyQZEsEpngtZZ0CvBKg3OfjjL
hlS+mKeBkFQZOvoaKjiAp6w/mPmkBHJgJVaVRhvHUcFsKokogxZXfBYzd+KGrD8+
Yi0tUpDuzlztRzQOMZd3JNGzH2SnLPd0GqhYU+VsoL/MtX/kEGR62/A8zIOQu9ab
JshyWvjoOl0C8UEzjfoRxgMdze/JvzJ1in6AvZ7DdsfEaytZ5CWqxaL+gbFU6cCr
PVt5uh93gdqCJdapM17DsZjFtsVVzdqrdIeT6mgDkJxbbFGnU0ZerEzb/ihfMUYs
kE7i2HMeua+XUENmt9dXeEshVlUPbIga1EhNIVOY6vsPMtwLsTLZu9mFq+XhpmNG
VpW6tEwBQihDeMo+LJbQKR/arIPbSySGia/hKoh7YGJMjveikbtXmpTm66l18oHj
nEzcbCBemkOfgoJLdz/K2E7TTUDegy7OM7Xu5rXsQ2+IvYNvSOJlH4GXJsgtJArQ
qmCNA2KY/Db3uHseKaM46rnk+HAo6zRMYoijiE+6M7yiy6ggT1Y1vMrgXDDZm68z
OHf/LeLT+H9IQKdCyCsNnfDKbFODIksUZByROgyC+I/ORAAzlT7w4/Wa0H89K14C
1RjmuyfoIZpjUsHYxeZx
=s7ht
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
