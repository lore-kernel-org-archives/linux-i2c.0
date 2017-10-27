From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: img-scb: Add runtime PM
Date: Fri, 27 Oct 2017 22:04:30 +0200
Message-ID: <20171027200429.cq565fpkedc7luls@ninjato>
References: <1506937741-32748-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="txwh4qdkltlhxbtm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35369 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdJ0UEe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 27 Oct 2017 16:04:34 -0400
Content-Disposition: inline
In-Reply-To: <1506937741-32748-1-git-send-email-ed.blake@sondrel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: linux-i2c@vger.kernel.org


--txwh4qdkltlhxbtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 10:49:01AM +0100, Ed Blake wrote:
> The i2c-img-scb driver already dynamically enables / disables clocks to
> save power, but doesn't use the runtime PM framework. Convert the
> driver to use runtime PM, so that dynamic clock management will be
> disabled when runtime PM is disabled, and so that autosuspend can be
> used to avoid unnecessarily disabling and re-enabling clocks repeatedly
> during a sequence of transactions.
>=20
> Signed-off-by: Ed Blake <ed.blake@sondrel.com>

I get on build-testing:

drivers/i2c/busses/i2c-img-scb.c:1164:10: warning: comparison of unsigned e=
xpression < 0 is always false [-Wtype-limits]

?


--txwh4qdkltlhxbtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnzkUkACgkQFA3kzBSg
KbbvhQ/+PxF6NIXBbwH0AD4Cg03o/72VAuBmUb+3We7SRz/TPnXtbPwSZF1loSRS
T26M94ywW7rLAZ/kt6Q434CoZ6z/VuIsCHpQ4tvYXqzH4tf/wHRoVjdBD9F0J+DG
O6IzYMOqG101TQXreke0tfilY19U4tQI1XWabxIpldePH+WMhGaxlXeepwUmwJdD
a+oxAb7IKudCjF0biydqzokvFDoEkVGlmVBkTtmRskCg7AR103iozT727O1ZyxOc
KiclA5y/V14QwpGfV4A4WUvj8nDCf0zgpDobJ+Na5nDEhkgZZEc4eVGe3tTqUDiH
TZK+t4Oos5xkC/mSzOcXpHXos88mYdVjaFLmVYyL0qTpe55R2s/pUs7eNx3OL7vO
H8MmTTbA9V8l5x+3AiDj14jPU7S9MUcLGXbPEgc+SQAMelI+b4xlBb6Ne/fWCIxZ
ER8CzDu3sh3C8LYB58Y1ivbE2DpBxXNhNXbNHET/t8P+/NR05jCOs+ehoxIZoC19
yIvdvaU+rvxDTgnVq/gRH9OBvu5UvEmjDbwn8kOra8we+lOyYRv7JjXsAjxlrjoD
oDSQvebrkDsRj4JgG7xBkMm2xlMLG+FvWlsFDIMz1ZEJ+YNIxdDZNIc7fUdI7MGs
70Qa56x+vONV+OoV238WY2wXdN/PTLhrciAoKlOExljeZDzvdX0=
=Ofpx
-----END PGP SIGNATURE-----

--txwh4qdkltlhxbtm--
