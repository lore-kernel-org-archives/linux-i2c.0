From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/4] i2c: octeon: thunderx: Remove double-check after
 interrupt
Date: Sun, 11 Dec 2016 23:01:32 +0100
Message-ID: <20161211220132.GF2552@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-3-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:54744 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753870AbcLKWBe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 11 Dec 2016 17:01:34 -0500
Content-Disposition: inline
In-Reply-To: <20161209093158.3161-3-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 10:31:56AM +0100, Jan Glauber wrote:
> Commit 1bb1ff3e7c74 ("i2c: octeon: Improve performance if interrupt is
> early") added a double-check around the wait_event_timeout() condition.
> The performance problem that this commit tried to work-around
> could not be reproduced. It also makes the wait condition more
> complicated then it should be. Therefore remove the double-check.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTcy8AAoJEBQN5MwUoCm2/dAQAIO4CplDJgFNF9AFcaUl62Dh
fAm/qdFpOv95EWdBhbmRioZu4lq8PetkBhe5H6NIlZy4/4VuKy/jvw74KqlPVYQv
hmK5mSaXfny8PNqMPTQ9wNDdB0NCDIYJw/Ib9+7iXVamwSarNIJ4vZARP3aR1NjF
wxOrsaQ1hSApn018EbfkqoDlIlsfeLCK8CwnV9/fG6BadAW17cJdcKbL9kvSg5E0
A1Ea5Qw7MR4bHux7CKRc+85evmMR7mLvGggD938tA8fQmpDQlPwQyMccjtaC0zKe
GlMn4KdBqFi/TtAgOMnPGY84jIoFiBBM2KC9Pxh/gqm8hSHbtxm2qA4lk8mx9v7s
WsD1Wh9QpSzznb/b2nitF9vlgUFsytio1uPFHlPp9PWX9gWm31rEUdTXhqnFMj5e
p15O64Neb7EELjd8S+r+oEKB2SITIz9uu4F3Jt8S57AMVjHZUVzNbEB6unGuPvWr
dsWtwV1O2usG5Rpz538NAyOpOHRJ0tNCceIhLKzetxMe4Tu35tOCan5EL6zb0G3b
FmrH6TnmJAI9zGqtAthB2oXERNua8FNEul2mdOWhijIojCxDderEqlcGd6aurr4j
TykT9C7T3Bl4fTt0npyhYJG0lzg9AWqSGJvzkx9FWXPDTWJLh4IRL3V5A42GyFoq
raBnVFDBYKrvpUlRW5Wi
=3fcZ
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
