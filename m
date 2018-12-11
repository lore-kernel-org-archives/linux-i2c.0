From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v13] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Tue, 11 Dec 2018 22:01:59 +0100
Message-ID: <20181211210159.to6okhbaqpymoax5@ninjato>
References: <20181209155602.GA8414@syn-yoga530>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wghqmh4wfsvnb5a7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209155602.GA8414@syn-yoga530>
Sender: linux-kernel-owner@vger.kernel.org
To: Elie Morisse <syniurge@gmail.com>
Cc: linux-i2c@vger.kernel.org, helgaas@kernel.org, Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--wghqmh4wfsvnb5a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 12:56:02PM -0300, Elie Morisse wrote:
> MP2 controllers have two separate busses, so may accommodate up to two I2C
> adapters. Those adapters are listed in the ACPI namespace with the
> "AMDI0011" HID, and probed by a platform driver.
>=20
> Communication with the MP2 takes place through iomapped registers, or
> through DMA for more than 32 bytes transfers.
>=20
> This is major rework of the patch submitted by Nehal-bakulchandra Shah fr=
om
> AMD (https://patchwork.kernel.org/patch/10597369/).
>=20
> Most of the event handling of v3 was rewritten to make it work with more
> than one bus (e.g on Ryzen-based Lenovo Yoga 530), and this version
> contains many other improvements.
>=20
> Signed-off-by: Elie Morisse <syniurge@gmail.com>

Nehal Shah, are you happy with this driver from your side?


--wghqmh4wfsvnb5a7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQJcYACgkQFA3kzBSg
KbaJ+Q//ScA4q0wj/5RXmv1TpYikIecDUlVYiO2UEQfaWzmj7ktGBFbf7Fn/1NLd
gm1AizqoVxmG0fJwnUYE7fbFi0FKz8vAUl4R0tXk5rRsMD5S+nOIljAEx6M/TUT2
TzjAKOTvCidmlWlmM1864CN8ZgBzC2zm111xTfGpwcsSAKKZXnV5S/CHP8fhfeZe
zAtnopg/sy/QhSnhgLz8cqynO0rC47Py/+W/82g08BkTDr13DodJsQ2St34Y8teQ
g/Otphjo7OG8yqG8INZJCVQvB8U6Pa0AGoPyhMddUqMUdbKjuDRiJqkzi8IxwpMV
AnFQNcwWVUD9ppW9cX8vBOn8e5SaMrXyKHsRFkYWHYppPpenm3CCkpPqq/DqsJiZ
s35YgTnTZMqGyQMcWFGUVRE6nC1FUzTYBs8aFlm5Ku+FY9SKUUUanp/aJvTOH14T
jDs5UEt5n+wDNLTv/CYsWq1nXNU66ys88POCRKCy4xqCijpp9amvRKA4Nb5EdQji
TI6EUcZQWozqzdC19+B2n+59w1jyr0HVjq1J9X0ivitGmHrogKcVIgRQaUlY6fp3
s6RbLwmrZRS1n0xAn9B21OMwcVVZffNWQsmjfEHlPmNS018ClH5TnBVI8j9O9lFM
e0AnqpoO9VhtMW79UfhoswltAdHnSRL/UP1ENWa1zIvMMvAz8ik=
=6Pk7
-----END PGP SIGNATURE-----

--wghqmh4wfsvnb5a7--
