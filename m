From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH] i2c-designware-core: disable adapter before fill dev
 structure
Date: Tue, 11 Jun 2013 20:40:37 +0200
Message-ID: <20130611184036.GD3376@katana>
References: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ@mail.gmail.com>
 <1370597401-22501-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20130607130133.GH11875@ab42.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130607130133.GH11875-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 03:01:34PM +0200, Christian Ruppert wrote:
> Hi Andy,
>=20
> I like your patch and I just did some testing on it. Unluckily, it
> doesn't solve the lock-up problem.
>=20
> I haven't investigated any further but I suspect that on top of the
> cases I observed when debugging this (interrupts after initialisation of
> dev, easy to prove) there are more obscure cases in which interrupts are
> generated in an unexpected manner after errors. The interrupt-driven
> transfer state machine of the driver implicitly relies on the fact that
> all updates of dev which are related to the same transfer are performed
> between the mutex_lock and mutex_unlock calls in i2c_dw_xfer. Thus, I
> decided it was safer to disable the block before releasing the mutex
> when I wrote my patch.
>=20
> That said, I think the sequencing at transfer initialisation is more
> logical with your patch and I wonder if it is still worth applying. Any
> other opinions on this?

Ping. There are:

[V2] i2c: designware: fix race between subsequent xfers
[RFC] i2c-designware-core: disable adapter before fill dev structure

What is the consensus of those two patches?


--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt28kAAoJEBQN5MwUoCm2i54P/Rp003B0Dv5XeKGnpUAmsPN7
CmX5iuHlcc3ICkHaLebjG/KvtCHbZvHHHvboBOZXm3iSkjINjfeX8fR43bO/Jw8Q
PxwOth8nVrWHZwTpUe5C0JpfISCA2mbHrRc2ersL+OFbk9ymS3nwtxwri3etsWJP
9X7jLYpOC/zsMXdFLjSui8wA9hM3UI+wiVyI2WLobeOW3igrFUecHZars6zlkIL8
wDDfpWrvkgNV6J5l3nqr0uYQIRgrGqyWzLy0XN23bcfH4FBxH7mNe+r2fcn5OMcv
3G8v921RX4jvqQhGPyHAnFFuwN1vsnzDxwSocdHfcUdQm5HCG3XQfU/t/Vw517Cv
kn1AioH4zIvnOKXY2me730mQ2ur8JBS21WmvFwFoSh1pVuPdn6CyKgYklLxbcE4o
5m5AgDM72MKyFrzh328RN7WO/JuqqJdgP80NeBayUfq3z5zyyeGoPzkUYTNDWp0R
g0tlNXEZZMUYClcxBrS2Jh3kqCind179k+c9huSq/kbQFCiN9lYKu+S+ig+Qm9L7
Z6jnmOIWkiF2YNTb+0esLV7Sa+a/OjXLEGUfNf+VYYBP/aTbuQ4SkYpLjTQR6iaE
n1duJAv6bspIXBCjYQkxqKJ+OzqkVGvfgiFA23Qbo/wmP6+TnWm3oeWJdDwtDjfx
QdSQped5JXSMEmUh/Sqk
=e1rs
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
