From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: clarify PM handling with more comments
Date: Sat, 22 Apr 2017 08:16:30 +0200
Message-ID: <20170422061629.GB9326@katana>
References: <20170420100433.7010-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:42724 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1041411AbdDVGQc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 22 Apr 2017 02:16:32 -0400
Content-Disposition: inline
In-Reply-To: <20170420100433.7010-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 12:04:33PM +0200, Wolfram Sang wrote:
> PM handling is correct but might be a bit subtle. Add some comments for
> clarification.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY+vU9AAoJEBQN5MwUoCm2nu4P/juXLIo3loxNYfvlsvnT50yk
bqw8gjE3cz2f+IoyAf++x6b/rJwo2vUN+5kX6rGDwTxoiKtcXoAMXqzvMOySS/6R
9P0EFJAZnK8bESKUVrq9zQ+I38cbXPkkLNPRo1WJWa5hXiYqpggKhfVZU+QHOfYM
ECfIMZMcrLl9gPh7YHjH+WM//LFiCALtacQt6Rvn8jUnN5jSblx2rNb9Es/miJOR
cvbznXMaW5FiQF2KkN/5Hj3XontAx2SDPLhmce5ptq7V7wKPbookOi+jlfoc4lQE
YdrZRin2+RJSOj3T1fz6gtX34U5LdVoxtXOOL+BmG4eTtSJV3cZ2JQKu6gyPF1vK
0k7xNcDihfJVZcPnUmj6ZS6hCz//8KfHvz4sP0UCZR8q/Cu55aqe7/WDdSglzumi
VVOwwYjU/UdfbzLk8hX8pn6iMSHLoxV+lErfe5rrBm2s7ZNYbludqouk05YrAhoO
IG2E2fmyaiDlmjsDNxPyuuggDPnbbzg2+MzHo30GuKOLPXCVy+k2s2RpaspKns+r
pJ6e249F+QdIPaeTG+0cnF9E7MKAap4Zsy4CakGrQPMxvbiF4RIe95qK57MJWm6S
AYtIt2V7chjDrSq+twDSksXAVqh4DZRLF9kLgoZsZEUkfhXmx1MevPXLJlwsMZXx
VEpZ+CAmVNJN6c+cNWzp
=wEBp
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
