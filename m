From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: aspeed: Add multi-master use case support
Date: Fri, 15 Feb 2019 09:52:39 +0100
Message-ID: <20190215085239.v5cjmcef2q62xiyl@ninjato>
References: <20190211185444.4965-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ybsnxjjqnbgxua7z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211185444.4965-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--ybsnxjjqnbgxua7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:54:44AM -0800, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
>=20
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks!


--ybsnxjjqnbgxua7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmfdcACgkQFA3kzBSg
KbYJEw//dnf7zJDVpII7ZpsgPtNZerCcz/+RipuuRefqyn6ol/03zMNMDsTsqWTZ
WB9tWi0dBE0uC50iOyLKS0M9I5b1xVqKasEl2Z/r8J9IvGuakbIfGfhiYJ9oJgdH
zJBxkc5W2Or1FJ9AUIxpKWeaUSeE6J2/wv5168RfjLQAb+Sr9jVCrCon1ZsTo/7B
9lBwoYMAXTonbf615WTcU+fnRHDyIbjboL0OB1W2Iv8ksmTPvETviuqfSk4PyiSJ
RLcQUWrw44sUu9sSUzQNZ97g6l20R/LnFtXdQYIDrXNTmP+tXlAfxqdt6ghVumwa
toW9MZX/JkYc0xrBIOQPpEL61yqLyoQdChhv9ahUAKUiKTIkz0Io9S5PobOMvIbd
sGyJ+abYVA9Qvg8CH+ZKQGZwm/SgIGfKtkIgbh+3Q6ATChB5dDfytJw4N2OoVu0T
5DgPrkmpIaVF9JTOnhvzQZYswpBZuDk11yC2Tea2s9Djp1fN3ettw+uYLbcnLmo1
GNLWOtLTkT0gr/krY8xy006jaMOa4tjlLLKlB9AzUNB4APidP2UDKE68wrxlo7SD
+5nQ+CZn9CJUBdXR5hQeDrzpoTdRBgNlUPUaB0TOK3Sbz962vu1I4019xG1ITLwf
OEUWzonl3lABGqbew7I3lyn5Py9nEcWVfW+6Ks74i5vvRBcIAOQ=
=dfmE
-----END PGP SIGNATURE-----

--ybsnxjjqnbgxua7z--
