From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
Date: Sat, 21 Jul 2018 00:29:21 +0200
Message-ID: <20180720222921.hvpk2zgr4rxnwoom@ninjato>
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rrduizyznuwusmgo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--rrduizyznuwusmgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:11PM -0700, Jae Hyun Yoo wrote:
> This patch adjusts spinlock scope to make it wrap the whole irq
> handler using a single lock/unlock which covers both master and
> slave handlers.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!

Not related to these patches, but there is an issue found with sparse:

drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignme=
nt (different modifiers)
drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk=
_reg_val )( ... )
drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data

Maybe someone wants to have a go at this...


--rrduizyznuwusmgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSYkEACgkQFA3kzBSg
Kbbo0w/8DKIYGiUZQuTX/Rp4PDOfP3xI7TfsaVo9kycwuHP3t60ECafEHibnQVug
MRRDpZJXItcVI3zbq7UjCi+5HDpSggbWIU4czwgMTD59uGjnqUUJn2fjsaJGWZOi
jr9LVNMEnH8sTbrnVb1PbUxey3gzZHIRx1006yjye0btyJ3Av16PjpZNXa+xn+Hd
627gw5YFtiawPziF+fBrJtOfsxfX3Z7NKkbS9iKLiOrH0WEoatsXuQiwjOUbZMn8
P9YgFLFcM653e5Lv0pbQ4h6jo+e50Q7HYykd1QCYScG1eaCNA7Ruj2T5t+gEHKxn
7I95atjWHQ/njair88vgOgNmEG097AbZzAcnQ3SlSGh/4JAgj/Y4ZDRqYdGfyaT3
2eSR05Tbp3h6ZLPxDITQNCAL7kimee6OLYodHRW7TL98coYuXCkC/YQHcxxwtXMw
+sSEgpRsJMUsZTkyqRe/LOOdaS+R38nuzvhb6ULVby2Ayx//4MJZ4MNCgrnApCs0
rbVBteTBLJDDTBGu0wngFyJHPt08hMKDMS5BVE4RhQKngbUARfSN2/h7Bu5ObZss
DP34X3RcUeDNPh4SIW951ZU57MPRHagusKY+bWfcHhCYsMj/PLpv4MTBojx9WTPD
u5zbWHCRBAkUTg09pVL4A7RxCmk8yaiQwUqBjs+weideQplVVq4=
=mzTp
-----END PGP SIGNATURE-----

--rrduizyznuwusmgo--
