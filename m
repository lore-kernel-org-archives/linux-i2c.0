From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V3 5/5] I2C/ACPI: Clean up I2C ACPI code and Add
 CONFIG_I2C_ACPI config
Date: Fri, 27 Jun 2014 13:03:41 +0200
Message-ID: <20140627110341.GD2641@katana>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com>
 <1400590764-11108-6-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400590764-11108-6-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 08:59:24PM +0800, Lan Tianyu wrote:
> Clean up ACPI related code in the i2c core and add CONFIG_I2C_ACPI
> to enable I2C ACPI code.
>=20
> Current there is a race between removing I2C ACPI operation region
> and ACPI AML code accessing. So make i2c core built-in if CONFIG_I2C_ACPI
> is set.
>=20
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Applied to for-next, thanks!


--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrU+NAAoJEBQN5MwUoCm2UNwP/28XU5KPZ67kX5eUNATY6Ayg
FGIx9zyFQfApfoZL5qSN0sCqcNpcfwf+LlfIEsh51YuPx3LhKwDtgU5Kz/R1lbgH
pAgNCIjrZ/S0ezxp/h9Ggb8Vw/jlIt9bCiO7NCFouAabGwPXxCeF0ET+2ClBeM7x
oW6+/5ej8tzH/Zns8kqzYQ3HlSSq6wCu3fF2JsorIiFb68uv9qRh+a5F8aNrm4Yb
z261DUH2FMdD2R0YlTorspn2g4nQJut+0V4lxVl7wSFA6kS/7OPHslJCsnm+84mR
5arO6V4a5AG3llqN7nBWtRiWWkxAYMk7BP/ZzsePT/V4pS5jUjPDAs2nErBzbq/X
S3qjJ1maYWJues1qVaKAO6UulqPoZShgJ6RmENMPjQK5Qaa1Wl7JG/bLn8pdIwit
v91IzAOKUoQWuHjpfRuaDGESrJqKUAObM3BebKaekWyfXpMJhRSw3ztmL7UgCS++
IqEBCFctY4/wuYf5NxUt37EISgiYR9TukAZBaPz0ciYcE/I7/mMMc2u4Gf0UxEJj
+A2MQ+wxM2xLbZzqHjHAEGakCpOUsDVLhj2d1KYMlOVHvmxbmAAlwIw08kpjfRgl
nGyyzCNnO1rtNSHc4XoY0mo3aE5bWo5raB5h9qaL3gXwohZnLNmIPd9VxPrR1+2Z
t7xAjHWZbG5yUUD5Hh2e
=JWdF
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
