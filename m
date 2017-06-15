From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] i2c: document DMA handling and add helpers for it
Date: Thu, 15 Jun 2017 20:42:06 +0200
Message-ID: <20170615184206.vwa3eg4upat6ioae@ninjato>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jmka4wf3er3zxwew"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--jmka4wf3er3zxwew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 08:30:35PM +0200, Wolfram Sang wrote:
> So, after revisiting old mail threads and taking part in a similar discus=
sion
> on the USB list, here is what I cooked up to document and ease DMA handli=
ng for
> I2C within Linux. Please have a look at the documentation introduced in p=
atch 2
> for further details.
>=20
> The branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic=
/i2c-core-dma
>=20
> And big kudos to Renesas Electronics for funding this work, thank you ver=
y much!

I forgot to write that those patches have been tested with a Renesas Salvat=
or-X
board (r8a7796/M3-W) and a Renesas Lager board (r8a7790/H2). A more
detailed test description can be found here:

http://elinux.org/Tests:I2C-core-DMA

And sorry for the doubled Signed-offs below the patches. My mistake
here, there should be only the ones from sang-engineering.com.


--jmka4wf3er3zxwew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllC1PoACgkQFA3kzBSg
KbaPERAAnPNmu0Av+h1EGeZVDT6xo+r1+6Wn1H66fA1faAGcwu5BYt2SmyVCaOV7
oG6fGswl/AjhPeVDbTLYpDGrGlOPrrUS6JYGbMT0osVJ/aPxL8S4i//ZBbD4/Zr1
wL0eYYdOY4Yg31QMA5gAeClPEQjNy5QKnZL35/wWTc54VoJbqmTTeCuxhseBarOi
PErhM32f7lm3iQgDb/6ngF+/SS6q627qWfGFH/wtitUV9NC6s6xkGqh9U5wsHE0Q
EIY2/zHPZilXbnKAY3F8obIrzzwxbYhyuF+/PM+8WLJB+L//dn95jMlRco/VTx1K
siAtBfJgenUQl4qO1EpC6jTFVEQtZGOTQ/AdtU/8b7GrjcSelPzQLiXJClylsRxK
IiXgoq0noOcSiVgtZDkMviPAjAOmtn0yEcYnbd5tzUuHuBseAWaHdVIM0tyuwGmn
G8u1Tx1bdPUyfqeCYP9Ge+0nxJDbtyTE2ERogXnMt3CP+bec35b3Nj38d/BGQ9oJ
7YgWljB8InxDKcVxKgte4wfHBv0DeVmpFSz/9SsJzCtBQU6vDy45hO5ZLn+jc3lL
YZHVYxZaxT1OfAn1DHkyOrsR9vlHd/OQMbOS+Mzh2C91UsD5RoNE5z6hQpi5n5kp
ojCqCk2pDGOWWZV+VFM9vx77FhUl5fDQf9RXFUkTb1V6O2nJ3rQ=
=Z/1G
-----END PGP SIGNATURE-----

--jmka4wf3er3zxwew--
