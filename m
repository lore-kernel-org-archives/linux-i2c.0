From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] i2c: designware: Avoid initcall and initialize the driver
 like a regular one
Date: Tue, 23 Dec 2014 16:26:21 +0100
Message-ID: <20141223152621.GA3692@katana>
References: <1419272149-28716-1-git-send-email-walter@vanguardiasur.com.ar>
 <20141222190233.GA1014@katana>
 <549982BE.3080500@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <549982BE.3080500-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> This guarantees it will probe after GPIOs drivers.

BTW this is not true to the best of my knowledge. It will make that
"very likely" but not "guarantee" anything. So, the race window is
smaller but it is still there. You need a proper fix anyhow.

> >> Platforms based on devicetree won't be affected by this change.
> >=20
> > Huh, why is that?
> >=20
>=20
> Unless I'm missing something here, our beloved DeviceTree guarantees to
> model the dependency between I2C slaves devices and the I2C master their
> connected to.

Frankly, you are missing quite some things here. The I2C core registers
the clients when a master gets registered. No difference between
platform and DT here.

> So, a machine fully-based on DeviceTree would never attempt to use the I2C
> bus without first registering the master, right?

Neither would platform, that would be quite a bug.

> This means there won't be any early users of the I2C platform driver in t=
his
> scenario.

There won't be with platform as well. But I think you are missing the
point. We are a *consumer* of GPIOs here. All of the above has nothing
to do with GPIO controllers being already available.

> >> Legacy platforms, relying on the I2C being available early, might need
> >> to implement proper defered mechanisms to overcome potential problems.
> >=20
> > NAK. We can't say "Let's cause a regression to force people to fix
> > things that used to work" IMO. You exactly pointed out the problem that=
 using
> > subsys_initcall() creates.
> >=20
> > What about fixing the drivers you use to support deferred probing when
> > acquitin the irq?
> >=20
>=20
> Maybe we can fix the legacy ones instead. However, a quick look shows the=
re
> aren't any!
>=20
> $ git grep i2c_designware
> drivers/i2c/busses/i2c-designware-pcidrv.c:MODULE_ALIAS("i2c_designware-p=
ci");
> drivers/i2c/busses/i2c-designware-platdrv.c:MODULE_ALIAS("platform:i2c_de=
signware");
> drivers/i2c/busses/i2c-designware-platdrv.c:            .name   =3D "i2c_=
designware",
>=20
> Looks like this patch is pretty harmless.

In-tree you are right. Out-of-tree, you probably aren't. I wouldn't care
about the latter if that would block a real bugfix. But since the above
patch is not the proper fix IMO, I prefer being stable here.

Regards,

   Wolfram


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmYmdAAoJEBQN5MwUoCm28SQQAICl+HSUIwlAWadE74c52KyY
uKMDVRPmjKaLxkANGFIofTeXXUFt0GMFrc57OFWr60bkMZreMczn47JQ/t1Em7ci
u2znC++K7xL1lntR907COTq2Lcdqi4uXcO3Dya9Qj+Hocmip1eeZ3OPBAnk+5A01
YU1ziNSQxQMN/dRe3FH2LBINGlAVkv9Lc/HgotrAPHZoWbCmMecN3jE/OIN+nJ8t
bcXvJKQ8NdDlAEvVFt0Fv7RxZ6u1e98onFzMKngiLAODbK2dUQ11jQaH/03Wo/yy
REgzz0WFfRWGc4UILFg5SIkcjRF6CZqRpt8KN9oRDQx1j9sKJdY6Lpxz+6pYlCW7
91pZ1PILXmN60kS3qNrdyzS27c/vMUmqV+eCP31Q4ugXKYmIm4nOvV7P9sp+tJe+
eTSiKKLN5yLXpJlL+GWVHznBsZbIvU0sAtoyEzTdgjqTlCrrA/h1O2MavUK5n8ui
0nRnOKwl9ye0cS9kXV80rrZK9N4AMSWYwROMqGfO6eLOTiN67LxQRdaI0wMUUUfI
3y/YOfO2ovdjjPjQThKS/Ut2IiTUnc0dy1YNNeiqS8E6Dr+0Du/+Uv7dw+FqAEeP
+hRYWuwG+B6YLp55EvLZ8hnu3hY2ySMxL5EvyuxSUnNAe3NrxdfFD58lxzr2q+6F
shE/Gkq0UMAe0rkwehXK
=D87P
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
