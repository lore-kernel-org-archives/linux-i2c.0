From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: davinci: Avoid zero value of CLKH
Date: Mon, 23 Jul 2018 20:07:22 +0200
Message-ID: <20180723180722.7b46aw56oqxrwxwj@ninjato>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4829127684990420666=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============4829127684990420666==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="py2crmfqizrudnfi"
Content-Disposition: inline


--py2crmfqizrudnfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 05:20:17PM +0200, Alexander Sverdlin wrote:
> If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
> and stretch the clock in this case.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Applied to for-current, thanks!

I did not add stable because Alexander told me this is very likely not
to be observed on HW out there. But TI people are investigating more.
I suggest they resend this patch to stable if they see fit. D'accord
everyone?


--py2crmfqizrudnfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltWGVoACgkQFA3kzBSg
KbaShBAAmTPJfm8x4g3AynTRtS+ZrRiINQb7/mtqPQpixfehcSXQEK1olVFhF+4P
B/vXyjeHz7UzrZb/Og/nXUWmoCrldcs+9TZoxOU0LLgkWHtCOdaaupXRibACQ5rh
Nf/pATVqhUjGQsN5/SATW+MBjys6Y77KpBVzyI42jndKPSavcQRjC6j5OSBYDCuw
Pm9XD3y4tO9BTwZpM+hIGh6zejxjxpi4sUt0oun9a5TmvFNCtHXkXRuzFYUgI2Rw
WXEcTWCQNbJqjHffaIcpHVJk1McnhHkqN7t/HlaW7Vk68SSCxG1xaGyNZWXaUxto
xNnuFy3loVRcfvgmZLBmPSb2z1x59z8z/Fw6szzuoG8fAPSmbvXzebPU61pISQOU
EhUvsVj9enBODGsOO2UuKNta+toHPYWJB0cnbaIQ2Z2EkZ5FYVz9yid/pX743HLi
T7vqSfynLMIbdw7oGZmwQB1JtJ2dZBDueKm8AM2lB6MWTte0xNhsWzUiPQkLCKyy
qIWANdPN4YNLNXqkIRwNl+R7amt7TmwCs4I/ckMj3YbvbuHb3fNUYC5lZeqoR3Dg
6C/tYNANlEqfpmaiPY0UmV+LWNy+35CD2BEonNwkVDhChRkS6CW8aJqZQjLACJB1
cWHkQyovWQxFIEXVkymvB1i/M6imkK8/gwhMXZ84pSQO6Fv3BV4=
=avUa
-----END PGP SIGNATURE-----

--py2crmfqizrudnfi--


--===============4829127684990420666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4829127684990420666==--
