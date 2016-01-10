From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Sun, 10 Jan 2016 09:38:12 +0100
Message-ID: <20160110083812.GE1526@katana>
References: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59671 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbcAJIiT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 10 Jan 2016 03:38:19 -0500
Content-Disposition: inline
In-Reply-To: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 09:17:35AM -0600, Suravee Suthikulpanit wrote:
> The current driver uses input clock source frequency to calculate
> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do n=
ot
> currently have a good way to provide the frequency information.
> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
> to directly provide these values. So, the clock information should
> no longer be required during probing.
>=20
> However, since clk can be invalid, additional checks must be done where
> we are making use of it.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Loc Ho <lho@apm.com>=20

Applied to for-next, thanks! Also thanks to all reviewers and testers.


--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkhh0AAoJEBQN5MwUoCm2jVgP/02CO8hkoOF5ilqqOjAvhfPv
gajMw2xJlRrYSNcInLlKAZVo9Hdj0tzRlCugg7i7ix29+fvbicdE562AWszmF5e3
bDfUgKWwXeEFO8hExgMAdGGgZUsJ8eBeFhqVk77bjKo+HmPUQ9z7P1am+tQqRYKm
4doKuaBGMgdvt1ONV6i4zmbapxKkC+yZYPnhutwaEj0ogQML9FvsMwZukwpbiZjo
+EQ8uzPFciwySFndN9yaaVydXDrEgMNkYxPwGLTBThC0hDyRmeiAVdvQ77rGQQQ2
tcmL/GYuOuAqGath/W/oThx5GKjEckPQusCptsYEC8ez4t0r4/gW/tpO6b969FoM
mPuBiBR3fmqTHYL/avfP6cSqr4pxiQ6mJ8HqIWCzR940NXXrZNIL2QO+rA08twNM
27dYrb4y+CzJKeqMniZqUiuGmV8RAb2hA/+bLcS5b8/FgIU25ADI6igjiIVN+HPY
R/j7hi0cvksuZ+AMLYD7Wg1FU+lN06ssae8JVyFZc0LCKh/qEpWDcrU3ENLBp04A
d04VfaQ5xx69jiaTvUfGEwh/UEoQVf+X5yCAtqybTddPDb3kgXoD2fudZGHEvT2O
f1KWQAZFU1DJs3/y+U8677dGWXOt5aakB0XriSxWS5icKqLflg71v4QWWJRjcrU5
2e6PLtoKMgScA+nzdMLg
=zUi0
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
