From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Wed, 27 Jun 2018 09:08:18 +0200
Message-ID: <20180627070818.4zb3i557qjiicsv7@katana>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-2-peda@axentia.se>
 <20180626023757.l54suaryim2fieq3@ninjato>
 <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
 <20180626134606.h4ciolw23t6qnrjb@ninjato>
 <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zf6jbt2maz3igxh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4zf6jbt2maz3igxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Because, thinking more about it, the problem with those allocs are not
> related to the locking details; adding another trylock to the mix just
> makes it so much more obvious. I mean, first we would specifically
> handle atomic/irq context with a trylock "documenting" that atomic/irq
> users are welcome to at least try xfers, and then we blattantly break
> the rulez with a GFP_KERNEL alloc...

Yes, thinking more about it, I came to the conclusion that we should not
add trylock to SMBus and keep the requirement to allow sleeping.

True, SMBus is not consistent with I2C then, but actually, I'd prefer
the consistency the other way around: I wish we had a clear statement
that i2c_transfer may sleep. And have a dedicated irqless, non-sleeping
callback for handling the atomic case instead.

I really don't like the commit which introduced the trylock
into i2c_transfer[1]. Its commit message even says: "It is the
reponsability of the caller to ensure that the underlying i2c bus driver
will not sleep either." Which seems broken to me because I can't see how
the caller should do that? And most bus drivers will sleep. But that
commit is upstream for 10 years now, so there are probably users. Which
also are very hard to spot, I am afraid. I wouldn't see a way to convert
them off the top of my head.

[1] cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")

> Currently, I assume they are only broken when the alloc happens to
> need to do more than is allowed from the given context. Something
> which might or might not be common?

The only regression now would be using smbus_emulated from atomic
context. Which is a bug on the caller side because it cannot know if
smbus_emulated will be used or not. For the non-emulated case, it must
not be atomic anyhow.

So, unless I overlooked something, if we decide to not add trylock to
smbus_xfer, we are all fine?

And I think we should really keep this clean rule of smbus functions
being non-atomic.

D'accord?


--4zf6jbt2maz3igxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlszN9sACgkQFA3kzBSg
KbaLthAAiIpjV7LeO1ysJ+6fmlhNOOF/vYKrSO63Lg7aXR2l3LopgbNB/QxVa9xq
GWWJ/KCQZmGRW5PbEBwcbDn6ei87VvvXYCHiEZ51DK6dctY3dULc/K7H61IqZvUg
MpRtUBhS1mmKZor0CC7LgskDYMSEJaGpxjAWcSwcHTDKdL5ifLY8PDIYR14+aIg4
Vt7YHjCBxh6nT442XoErHY+/mQsgfrwP2D73GDyHZ3+jA3VI4H2FOmGUZjaMJLa8
3fQqR3k8/9Ppx6FdSeWKT1D4/rU587vj8xGs4qgaJyyz2xbJDdEN8YygS0UTQJB4
neSJm3niDJ8+vZuMzSyj6CW+Xy4xh9mc6H6oyB4oc4ezBAuzHyl4JAzmn9a4TCUA
OegFLaAu+hUwzZ2CeMrdJ2q/xJ2wSztJ+dRrzhKhabsnrgSQ+tBZV4IzQNtRRgZR
PtsIp5LDV707AWLFPoFpcsOyqGn2cIz6M4O+TZQXIlW5q1q5oy2Nt1p5ilAwKPtW
oQYkTV7ToYAE/lYeChHyDQRMlPjmGDUwZvC2uRt9Eq7Q3m12TxdBH5LV5A+x0TMC
JMNhc/hQe3qaU8b+3VxhGVrB84+DhBOFOz6RT/Hr+eEGPGk48p9Yeo1fZo6d0lkW
hH/C0Yu71Zzahv270x5t3vKPU+veqevMpdUaOOckgB7D0InARQU=
=6L/Q
-----END PGP SIGNATURE-----

--4zf6jbt2maz3igxh--
