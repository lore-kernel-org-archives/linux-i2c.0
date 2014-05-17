From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch V2 6/9] I2C: Add smbus word/block process call helper
 function
Date: Sat, 17 May 2014 19:17:59 +0200
Message-ID: <20140517171759.GB2597@katana>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398695268-28645-1-git-send-email-tianyu.lan@intel.com>
 <1398695268-28645-7-git-send-email-tianyu.lan@intel.com>
 <20140517102110.GB2602@katana>
 <53776B32.8010400@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53776B32.8010400-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >BTW what were your test scenarios for these functions and smbus quick?
> >
>=20
> From ACPI spec, Read/Write quick and Word/Block process call
> protocol will be used by Bios ACPI code. But so far, I don't find
> such machines. So these functions has not been tested.

Uh oh, I have some trouble adding untested code. Can't we add until we
have a user to verify it?

BTW I have to review the other patches later, so please wait before
resending the series.


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTd5nGAAoJEBQN5MwUoCm2oKsP/AzXQEsPi+RG05UtIYXCkIva
hFs2MdBOcfqNpLuT5zn742q6+6xo7RUHFcz47aV4o+bvFjccOz1HLhDzpLnp9MV0
FyNFGLQqp3d72y7UDhlO8x4k8InYTWFoTSEzEIOijXLILKZbdpNwsj2i517epX/p
273QMKYfn5QhxwD4KmiPSHJviU7ti7cqGzxF1YSHyOxZpoufdjQZ2UPCwHR5532h
z/RBCMfRGCtACm1uyKLKzhuXvDmbrC7TdpQ+o2NwFMOGEQYi2J1LmVQkl87wWrCg
niwNRfDWu7dJhw8tzfVWWDRjGVJheZO/LJ0nMa4/iHToYN3IJk077dWdiubapLua
/eijEiIonXxdJKB2Xu2tv7wE3j6KXCoDWz9tm4h5N9n/T5NOM+bE+p0Ts39ccNTV
SMKknrt7RUyVXRQbI9fydQfy3Sn2g5GKhnrC4Hu0d0KivU3AQoNU/ZoxneNc+N14
QIAjOUX3e+d6DJ6QwixiLgJ4VrZEIA/5u2UgVvS6FR2Jrt/yJUwQ3id+9Dn2bvxQ
mL6KDIwxo6RZN2btrL+FgSdh4AN20xVCsqOI6wW+imfmb3xt4LnNveO8L2+kgQCJ
WDCLTWU8xZpzqdMrKtuMfds9yd8k+BSzSdkB6/sgU1/vhQjftBLlaKNwy6aBVtIG
MvFVxhHmw2cl9P+Ojq9s
=60b/
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
