From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: xgene-slimpro: Use a single function to send
 command message
Date: Fri, 2 Jun 2017 22:28:06 +0200
Message-ID: <20170602202806.35tqyusfptpzgbtv@ninjato>
References: <1493056826-16776-1-git-send-email-hotran@apm.com>
 <1493056826-16776-2-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h2byy34oxolpq7ok"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43742 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBU2Y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 16:28:24 -0400
Content-Disposition: inline
In-Reply-To: <1493056826-16776-2-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>


--h2byy34oxolpq7ok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 11:00:25AM -0700, Hoan Tran wrote:
> This patch refactors the code to use a single message function to
> send command message.
>=20
> Signed-off-by: Hoan Tran <hotran@apm.com>

Applied to for-next, thanks!


--h2byy34oxolpq7ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkxylYACgkQFA3kzBSg
KbZoow//XHNeji7eMoWo2eD4zIHnVLzH/iI6TudEwZ9PuVcw/pB1MR1yIva6QLe3
ZhJ+ajq8HaGB8OQteDfAIlwFmi/FuHHab15QfV/u5a4y5c3TC1fSMLKmE0yy02S5
KJt42d0hZicuREpIaT6RBo6zkCUNcGNk5cYlAd18g14luuqcf/NyAG9mRmQNYj6n
6rZM0B9MZQSLL1nHcL7ETt0xUtIGBQaAVCGAxHY6ERZYVPDjrXZ/EfI5ebX+oivO
8Ga/3jnttc6ZOGd2akGJiRUBonpNuohRxj4tlSeaDczG1hg0VzIAuFXllNZf51MY
wvSHC+ibsZ0IuO2i6VWiw4OiHNYao/wZ6byplsJGdzS5X8SuV9Ok3Vr7Mu752Qjm
Uf45Jgn0Ksn+/3bpjlR++l6kB93xH2fmI/Pdwt23VOnDRCrj63c9wrEs6NGfmFOS
Wwl8rWuI6C/VsuBCZl5y1qptu+HMGkqNvXlOBLttGssxj8zJjdL6ICXnmd2aTwzK
LOrDOQ8Dls5YOw6ZM4ZOHFUkqMstsoYgCkhlFG6JnVBEz8H5UmurLW41qNzUGgSx
qZ6eJgQJk1uFPZvV8rU8n08tA+l/YiXAPkXLWcNgyT05PuGIH9vFI1NM5WBxbQ+D
dEePFJaLce/M15vmulCRUyiR6NAQd1vEiUOCcng5WLJHiGSYMQI=
=Jedv
-----END PGP SIGNATURE-----

--h2byy34oxolpq7ok--
