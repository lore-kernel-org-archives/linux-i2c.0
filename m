From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: designware: Make HW init functions static
Date: Tue, 4 Jul 2017 16:13:56 +0200
Message-ID: <20170704141356.vjyqprhvhsmsiqxh@ninjato>
References: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
 <20170628142329.14818-2-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eva74f3sbxn4lerj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49232 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbdGDON6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 10:13:58 -0400
Content-Disposition: inline
In-Reply-To: <20170628142329.14818-2-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Luis Oliveira <lolivei@synopsys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--eva74f3sbxn4lerj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 05:23:28PM +0300, Jarkko Nikula wrote:
> Recent i2c-designware slave support patches use master or slave HW init
> functions through the function pointer so we can declare them static.
>=20
> While at it, rename i2c_dw_init() as i2c_dw_init_master().
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.h   | 2 --

Applied to for-next (for this merge window), so we have slave support
immediately as proper as possible, thanks!


--eva74f3sbxn4lerj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllboqQACgkQFA3kzBSg
KbbldA/+NFY6iE1npLg82bErnApLOP9RkPHpws0zN3eEiQ3mFpVNF679SIcNJpms
xqAT5ErK2wkXB18+JP7Aj7QoEO7LTS8xADRnclWqcg/zhi148b0Vmlw/flGXOEwx
BLXh5OUSsDnHQXFIIQV10DDQs8qtRMXpegD6cXCRuzQaFyPXUQqkzKRM8rnP1hHw
gZScemV4unJhio7k43sfFFjJh6cakLQwA7gdue+wm7fgOQB2IwS94PPKDX1pGvM5
EOSEufQGBiehQUhjaiaFi2wdiQSZersdwwVETIaPl+EAGQofPKtuP8KfaVUfJMLz
MzsgAclXm2eMcDWAXnyyf1iNNZPApoSIrroKDZ4TaAprxvc4tkGg+dUfE28mFVSr
pvRMxB2kgu87FhH2UJdXmOSC7oJvtBGGz31dmUX6sSh/y9ga8SPNSHqJQlJmZovL
s3HJ097HOk9uMM6mQs8PUUAmSBTIInhR9932Jd/3r5hiDuxWCpzpsgLL/drR7Hos
lJUlQCyThT2W52tZD6SEhNpZ/98/MYIlZnvU/jWptcliN+dFabpSDt6by1DGLM00
CwxFmqWsUSqRTH1vY8nVnQIs1T+xq/egTjEzce3HeCPGLw3G7rBnk7TwfpR6xgLq
pZIt9gEzGZbZQS9A2upsmTG5Jz3PAV3SRGjYQUjtN75lf8bIyIc=
=yBpx
-----END PGP SIGNATURE-----

--eva74f3sbxn4lerj--
