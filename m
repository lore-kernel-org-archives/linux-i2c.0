From: Mark Brown <broonie@kernel.org>
Subject: Re: question about concurrent regmap i2c usage
Date: Tue, 4 Apr 2017 13:26:54 +0100
Message-ID: <20170404122654.dfhtvpcnngl3gfco@sirena.org.uk>
References: <76471664-425b-c386-3ad8-efeabc2eaf7e@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nfmggrusljzsl5r2"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76471664-425b-c386-3ad8-efeabc2eaf7e@analog.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linus.walleij@linaro.org, wsa@the-dreams.de, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--nfmggrusljzsl5r2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2017 at 10:28:23AM +0200, Michael Hennerich wrote:

> A question came up, regarding whether it's recommended to mix regmap_i2c and
> plain i2c_smbus or direct adapter transfers.

> In this specific case for the i2c MUX portion we need to avoid double locks,
> and therefore use un-locked direct adapter transfers.

> The same time we also implement a small gpiochip, where we would like to use
> regmap to avoid some boilerplate code for the register cache.

That should work fine providing nothing tries to change cached registers
underneath the regmap.  regmap won't be able to tell anything's changed
otherwise.

--nfmggrusljzsl5r2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljjkQ4ACgkQJNaLcl1U
h9Blagf+N43SaUCaqbPTaw/fA2XY6eSW6ixMWrS1ExqyuN3VDnfoqh+hhuGi9yUL
L9/OHHcrODX8+byi4WsMGeCt/7zkLx3eo4S9SpEYoe8zheHOvl8Y1SeqfizBgYBR
woS+lUqT/ae6yIg95/0zhYfK6PkEaQyU2vU8tx7/ahfyy3GfHTvKSeljcf0H1Zbu
VhbA0KpSZjFjlDe0fVSzKi4i5UQO2DTC/XEyWtYB6/FAWY56kpWuQdSyf5MTLfFR
WT8VC07ntp73rQ1zcGYjc22raYvjrTDff6vjn4b6ma3dZienkgJ6WIEYP6F10CPV
dT86b5fYadl8bdd6Fewc6/5/Fuegag==
=mLk+
-----END PGP SIGNATURE-----

--nfmggrusljzsl5r2--
