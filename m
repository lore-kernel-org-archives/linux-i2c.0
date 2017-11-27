From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core-smbus: prevent stack corruption on read
 I2C_BLOCK_DATA
Date: Mon, 27 Nov 2017 19:38:47 +0100
Message-ID: <20171127183847.ddatx2r5dnmrs3rl@ninjato>
References: <871skzpbby.fsf@jcompost-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tncblr4fa7y446we"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48002 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbdK0Sis (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 13:38:48 -0500
Content-Disposition: inline
In-Reply-To: <871skzpbby.fsf@jcompost-mobl.amr.corp.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc: linux-i2c@vger.kernel.org


--tncblr4fa7y446we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 12:54:09PM -0700, Compostella, Jeremy wrote:
> On a I2C_SMBUS_I2C_BLOCK_DATA read request, if data->block[0] is
> greater than I2C_SMBUS_BLOCK_MAX + 1, the underlying I2C driver writes
> data out of the msgbuf1 boundary.
>=20
> It is possible from a user application to run into that issue by call
> the I2C_SMBUS ioctl with data.block[0] greater than
> I2C_SMBUS_BLOCK_MAX + 1.

=46rom Documentation/i2c/dev-interface:

ioctl(file, I2C_SMBUS, struct i2c_smbus_ioctl_data *args)
  Not meant to be called  directly; instead, use the access functions
  below.

Maybe we should add this info to the include file as well?

But I guess we still shouldn't OOPS on this misuse...

Will think about it...

Regards,

   Wolfram


--tncblr4fa7y446we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocW7cACgkQFA3kzBSg
KbYAVRAAgVhH96arsy8pnwFzOaQhAy281cEvjLmyB3/ciiVh2JcuTo/vUuxew90m
04sCNE7JxWN1pWIscgKKD05TDvdFZCa8JlgbUNWa4atWsbsuLtpW0raLHEDizlLJ
S1a8JE+/hAXu90SaLQom60O3Au7X24jTJCl8l9d53oTO16VYgDOR7M4P96dXIrrq
/68zjo4JA8wmSAa/itUKpttfGCoYtJ7SIFtlkwEykoDmZm+KGr5KnSy6hZmqufs7
GDszmvCMWj+K8gr97AekKYyT1TkcKr4wWYImaIKREnt8lF5JzKEYzqFhHS1msy3H
goX8jwX4r7eNmtGQWsOZfIogBGi45Ka6kg/OaCE5tjEuDb4R2qh2GYHjLVhZQ+dF
xfj3/SWEzbwIBH8o1ggA88ieU2ftvcZwSs4RfN0mQQabKeuqYeVp6JbJlO9iQ/1n
faL08Le7DSaAW2qG+l1dbu9Qzwfm9PFd4+PBQVkLWHCvZ2omAcr+TjAxZdZ3A+AJ
pVm9rx5Qa1ZRxZ2q/1OHaewFYSBWxKDv8tdMFOaWfoJmSOPrEtjS2lkO8sDRW+XD
AAbcHeKSoS33uMZi2YmB4oPYz/GwYK1YOvhLjMf0sgC6icu3AyZRkEilMR+X+AUY
grQGfK6tSYOAgpq+NnbmLwqHFi8KQyR/HIF7z3iL+cVbZjMlW3w=
=9gHs
-----END PGP SIGNATURE-----

--tncblr4fa7y446we--
