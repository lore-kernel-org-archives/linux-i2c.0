From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 9 May 2017 04:21:01 +0200
Message-ID: <20170509022101.GA2562@tetsubishi>
References: <20170424181818.2754-1-brendanhiggins@google.com>
 <20170424181818.2754-5-brendanhiggins@google.com>
 <CAFd5g47VGa=wqeyg5tFjB5xD=YsTuP27hLN3-ZM62MJD8dCP_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFd5g47VGa=wqeyg5tFjB5xD=YsTuP27hLN3-ZM62MJD8dCP_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Kachalov Anton <mouse-Pma6HLj0uuo@public.gmane.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg-Bxea+6Xhats@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Ryan Chen <ryan_chen-SAlXDmAnmOAqDJ6do+/SaQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +              /* TODO: provide device tree option for multi-master mod=
e.
> > */
>=20
>=20
> I am curious what everyone thinks about this. It seemed that, earlier on,
> people did not like me disabling multi-master mode, but I think that it
> would make bus recovery not work as well. Given that, I think it makes the
> most sense to provide a device tree option either to enable multi-master
> support or disable it. Thoughts?

Check Documentation/devicetree/bindings/i2c/i2c.txt, there is a
"multi-master" property already which I think you could use here.


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZESeMAAoJEBQN5MwUoCm2YSQP/2gqSPIVc08y4YZYIB6b92J+
gKNpDJI9ZDceKPtUr6TGzpdc5Tlb4KZBjHMLhD5pdKYG2ERs1NY9Oi8j4BfxR5kL
RhODk3Mp2IZrZhv4X2gU4ZLv0SzB46t0dDO0TT2WBHsDJOessbgIK/UZX2KoY342
0bKLhOuZS+USKd5xYYerL7CLi0LaKo1MM/+V2Kx8xQhdXSFGj5Qd9ijX3f79pgeL
JjdLoCdvZVmax6kvV3RsHCH3i4rW9PZDgSuUEbFX9CfK2yNKDFgJXTElliycfl5z
GPL36el1tJ+AZZWib72+ZwgzXmakA6l8Sj7s8hpJZC+nyRKxb8ediUfNZm2k5aQR
7KQBJoPaexLDKS0jv6wPf2RAWJkjAdz6/wiEGjia0mXlGFKHvattDy+23hVOR9fb
0wGuq/YvamSqNZif7pgOkMyQThCORffDM+6OBHFZYI5N1dhkHehv7bbgFfjAcg7Q
VpFsy1pOezSBT5Y049Bar2LlRqOrsVRdOoBO41KY8MV3ipBUG5ONyjpVAiESmSTt
NMxK07xkK0TqdxVwLO2as2k5hH9o0EGVw+R1MbgUHsaRGcnXT8Wwz39VzpZGLSPV
m8Z1ZGsljFiFqkZS/wYN9etWrRLEhe/z9WgJXfOFVOoiQSxyUp/WAd9i+uCSLO9J
hqZjimFyVoZ8KzYBAmu4
=3pWS
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
