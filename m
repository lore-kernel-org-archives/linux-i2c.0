From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: aspeed: fixed potential null pointer dereference
Date: Mon, 14 Aug 2017 22:09:13 +0200
Message-ID: <20170814200913.l7wan6wpmv3tcjoj@ninjato>
References: <20170729010012.5032-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="32qhdm5jlgtls5kd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50668 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbdHNUJP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 16:09:15 -0400
Content-Disposition: inline
In-Reply-To: <20170729010012.5032-1-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: benh@kernel.crashing.org, joel@jms.id.au, venture@google.com, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org


--32qhdm5jlgtls5kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 06:00:12PM -0700, Brendan Higgins wrote:
> Before I skipped null checks when the master is in the STOP state; this
> fixes that.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-current, thanks!


--32qhdm5jlgtls5kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmSA2UACgkQFA3kzBSg
KbYXlQ//WqOJtd9dUU6wKQ3MeWBN42GNgv+nBB2+31uKroACemCZFRuyRJ7ZCVkQ
V/uOxPBCG9hu2zyya0x/qUJGeM3mUYIv3CghO6I5QVz06xGJZD1YHGrualy692Pn
Jr1lCzd00cheC2SMjM5NWRYyExd37o93Akib3yocfXNFtDUuf4nexSc6WLj0pZz6
zDx9sa1FUAr5dZ/N7Gc8wnfScbn5qPqrsup0fdIJvKIvCJLmmOsT3c1FL/sBwo89
gM8EJcj+ZC/nf/f7osKDP5NMb0Leh377m5A5sbvcRl4NSf3hf2JVXA+a2ggTcVUN
pDuRkbzK54KsbAUUOKrKyj7lsHxL9ty/wWifvfQ9vzsTa5B6DPMsE+r1E+rlyYUa
clmwtFYt8ydQgDZnIw1r5s9gmtGTJx7FZS0uFrbuExH1Veyv1m79yXLKo0uS0T8z
lJBW9LZdP2Cn1gjz8Tz3XNkhDHksuZYDkUOzO+EjlSLe43LkLoSp59GbM5h5eGTv
6m/JKpC99dGHDjOA9J8yPe3SyOWXyhCPARFBy71YjcKV8VvhT/8tQDAbj0GczWLW
Lb8VxMY5pdvTcFp3eZrAxP0QW5YQ7ppN3O6Y4curjWlImDiw9uln6nj/t95xU4i/
21Vq/8dmhX+NuIf/2tEVBwfT1WTy53PeOjHiGsXvJ2ig1M8Fq6M=
=HC57
-----END PGP SIGNATURE-----

--32qhdm5jlgtls5kd--
