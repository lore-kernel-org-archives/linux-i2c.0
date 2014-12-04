From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
Date: Thu, 4 Dec 2014 20:03:43 +0100
Message-ID: <20141204190342.GM7944@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
 <20141203111518.GB1039@katana>
 <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
 <20141204184046.GL7944@katana>
 <CAD=FV=Vp3hwxbDzb+FUhNXy8qW8fTCkgd67jRDV3foT0o9HQuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vp3hwxbDzb+FUhNXy8qW8fTCkgd67jRDV3foT0o9HQuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?utf-8?B?5aea5pm65oOF?= <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, han jiang <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, caesar <caesar.wang@rock-c>
List-Id: linux-i2c@vger.kernel.org


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > New binding should have the "-ns" suffix, right? So, I'd vote to add the
> > suffix to the new bindings and deprecate the ones used in the designware
> > driver: "i2c-scl-rising-time-ns" and "i2c-scl-falling-time-ns"
> >
> > It might be a little more work now, but it will help us in the future,
> > because it is the correct way to do it.
>=20
> OK, that sounds fair.  You're OK with my proposal otherwise?

Yes.

> Are you looking for Addy or me to submit a patch supporting the "-ns"
> suffix on the Designware i2c driver, or should we just use the "-ns"
> suffix in the Rockchip driver and assume someone will later add
> support for the new binding in the Designware i2c driver?

I'd be really happy if you can do it. I'd love to have consistency right
away.


--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgLAOAAoJEBQN5MwUoCm2MZoP/2+ZtwoRTOxH7xJMmnmngJTI
y4CXTCTr8ES9GRvGizq0oeMS6/B0JCVKHgwAuD99WXXFM9oRuVwP1XpiuJ2D9AZv
6h0kA4My4RqS0G+HDWvvVTsgNIisBg0X3yY20Me3iE4dG1DRTKPSf4L8UDRaBIkG
86xF1lmJqDHCrdGEoGeL0GPkdQwx5JZuryUf1xJdG6A64lYWljf6jCPbT7Z5JzoL
6kBTSCDmS2hnrEs+iCXjelzsv/DRZNZaQnCxUbhS+nPMkJJ+zU6tm98OQsTaURB2
vg4NVXpiOlSp9bEeTYe5HlYZQzHucdMlsv/s09BBdh8nrVnrcUQx4oC526+8165Z
P4dNfiAbZjR+bVcouSOMcqkh6QJFqtaBdN1v//7rI83iQiNw3onpxFDsLhZsjESA
h4YRBLcyXHv6qQJos+BMgE7FvTkCuV2C34bEnzVHnVvanquNvCx4cPe1oAKwJpKG
OLvMQH6wdpp9wXNXiVMvWLoQBgLbkFgw1McVg+KV01ah1E6Er3YxFL0u/blJYJyC
/6urwqUrA1VJCf9XyvPWlKpJjSv8EpWK4VyY9fbHUt88hkLEWQQPem7Yv0QNhZ41
bVYbliN5VcopeBucrNhsPlEjxOO68EeWA1JqhyLmyAdbI6eqysA+6ml807QOEe2G
joRwygOCCnlnq3Fw9j5h
=nKGV
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--
