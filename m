From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/5] i2c: octeon,thunderx: Check bus state before
 starting a transaction
Date: Wed, 21 Sep 2016 22:55:41 +0200
Message-ID: <20160921205540.GC1513@katana>
References: <cover.1474439371.git.jglauber@cavium.com>
 <21b1db0af4c62a53dc2fcec1e0b1f7b412e6f1be.1474439371.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46638 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933582AbcIUUzs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 16:55:48 -0400
Content-Disposition: inline
In-Reply-To: <21b1db0af4c62a53dc2fcec1e0b1f7b412e6f1be.1474439371.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 08:51:05AM +0200, Jan Glauber wrote:
> Add an additional status check before starting a transaction and,
> if required, trigger the recovery if the check fails.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Won't this break multi-master setups?


--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4vPMAAoJEBQN5MwUoCm25sQQAJkG+Dt2WEIAdsutFrakby7q
nTN1bdeJ3j+mfR6fdLkVvfeZFs2YbC796lz7EDiHZErAavysmq8BBsxV3/tjd62h
zvvv3DaP7TH2drowYzUAvVBuVrv1/nYkQfz3aYtJ1ee3XE0+b6BYi8vzDHWF2E1i
eUrVq9165TQUtOn3ysZe6aizmF0BRYNQ8npn4bRPXrB+in2WiANrYNDPiBdk5oxi
7voI0V8yTf7t1FwgJ4i3FvMyYoBiSXdZ9TkCxfVv6UfQwhtcq7aMn88f3fb0huoB
BHzVyoqPhBY71b3yGy8qoOgp9dqjS8Y2PtkL6KiEqihP/q6lvzV8ch4RuTleh2X7
otAbH6WjGpNzBaAF+bSqCmRPkqYZ7qihBSvFPtAKHNPDFi2qM9Zs2oGne8OxZqjK
b6ZmGVUOIpNAl853JhZb2ILxGLmkxAWOgVPZhBvBRwUHhOrxD/91p1+yIr2s5ah/
tJUNl7Ir94/judYCvoYUNN0/AZnnJLbND2i42E3riryvK9X/9rtIOBWo7pxVo2Ze
nob6y8DFvK1hAr8IYGZlcAivZ88LwpancmC2zyegRYVcEQeoYT6sJ9W6ndQ8oF6k
oIcAVnnwjOA4qSe1VbEhWAV6fZaQJWs5WoDbfLXzCalvHIdrogsUpSs7hNksga1L
LY6vTshuNeqVg6Ex+RKl
=fVIu
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
