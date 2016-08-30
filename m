From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: move locking operations to their own struct
Date: Tue, 30 Aug 2016 22:56:47 +0200
Message-ID: <20160830205647.GE3645@katana>
References: <1472159221-10807-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41644 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbcH3U4v (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 30 Aug 2016 16:56:51 -0400
Content-Disposition: inline
In-Reply-To: <1472159221-10807-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 11:07:01PM +0200, Peter Rosin wrote:
> This makes it trivial to constify them, so do that.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks! Thanks for the quick ack, Daniel!


--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxfMPAAoJEBQN5MwUoCm2PjgP/2kkSCiOy+A6ortNmE27sPw3
wcC5WB2lXXviKAeTgyzkO0qeb3G6gTohgEbqMhBeQ/3yGEokAwqyQPL0temW6lXS
7Ht0shWgztFOoGHGUIvgC4jsi5s7KYLhAT6A+/Z4++UHysz7pYW0qez1wDAzVdB/
CFDxadF7KGPHXbVP9bDFkiPhGKQ1HxlguDU2jEaQS0x0KwVx7e8xfJ1edwS4Mz5U
oUea98QF8YSG/x5Sr3ZPZZ0URoj2QuvmEOl/o7CnUxSxUhHffxkjpQP49g83hhO+
obM6c6UKIinzvBjpQHh0jnsTNHjfQsprvRhjTmoXhSF0YdbW4RyZIIKooqyT/HhS
5tZQah9zhwF4HXt8QcwVMAXW1iywrDnFiq6OjBtn6PYugU4XnvhH3dVo/68CIPIT
qBxn05It/GBVuOhw1yKqP4w6rMTZUI9Py7QfWGXNx+GUUL4dthdrRDk4qV+ySVPi
e2oSPnmq3DNq7qngTXd39QPDDGMWMCOUwlVJhSt/qFQ0a7kr/68gPFOjv806Im3O
FDB0B8zcbcr2ahDl8vX+g9MhrnheNqIwOKpWZLOZOGw+xTIQuWsVJmgLl27sBL2J
K+VJTkBHY+IPvpSuMoFGv+gaxYLjiSpLVZK5aCNZLCXLjNCSy36YVq6AJgONbFCj
67hF7yVXgO4B2VkpJbW4
=tU5D
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
