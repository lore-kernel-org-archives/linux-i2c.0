From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 04/14] i2c-octeon: Support I2C_M_RECV_LEN
Date: Wed, 23 Mar 2016 20:52:56 +0100
Message-ID: <20160323195256.GD19849@katana>
References: <cover.1458289385.git.jglauber@cavium.com>
 <5dc0231b91f7ead7c556d1a5a9e44e51d89f107d.1458289385.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48056 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756270AbcCWTw7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Mar 2016 15:52:59 -0400
Content-Disposition: inline
In-Reply-To: <5dc0231b91f7ead7c556d1a5a9e44e51d89f107d.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2016 at 09:46:29AM +0100, Jan Glauber wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> If I2C_M_RECV_LEN is set consider the length byte.
>=20
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Like patch 1, this is already upstream.


--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8vQXAAoJEBQN5MwUoCm2h+sP/ifjOpRhjW3tkT8OQqibbmsg
mzZEulQc05D/dqA6jz0QBkPxQ0s7wBbo8r6gVrF0mv4x8l7+LC9E3jdG2ohCr12S
+zS0oLLyrOP5DbbJU4NMgqiddHoQFfm0l5VovrOXs9IpGKgqhSnZPzh2O6HTUHF3
UvK/dtJwHqnlQqyBo2INRhiUBSRF/Go12Vsl9EM1IehabXais9gY3ktL7HU5GeXc
2jTPlr8TcgF7r/poN6VIiBaWU7xEPsJqLY1UFRpktfH1e/OpSty4AmoZ+cqARUXc
5KfxE7y4NUEeCZRAM5uzr9wPxIqMiK//ysYvZ9z1knQV9Cimm+nLWb+5gWJT5UZ/
yq2My/bqbZYTDIio++ynwAdiRM3NN7SGbGXNESjgFPHxIEEdfA6igyU4AWOI2ydt
FsT2ePqFuRuMpJtPMyL67uVc7DsgdPkgDh5iRSszePv/cYJUfAmsCoD2eMUn6Tx8
iirtzJ/D707QRNJnN24K9BNstyjYV0WfnVeGPODK3QRW16Iy9Esy8Rq3+nt/YvfQ
mKmLD724Fetj9xbfANsZdUoc+Nw6UyVBmC7dyFBGi/KzRnXV8HsYhopMs81xa+qe
8tXC7gGWwERKPA0mkOHCYdR4uUpzLKcR+wvtgGpVLXU50uFWam26CrMr3oyFkk2D
3GEOZH6M5rbKvLMFo6AB
=KZUz
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
