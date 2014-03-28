From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: Fix compilation breakage
Date: Fri, 28 Mar 2014 08:48:06 +0100
Message-ID: <20140328074806.GB2708@katana>
References: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAP=VYLqCmG6fRmPPABoW4xg_tFgGh2pji=f5ML=cBgCu4zZocg@mail.gmail.com>
 <20140321191739.GT27873@lukather>
 <4177769.XedaQsoUgV@wuerfel>
 <20140324094137.GB5416@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140324094137.GB5416@lukather>
Sender: linux-next-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, zhuzhenhua@allwinnertech.com, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com, shuge@allwinnertech.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I think there is something wrong with an interface that makes you use
> > IS_ERR_OR_NULL(). If you are calling reset_control_get_optional(), that'
> > should not return an error when there is no reset controller listed
> > in the device tree. We should still have a way to propagate -EPROBE_DEF=
ER,
> > or bail out if there is a reset controller but there is something wrong
> > with it, but otherwise I'd suggest just leaving NULL as a valid pointer
> > in drv_data->rstc and making sure that the reset controller functions
> > can just deal with a NULL argument, so you never have to check it again.
>=20
> Actually, it's not the reset framework but the driver itself that
> needs this. The framework will always return an error pointer here,
> but we won't ever call reset_control_get_optional if we are not probed
> with DT, and in that case, we will have NULL is data->rstc, hence why
> we need to use IS_ERR_OR_NULL.
>=20
> We should probably fix the reset functions, but maybe that can come
> later so that we have marvell's defconfig fixed?

Yes, let's fix that incrementally.


--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTNSk1AAoJEBQN5MwUoCm2zJIP/2W+h3hcgJycKYPnMACmwGws
7RmhxR61sGyApSZVYoq0PPnxNHdXPtfqnZFj/Q9Y6/ah0QoT2Qq0oFvC8bCWjrOb
atNmz0/bAK2oY6aRvjzT3yPadw9EFgz8q45h+Zcq/PDw4qb9kiH6L/2pehW6vEMl
U++01DgQ06/cidTbujXfC5w5jZnVdBK9utXu2KCarhjoCEC/GGIb192rbQKbE+Tt
g7X5cLfYTDbqpOfidGar7PspnJfmyMrxlR7SY3yB7ndAHI3HIoCaE8DHMI8+aoxo
G6JLKLwUMVbW9/4GI/Ng5FHBsu5wjTRu1m+2ggimaLs2OaeYVGhNVLUOdDvgImb1
gkesUpYhXoD3peYpOOULPhHnM4rCztCKHSV055GduMAeBbmCLkwMenPqfhnUZjky
cv0vFMKJSGENfn5Cp9PzT5eoyKHOwUILlwTEfcwi2fIUEPPfgi9SAzJsLOMZsGmr
NP+cK1QkwP1eaqbzV2cDDA+6h58h0l4XUNBMUJewjN5MCJc7Qle5FMqQueF13lkc
PG/igKBbbLgUfnPUZeGqY/C/ztcf1Df8uL0RsU4A+rdb4nVZQ1USMQb7OJwuzfXq
6bwQjwmLv0BI1l2iOJPCSdikngugphSB6/rbdltvfs6jZlFGiiDh6XaYNvba87o9
2nW8KGriaNm/VhmAk5ZO
=Q2J5
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
