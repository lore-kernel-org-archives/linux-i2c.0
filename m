From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 06:56:16 +0100
Message-ID: <20180124055615.c3qwhwnj7spmcr3w@ninjato>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2opvnl37a7x4r4a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: eric.auger.pro@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, okaya@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--v2opvnl37a7x4r4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 03:02:31PM +0100, Eric Auger wrote:
> If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
> and any ACPI opregion calls targeting I2C fail with no opregion found.
>=20
> This patch allows ACPI_I2C_OPREGION to be enabled both if I2C is
> built into the kernel or built as a module.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

I recall that we had some discussion until ending up with the current
solution. And I finally found it again:

http://www.serverphorums.com/read.php?12,1001402

In any case, I surely want Mika's ack on any change to ACPI related
Kconfig symbols. Adding him to CC...


--v2opvnl37a7x4r4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpoH/sACgkQFA3kzBSg
Kbb40A/8CjGm3f7gJbML/1Y8Z7PXWHkmMpeYwattFZIk8mMhj8LCSnn1X/R7sfDk
9wxnk6zkaCijAIhFUp+a5zy9EIUjqy6zsmdWTjMyFLlSYKDXXYDr31wcKTw7hOfn
nH8HEHiIrF9L/rtm1juB84aozYItW/+FnjwLBp7HbXM+QzLHSaWhIgbIoEIDdS4p
vlUZee71+ciLjBCiw4p6WezqWZPiNqJNulx1OsnDrqMeSzEPBZAvj+4vHE4P0xKS
uOLHxjtzXSPcoWEZQP1pruwH6JOy87FffPGuRnifd3nZz2B8FkPatEFfX+7XBh7e
zP1TMFJ7dnJmVw6t4LCFj/ppf4IdZQINFJPhN1jFmjg5QDJ85kjbsTZk4NyBHh1U
JUWGeBKIc+ArUU2B60JigzhcwBUYNm53VLJBnM4NiY9epJpV2J7aLRJe9XQuvWDt
OEbEy8o7G23gERo2U68Lwf/LE5xsTQoJ4PF7H/GlHTQG/clP6OVrlfSlcU7K+AG5
yFM/7opK4EIs5WEnY8nvT/4LaC9BPaxz9enxpzOmY+1sFrdnF+N0n7NEX6mKPjHG
CshKSi/DrZWzEnjLploHVJ3T5uiA5KMxIZqCvy4xE3u9NA6lBMYbEhFbBkVU29jJ
Y3sLq13e2KSenwXoUWnkcQ0oPsRZzD5e/bpoTMrwbdukj6huFN8=
=Dbns
-----END PGP SIGNATURE-----

--v2opvnl37a7x4r4a--
