From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 21/28] drivers: Introduce
 bus_find_device_by_acpi_dev() helper
Date: Fri, 14 Jun 2019 19:08:26 +0100
Message-ID: <20190614180826.GH5316@sirena.org.uk>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-22-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r21wuLfwIlf/vvzy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560534863-15115-22-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--r21wuLfwIlf/vvzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2019 at 06:54:16PM +0100, Suzuki K Poulose wrote:
> Add a wrapper to bus_find_device() to search for a device
> by the ACPI COMPANION device, reusing the generic match function.
> Also convert the existing users to make use of the new helper.

Acked-by: Mark Brown <broonie@kernel.org>

This might have merge issues, I just applied some changes to the ACPI
parsing code the other day.

--r21wuLfwIlf/vvzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0D4pkACgkQJNaLcl1U
h9AmVQf/WWt5yCgqJS2hZ0wFS5SWw5i/JVNB1OTySWW4UwV8kzMIO9QKAQcU7Bjt
DSD24i2mUo/SaKBH+15eddgJLLJp4TNDVS8nKqhT+otXOn2usObZBjsVRtWwflu0
fqz3PoaUimH0t+spe5Zc6PeDh5vQZSnqlodIq4Z0enShaVZorKbLNWodISJFEGV3
F8AuiHutx8XotM8N3d5082oq84OJrKco7j0OMGNwZK0iP3oCWjjSZLPY9nAVhHVr
2Jb+oYxGskwzQGJTb1522E0Y8H8ZYjqYrpOXW0Sg+tbSP9gxoxOoJFnOzMQUlcAI
3khjbxrC4r6AoHawwMjUOc5V/BunEQ==
=t8zE
-----END PGP SIGNATURE-----

--r21wuLfwIlf/vvzy--
