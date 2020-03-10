From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: use kobj_to_dev() API
Date: Tue, 10 Mar 2020 10:51:28 +0100
Message-ID: <20200310095128.GH1987@ninjato>
References: <1581684997-8322-1-git-send-email-qiwuchen55@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46788 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJva (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 10 Mar 2020 05:51:30 -0400
Content-Disposition: inline
In-Reply-To: <1581684997-8322-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: qiwuchen55@gmail.com
Cc: linux-i2c@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 08:56:37PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
>=20
> Use kobj_to_dev() API instead of container_of().
>=20
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Applied to for-next, thanks!


--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5nYyAACgkQFA3kzBSg
KbZl6BAAg/40J3EgI445pDsUT/AoOr0SlrsABA/ua+D+ObrOCrTv6Kc/JxHASpvz
QgyNbRl01xtpRwnqlRTZkybhjDF5WFGsMz7FvdUNA1/gG2e76Nc4jhXE+bZZda8l
2T7nLNv4zWjJLoXO/uXeAQnBEVdLnnvNu+x/o5K7Bl9IozfHZvejFQHOy6PijAPd
YZNJcNuXng2QNdM7b/FmBP0HS7JQOQKwP314fjG9W/dOHbLqWaMk75YRYd4D8pv8
ky5ziSMPRUK7RyNgVHLcfKN7m4ZyDv49bj4Tb0mDq6E2CEehBTE3h1M7YY9xvRzo
dSK+fxw7HxUDUt7PM7ahkOO3T7PCipXy5TL0wZglTm8uS4KIztQLc9C7jWTmCs50
Gf/F83fY6/cRRsp9sYlwawKUVAs7vYJQTWp1aT4qOYuwkAJI2YV9r9C64JoEOKKE
++7kmzqb+QanDG0Gv0dc/U7Ih1OIlEV7xgtRPJ9VyP1cjdwWWH3Zgs6Zg+Tn0yoL
Df91sOavntR9bXJSN60Q93WMCRt3RWRWYbf+wAnGe4YhrOh9k445k6QDxaUdPinc
PIK7udfegN6nROCQth9F1ZPMooxZx/L/t/hVsojGWX3SPuAmNm6dc8GHM9ZtjhJH
K1N+rjsZWu/x/kSckYxGK3sWTdzZKjlzkH86U3vGreMcFdW71vk=
=FpCA
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
