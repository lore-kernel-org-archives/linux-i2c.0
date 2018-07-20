From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Fix initial values of master and slave state
Date: Sat, 21 Jul 2018 00:25:37 +0200
Message-ID: <20180720222537.2ldpgsign52dutkn@ninjato>
References: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ohlvevurqh7blhp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--3ohlvevurqh7blhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:20:28PM -0700, Jae Hyun Yoo wrote:
> This patch changes the order of enum aspeed_i2c_master_state and
> enum aspeed_i2c_slave_state defines to make their initial value to
> ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
> In case of multi-master use, if a slave data comes ahead of the
> first master xfer, master_state starts from an invalid state so
> this change fixes the issue.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!


--3ohlvevurqh7blhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSYWEACgkQFA3kzBSg
KbZ8Jg//YKSUt2a/m5B26aWzCSeSgU5lO0k17TlCMkNO8xG2PUzjpfqxfWhxYGjj
opjcaYiF6WKHLAS1IhrhCVcuEV7H38as8NaXMr8/NtxvSOtbs88nYbKHx0wE3HC4
/h0KUHwnLGFoU2EShSSlOl57Q9q8icyCjWS9K8FLnqW0y4PatxFBYS5Zv9il3w0s
mdiEOVHVWvSoi5rDfgEgKk4Lo1iw1h1ziBS/9l49MDcnslzmjK2GSLHc7QnwtI/c
RaxRHb0u2yuIzxEMmzrKxQ8FlVA04oq1yndDg1cj9/pN0OBOLztO1eXlUOLDMBAb
FWsWv1adZl0++rnEV9gibDYeCdEI1yxRnXouen0Hlocpkw1fJHHDGSBeUv9DKiKS
yEmefiGeY07v9vyPNe0qoCW2ISFnot2jiPDbv71bkJUgUnCwmjKEynXN70W5vCy2
iKrI6+7HEX+igFvfLUPTTH/35DVkEs3DrqICY7I8Zox0mKaRjVlFwBSaGcWqTppS
Z5Ldfin1eqPP6vZ87dW4OAjFuHiAGkq7v/ODcvdNTz7w77H+KQCQ29rnGUozJns6
SWOy6pCmigweIezB9RhroMlzHsoS53uiIKWZxYG6iZS0NGYy7gIuYGcJjtAS9GpS
kra37ncjFWUVN3TvwSy+lyHLiTmtvsNd2cdQqs4Uxo9W2CumBPc=
=3A4E
-----END PGP SIGNATURE-----

--3ohlvevurqh7blhp--
