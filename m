From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
Date: Mon, 24 Sep 2018 23:45:23 +0200
Message-ID: <20180924214523.GA18592@kunai>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 13, 2018 at 08:30:10PM -0700, Guenter Roeck wrote:
> Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> properly") moved interrupt acknowledgment to the end of the interrupt
> handler. In part this was done because the AST2500 datasheet says:
>=20
>  I2CD10 Interrupt Status Register
>    bit 2 Receive Done Interrupt status
>          S/W needs to clear this status bit to allow next data receiving.
>=20
> Acknowledging Receive Done before receive data was handled resulted in
> receive errors on high speed I2C busses.
>=20
> However, interrupt acknowledgment was not only moved to the end of the
> interrupt handler for Receive Done Interrupt status, but for all interrupt
> status bits. This could result in race conditions if a second interrupt w=
as
> received during interrupt handling and not handled but still acknowledged
> at the end of the interrupt handler.
>=20
> Acknowledge only "Receive Done Interrupt status" late in the interrupt
> handler to solve the problem.
>=20
> Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq event=
s properly")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to for-next, thanks!


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlupWu8ACgkQFA3kzBSg
KbZRaRAApSJxYi1ZDY/OJdAFFgXK2twFN3Ct3WPrD9FOf86oHX3eyX+YAtiWN2G2
qAVNs6JNX3rVlUKiN5UJVxR7b9LxsXeB0djnPp0wrfoscHsVC7nNsf0/4jW8T6rD
56M/lNPk7f0oWFn3gB8rWnfxJ5LQ7j9bS/VPIGrEEhZNzpS/ewyCWuQXvZX5NGLv
suwyL431enqXKyVYZAwm+Wg6G8xlO2wzLTsPSttpWNDBxriyWSf/L9BkrbHQbezT
idtCXG7PR2JDerWDVvTHrUXqJdLowHBe18umR3kNUnHoe5T7/OCg/AIRtUgEn9C9
H9L40P3IQJVcSDfBOGixkt29RPuFdwHchaCapJkdanIwmE/+JdYZR0CekKBIJheO
jikCLMnH2ryaOH38PCjiEK6CIdZ886ZSA8rDXTWrEX3AfUbKI6CpwdPByqpbwwTY
kAI3z5ufTBI+PGwpGgrIs5AKGN/kkQtAUFsw5r0OcNM1E6CpO234dGizpgoYpDQi
lloJ8ZAC2qir3+uj3p6PlK7r5n8UQt4rA6vI1OsfFSHDKTQilOdCm4zoYY5RnSOO
A2VAkE3nmIiWJ/rBmGZsx4BWDlpsdWSklSzkyOKwA6hVBypP0fLiF2mPzPKOAioK
AUXMsCPXeA6/9ahVOcMNcFmsCYMZpKsp07mvAmyMRHNukrxqBD4=
=TQ2O
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
