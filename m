From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: don't infer timings described by ACPI
 from clock rate
Date: Fri, 19 May 2017 14:38:01 +0200
Message-ID: <20170519123801.l25pvu5n2bjfwzt6@ninjato>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xonrbbdlb2zdx3mp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46510 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbdESMiC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 May 2017 08:38:02 -0400
Content-Disposition: inline
In-Reply-To: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org


--xonrbbdlb2zdx3mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 09:56:40AM +0100, Ard Biesheuvel wrote:
> Commit bd698d24b1b57 ("i2c: designware: Get selected speed mode
> sda-hold-time via ACPI") updated the logic that reads the timing
> parameters for various I2C bus rates from the DSDT, to only read
> the timing parameters for the currently selected mode.
>=20
> This causes a WARN_ON() splat on platforms that legally omit the clock
> frequency from the ACPI description, because in the new situation, the
> core I2C designware driver still accesses the fields in the driver
> struct that we no longer populate, and proceeds to calculate them from
> the clock frequency. Since the clock frequency is unspecified, the
> driver complains loudly using a WARN_ON().
>=20
> So revert back to the old situation, where the struct fields for all
> timings are populated, but retain the new logic which chooses the SDA
> hold time from the timing mode that is currently in use.
>=20
> Fixes: bd698d24b1b57 ("i2c: designware: Get selected speed mode ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied to for-current, thanks!


--xonrbbdlb2zdx3mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlke5yQACgkQFA3kzBSg
KbY7+RAAsypT6MNoD2wGjGnf4rqKZGSm7tkuzv+hFlgQm/yaSBmOmp1OSuCRTkM2
eUJA1MulZoDMM76DrehiRPoCVPq5OCmLFdxunFNnG6BVmUH4hu0H4eWrt+dpYcP/
aIKQ5b4TCVVha3MsueTJxboQYJckPScfNdFcpSNS7f99RJHpGv+DFW0rb1DqKcYG
77gaPjXucJ7XXN0KkRWIJcyFWzp/YXJwWWQwsj+d5avD8lApEo7T0epXRu1gDxJd
yGNnmOuRkoBF0uS2LA6pkVJi9OhKYTQB8yFxHb3YZK1vIZuZxn5FODOsj967knGx
pd557/KDN3ssMcQN8GQVLDOrxptJekkjJWC13tbNUFpSl6MDTL+7LATsqLEYUdDJ
FgWKlU/mIee0PBhZEOLBwSkOKwaUWDtKWg+kz0xETrLHMl7nPBFwvNHLGekbtVAS
rhdqyjnngaUENH92FnczIL+QfEOdmvEZz9uOm03HDUV+Htx3jZALF7LUT5SfpDSf
9tONfb0F8LJW7YiBQNBuRAZ7W4DOg0PJWNYYdM171qXE0i9vIhx1U0GW8jT008dT
zDUy5qS0niiBRsXddmv+Kxum9GAXor07GrXQwqQRY2E/PRZaOWuxyTwC0ZwC98d4
9TdOID5aZoMZFdnvHYUnDQIi5GVH97jOGy2eVCdyzYlq9zO17gc=
=YEfa
-----END PGP SIGNATURE-----

--xonrbbdlb2zdx3mp--
