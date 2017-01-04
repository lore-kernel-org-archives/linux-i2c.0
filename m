From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 22:55:47 +0100
Message-ID: <20170104215546.GA1433@katana>
References: <20170104101306.GR5767@mail.corp.redhat.com>
 <20170104102118.GD3499@pali>
 <20170104103233.GT5767@mail.corp.redhat.com>
 <20170104112223.GE3499@pali>
 <20170104120031.GG3499@pali>
 <20170104130252.GV5767@mail.corp.redhat.com>
 <20170104160643.GH3499@pali>
 <20170104173928.GW5767@mail.corp.redhat.com>
 <20170104174619.feke27q3ehwkylfs@ninjato>
 <20170104175456.GA40341@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104175456.GA40341@dtor-ws>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> From e362a0277fd1bd6112f258664d8831d9bc6b78da Mon Sep 17 00:00:00 2001
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date: Wed, 4 Jan 2017 09:33:43 -0800
> Subject: [PATCH] i2c: do not enable fall back to Host Notify by default
>=20
> Falling back unconditionally to HostNotify as primary client's interrupt
> breaks some drivers which alter their functionality depending on whether
> interrupt is present or not, so let's introduce a board flag telling I2C
> core explicitly if we want wired interrupt or HostNotify-based one:
> I2C_CLIENT_HOST_NOTIFY.
>=20
> For DT-based systems we introduce "host-notofy" property that we convert
> to I2C_CLIENT_HOST_NOTIFY board flag.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yay, this looks better to me. One nit:

> +Alternatively, devices supporting SMbus Host Notify, and connected to
> +adapters that support this feature, may use "host-notify" property. I2C
> +core will create a virtual interrupt for Host Notify and assign it as
> +primary interrupt for the slave.

This paragraph sounds Linux-ish while binding docs should be OS
agnostic. Maybe we can shorten the second sentence to "It will be
assigned then as the primary interrupt for the slave."?


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYbW9iAAoJEBQN5MwUoCm2XmYP/0gKXGdQuJ4dV7Y7Z0IOl8Ng
qz4TSJXJvGonODQzTwlxYAbehYH17wr77lXaUFuocsuDRhbU3+UK7Pd3E7uHKswr
IF2kcknrrXHZjeQCVnydzLDdJhxROQAaQ3G14vYebRip5wg0Vc3CJ/WGZPucK4pl
H38NAon1g1wkUYjmAyPaaT8yA1lcN7DtfjydLDDLDZUcoy+RcmsUcaps4Ue7ARmp
UGlWGN5T5MTBUjKhEJRL0h1RE1eQkvtFCVSz5RFzWGQA/kn5pAr/Aljazgw2hY76
fylbs4gq0Msx/onPKd+F03oNo/b7FDqNjGFFb+gcI8ai8MMT9jXXHstN/CBbsgi/
EnqMK8UGZixY3/FRU0785Yp43F9gdABq/HTcl43+lBE+e+phQee3L0fe3T9+Pe0A
6U8pxC5q5waBrMSb6hbMTmv6HN7o0/t1rctUXdI09/kujiNXnyqBIyeWbX16N3MU
1bWi7Cg4nOjShZE6arRONk/zgaLwAw3g22Q68hVx6bFQYOvNQvCz4vxmlhLEZRkE
X3iXROFiSKeLM2L86d1La6YIYkre2sriYVVNyTq/OU07addANX4f7tII2uL6qvF+
4idJ+f+xKcX6Kn2bV5fGHo3BCXwJtg3c8UwDRhTJdP7lKgaaGvklSbHDA4LqEbv9
xceDTgs5mlYnzPu7S/IA
=52jW
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
