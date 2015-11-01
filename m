From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: add driver for Sigma Designs SMP8642 I2C master
Date: Sun, 1 Nov 2015 16:38:07 +0100
Message-ID: <20151101153806.GA2295@katana>
References: <1446312957-18744-1-git-send-email-mans@mansr.com>
 <1446312957-18744-2-git-send-email-mans@mansr.com>
 <20151101064228.GA2010@katana>
 <yw1x4mh5c190.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46689 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbbKAPiM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 1 Nov 2015 10:38:12 -0500
Content-Disposition: inline
In-Reply-To: <yw1x4mh5c190.fsf@unicorn.mansr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The register set looks like the one from i2c-xlr.c, only that they are
> > 32 bit apart instead of 8. Can you check if you can reuse that driver?
>=20
> It does look very similar indeed.  I thought I'd checked for an existing
> driver, but apparently I missed that one.  I'll modify the xlr driver to
> handle this hardware as well instead.

Thanks, much appreciated!


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNjHeAAoJEBQN5MwUoCm2ngYQAKCOOZ+JLzyV9jZ86+GNDlW+
99NsFy8mEW8emuqDYuqmEVMvhmiOXGNeyBubLnapKwUD9+Nix+WAWyeJu1am4+Le
DxBeY3AsD1oeQ6IJcJwu21YAZE/ahZ+pjQumYfqXZZKC9FOGmlZe7P+GONmq6SYp
M+7eldJlAgSLgM9p2+dU6VvuSi07Tt7ldNO+WqFa3nL9qN99CMipHc8oZ9NVYFhR
pT91p+kq97fvei+1zBiB56gnmG0BXivKqQP6ZF34uO0XnDkACaXNxlDBB3klebGZ
xmFtIfcZfmnwUyQkzoZycc5h7eYnq4tOegRT/oppz52zOoiEy+uIV3XPa4N5auW8
kizR6ZWMkHExKJoNyj6qL0+yrtRguWbdman+Oyqv3b0jwmOJzN4IjEEyh9MvOsvd
vbIu5V5LLK1zWgqgW5Ar30mwJfZIPK3cRFbyyeux90l2vMTz06E2+8Eo+CZKeO+W
ixJjjhYr830H0yLNNQlMq1PxiGJbaKzl0DbfdWpmVgmE0x//NyuBu4HaIu12mSRg
cRdoRsBx1mUoGwrcFSxb7B4X9AYFMQVGFuoZzOI3v1risqj2BnE2/6Fgk39ywaOx
pVzhHr3xYANIyJWmgQCoCIohUuHH46ciKcu0lltXoI7PpYixgUlsAOA2NKNVyDtR
rA+S/zGqSSIgu9t0YSCl
=rHRy
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
