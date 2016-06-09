From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: octeon: Add retry logic after receiving
 STAT_RXADDR_NAK
Date: Thu, 9 Jun 2016 22:11:51 +0200
Message-ID: <20160609201150.GH23522@katana>
References: <cover.1465304877.git.jglauber@cavium.com>
 <2cc75a97f920146edc7af389870e271a8a056dd1.1465304877.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34828 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbcFIUL7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:11:59 -0400
Content-Disposition: inline
In-Reply-To: <2cc75a97f920146edc7af389870e271a8a056dd1.1465304877.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 08:51:18AM +0200, Jan Glauber wrote:
> The controller specification states that when receiving STAT_RXADDR_NAK
> the START should be sent again. Retry several times before finally
> failing with -ENXIO.
>=20
> Without this change the IPMI SSIF driver fails executing several commands
> like 'ipmitool fru' on ThunderX.

Huh? Looks wrong to me. I'd say the client driver needs to retry. Only
that one knows if retrying is appropriate or a waste of time.


--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWc2GAAoJEBQN5MwUoCm28gwP/2oB+CSxJrIIuhMfUCZqtkl5
rzBI8ErhRydBglBoK4cwI6PUdHaNabtlAvOCOZ5vQYPBZZuTJuxNO0/NdBhRJPWE
hGq5ZwoaY50U+S3SpWzclfi81uQcb50CXyD9DXX0WcuSuS3QuxLnbD/hOv0O43Rh
Wssf+EqhbEJxtxz6ckcBxMJWDyftPE1Jv3UDMw+fBMfJ8/crcODsJvGw2sfNIrdq
k2Xwj3QAKJ8oTy5TS+za6F67gWjz8lHNEd9Ca/CsAOPxD7grwkhVOvhxsq3+fyHX
vpKTuHlmNT0MpGEQAwMl0C/2TvIe7EbH/f68Ma8+PiD3kLRkklT/gqdwmRhZFBw4
VSVr9F5a20m6q3co9xsuPrmVeGDsh9xJKEfwMD4ai6usgW7765VokuJ6vk+WFdUx
5xqtHCoymDbVhNPNa4Y1jvwR8HN71lUyYcj0ys+Palq6IuqhDffAifItcwAGUjBB
2roLrS9wwqFiuwueBKTlB/7QkFVSzXr60/tM3Nafnmw28fZnb5Gp+/tUrxsIKpIR
AQOSVvkdPsT9J3wRsRJeXfj/isLeXQU63bNFHzjbQgeVTGnikFaNGeXqLaOs9XjX
DNxvzbxwYxr32/VwuP/CvY0uWvXkjii8ccHG9LxtOWM2q/jwaT/73VDu7gn5SNwd
fi/AlhrEnNCc0iSf6ueu
=/+Yi
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
