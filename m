From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: add i2c_trylock_bus wrapper, use it
Date: Thu, 25 Aug 2016 18:04:59 +0200
Message-ID: <20160825160458.GA2856@katana>
References: <1469780277-31085-1-git-send-email-peda@axentia.se>
 <1469780277-31085-2-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46080 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756386AbcHYQcw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 12:32:52 -0400
Content-Disposition: inline
In-Reply-To: <1469780277-31085-2-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2016 at 10:17:56AM +0200, Peter Rosin wrote:
> This unifies usage with i2c_lock_bus and i2c_unlock_bus, and paves the
> way for the next patch which looks a bit saner with this preparatory
> work taken care of beforehand.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvxcqAAoJEBQN5MwUoCm2+UwP+QFrP9KHdwtdGYmSXBCuzliB
p4SYi8k83OxRI57vNgUpNFqzcEmO2IFK8MkAfFrRICnXgcJYVPlZ0cQeU+YWJZX5
3KeZrYmCGGlhd6VFRWL6HY/0wjUr9miBcIQ8w8yBzSlHJB33+ZDns0n+i3XXqD4Q
n7kt6aPDuoEXstiQOZSGJohgMWCNsuY6gF/3MnbHahAqvRoUbSdVTBWMI6SGXAwT
Txjlfo45ElkDIblBFuzdgzt2/sspvELlK5EeLMJ+sBdURMmPpgCYAzg4PQSAZ8u+
+O8VCkLzhnqo2ojMCevRnm4cvJ+v9GwLFwAK43Kf1uyQ9VC3JClHzQeNb4SeDbOM
3F/+zdkisqBzBSNaWSUlDpFckw9r5wBT72D0MpK7fHHsrUpqJ28h3cN7qa5EZyE1
9jUHSTjbqw27uvHi6P9Yq9RQ5BHKVAieKBs3qUUsm3yLSf0DrGZnZ22FXJGQTxs7
562RuG30/GKvS0xs5qEpFtWuT7HX2FK8kb7pxEV9FyQxTrzT5pnj5uxenI8yvUCl
3+4AjqoXZqGoptZS+bz81MSSZlKLz5RHm6ZGEjlfBDIxAHhL9CvYTf1VeR4S6JaA
gtdaj6HTS5U+RXCZcsLylQHarqekc/jpp/IqtTlnvrNdMe41pToa12nTpHcONWqf
xQDZdLjGo4yqy3s1K//m
=mMdf
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
