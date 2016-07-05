From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i2c-mux-reg: wrong condition checked for
 of_address_to_resource return value
Date: Wed, 6 Jul 2016 00:32:00 +0900
Message-ID: <20160705153200.GD3641@tetsubishi>
References: <20160627092144.GA20023@nokia.com>
 <20160627092624.GC1602@katana>
 <20160627105747.GA20280@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48608 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbcGEPcJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jul 2016 11:32:09 -0400
Content-Disposition: inline
In-Reply-To: <20160627105747.GA20280@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Cc: peda@axentia.se, linux-i2c@vger.kernel.org, alexander.sverdlin@nokia.com


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2016 at 12:57:47PM +0200, Lukasz Gemborowski wrote:
> of_address_to_resource return 0 on successful call but
> devm_ioremap_resource is called only if it returns non-zero value
>=20
> Signed-off-by: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Applied to for-current, thanks!


--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe9LvAAoJEBQN5MwUoCm2Nn0P/2HIQp+pyAWnhk1f6Z7Fh/C/
aIPAxA90vIPrd1TXFxIY8C+KwipsqdRiWJfENtNDU9ztswlkY201Udo20Hdurd3l
rI1FMXjC2VgYfGz/LQtXvMThFdvdB7SO1ERyvr/54P2x+ghLQSqE7W3tgdLiNZPu
pCw3as6bW3v+9skVZcnsdm/xM6BCwUWPBfnF05dyLgAhFKHFCnHOQBnChTkUE5nI
CdqTfzRJroFkwFNGsudKl0we9CkNLfrGHMSF5w15VcX3iX0Y7WQkOY5bTtpbREHG
iS/ct8NIumMOxVBx18JlHFw8zVxIDQpSHwpdKxEWkEhnvJsN6HrEoFnVev4JODMP
SMt2P1szET38ZT4uEju5x3itYQtkxIyv6qWvnmlQn/FAfhmmhSCleGt2KNWoDC+q
UELZr+APqdHSxN20sOfxYv8XbfUDq3qijWU2TivV0EbI42YDZsDPsXsLxWThc0pS
OPuwzbGjdhFSBsPwWK7rj1+WT6QnF4bi75YLZwLUNbeJ/DhQx0TeKk5uO304sOn4
k26RYlhfeCoORd7GSuNc4geBXQCBCxYLGddivPQ1YMvx5ZsZdvcnOdvGu5riMwtG
jj1gpKo9BakMMB/IfqSVCgoJWBC3/kpN9I13FVhfYWzSt/hvkIUkd4p71N8xCzEw
67hf1n2JDWfi14/VOTe7
=rZ8f
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
