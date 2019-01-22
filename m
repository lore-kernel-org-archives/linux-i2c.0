From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Remove hard-coded bus timeout value setting
Date: Wed, 23 Jan 2019 00:18:54 +0100
Message-ID: <20190122231854.g75ijhg6halhzdvh@ninjato>
References: <20190116193943.6004-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n33otukcn44nvdcc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116193943.6004-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--n33otukcn44nvdcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 11:39:43AM -0800, Jae Hyun Yoo wrote:
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks!


--n33otukcn44nvdcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHpN0ACgkQFA3kzBSg
KbY1fw/9H06zwh4pL8+szV13WMpPIU1rXCyiRitiy1m4Q6GgfHgyNUyjAAeuNmO/
TcwZNmGx4yGlonk7LmL1xg98w7mjcbAwwu4B5ihlPN28MJGGT+WIdpHibjzB8Dvz
Qwqh23tWxaU0KtMRwZppKKbKv5T8jux6qarxfxVFDY5eEd8qSWiqRCzN/5i9pE3Y
gVpxKi5cQwSANEveQ9rjLU+tqq+VNo48PlcybHMaVImGL8V9lDVOKwosoQnISJ71
Wnx+FfX0f/Mlu00gIcB/LrPnz4JbWRLvvyTr8RRtjJXHEmaicIncj6vmGvLp8m3l
NsUAalTrwdDJq9EzzTRYNhlDlkUEonESnIlaQmjgSGKLYJ3u8sO1vL6P7SNfYRbu
dP7O/e0eZFlovb+6XnF21arafl/J8bN4Qv0MLgm3/kUWxcmw6MpDBoiQ58eLn0et
hFG4AJCWNszEA1btFdt+kR2VSl65+6rHydDqJIP7aDwnoXVYqIJjYjs79tHbs+jS
jIKvcIpXvzMpPwQ4W7pO9QwqCfDDadnKuOoFpe2L59a+OYT6orTNqfl3kSRey7sv
9WfLkus8l7nZovpkeXW9vwkEUvdC3xQX5f6eIiKiB4is7uArt5cZmH7BHQOiypX0
jh0pSX9f6dI9eDCMq/VGzOysDHitI6K+E/0tiv6wFAycN/IVIfg=
=nQmG
-----END PGP SIGNATURE-----

--n33otukcn44nvdcc--
