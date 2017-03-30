From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c-mux for 4.11
Date: Thu, 30 Mar 2017 16:56:01 +0200
Message-ID: <20170330145600.atxqqsnudsfmnrtl@ninjato>
References: <8b90ffb8-e404-2bbf-ba42-5cd244ca3797@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7yrsnwngngd6n2k"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39241 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933320AbdC3O4E (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 30 Mar 2017 10:56:04 -0400
Content-Disposition: inline
In-Reply-To: <8b90ffb8-e404-2bbf-ba42-5cd244ca3797@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--c7yrsnwngngd6n2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 12:31:13PM +0100, Peter Rosin wrote:
> Hi Wolfram,
>=20
> Here are some changes for the pca954x driver. It's a revert of the
> un-endorsed ACPI support and a fixup in the handling of PCA9546.
>=20
> Please pull.

Pulled, thanks. Sorry for the delay, I was a little ill and away from
computers.


--c7yrsnwngngd6n2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljdHHwACgkQFA3kzBSg
KbYR/Q/9F/JI8NnlaqDJ54JrL5C2kpB8GtZaaKg1nrDLUIddFNFNVjqtTJOPGq3s
nMcbHPDwNwDvgkL4uK9zlROoHazG71O0CNF9MSUbGLop2D72R39ztKewOAxbdgHf
LyYrwRvbbVSUYQsFRchqgLVyMDqpCgZSJRlpSSmsAnFv+Bu8TYt7d3DTwT+UZ+HV
TLJFeXvSjb55BjAPrW0N/U8WwNLbU+OJ9rLXu2Nz7fgkWjwYsOgQyTfXni14Bs1Q
QPZ6l8Nj5xuLUl/rpap+u0LcDNqpbZ852s8kPyzLjnY/elo6q+7L6zckU2zw6P3F
PoCFFbPA+1gznhJ47Xvq0HvBgkCAAQtN33broMiphEScHSOLS6p1Z5fHIkD0MKOf
m2gZOxp8ROC/OrBhi/XdDCBoQRvEkQuNDxintxzhLCue6RHKoKzQG3WonkQZxjC1
eVS3i/LgjbuiEvgtLPQinlkSOkBDARAUBROX/Y0g9dlsVEkjXvwhm8TBx6a1BwLK
+ofv4+BseMZRfGbP9xAqPXXIGt3BPNxlouhyQv8e/+ZCIA2OYOyJfEhV+Sb/u8Au
/uZHN3lKGq+55HP2zFc3W8Ly5OXNLQh7i3FOKJRntO7MBOp9rk9XiLYuDuhJ3SVF
Od3h78jm0qw4qNTW3MohtWNZ8mgtbU/R53v5omD3rpoLPnzl3Hc=
=h1Qj
-----END PGP SIGNATURE-----

--c7yrsnwngngd6n2k--
