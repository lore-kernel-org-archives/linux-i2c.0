From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c-next v9 0/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
Date: Tue, 15 Jan 2019 23:47:13 +0100
Message-ID: <20190115224713.duoha332mjlrmwji@ninjato>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xwuf2wduqyb2yvvn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--xwuf2wduqyb2yvvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 02:09:11PM -0700, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so a
> case can be happened that this master tries to send data through
> the master_xfer function but slave data from peer master is still
> being processed by this driver. To prevent state corruption in the
> case, this patch adds checking code if any slave operation is
> ongoing and it waits up to the bus timeout duration before starting
> a master_xfer operation.
>=20
> To support this change, it introduces changes on i2c-core-base to
> make that able to read the bus timeout and master transfer retries
> count values from device tree properties.
>=20
> Please review this patch set.

Marking this as "Changes requested". I think if the mutex approach
works, these patches become obsolete then.


--xwuf2wduqyb2yvvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+YvEACgkQFA3kzBSg
Kbb02Q/9G2qC89KWcdgTbnn6LJRKpfD/+wioyzPtJdq3Vy0UHGJJZ0DvcZbLBkbt
Mc5ToZFckDRdznQCBm4vZG6r+9HqKRK58i+EJXzg/iomWYTWi+WScUb0uo5PNpy3
UX5ZxtOkw0JBpBPRtjxp3pH88/KGv/9ROOUbpToh1BzF2ZLWEjAf0BFK0snNbdEZ
A2BNFIntvm14mk5TskacVvbJS/61W8LDoZSU/PTTp3XpaQVq+GYvPw23Dw/h+L0U
xNCa2WEHly8p79Ol4cSzb5U7Y+SEVmaSSGx1y/mRkcxh4vEywzlxVOg01OueAv+S
ZrdtWSruFEaZ5MzJgA7zSpX4Ox6xzw5grLF7AxiJ3cNnBSQEithH5qm9+9PxvjeB
wrKrtz37ZqyeYeNOxT1gZIBXPvx/PTanD7X87quyks1rbIlsSimUEqllpgqZlJrP
5pxdzpuJcgdRnx+WPJme5V4M+uLvoi79kJMIYKaabCDC9HG1EiFHw2HQn9K32UUp
kj9myrPOF7rUfZZTGrUHyGBy9/EHnU9Wl3QaUSTN1Q0Moo+QE/0sqeK4MsAYnoBO
JxebYGo8XO++FtvFHI3BlhQ8/yVQ3HsxISMtiwr1TsJDY7LNKA+fKJCMIAyBI99T
jQ8aRWsMrbnFdYxXApxkmkVwHgCFRARZ0ushrdIT/RWr87yXiUI=
=krzm
-----END PGP SIGNATURE-----

--xwuf2wduqyb2yvvn--
