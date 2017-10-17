From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] i2c: xlp9xx: Get clock frequency with clk API
Date: Tue, 17 Oct 2017 23:54:49 +0200
Message-ID: <20171017215449.atl5n5nnsponhka4@ninjato>
References: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
 <1507616876-17189-3-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cqp3ung5gy4f5epd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507616876-17189-3-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kamlakant Patel <kamlakant.patel@cavium.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Jayachandran C <jnair@caviumnetworks.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-i2c@vger.kernel.org


--cqp3ung5gy4f5epd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 11:57:55AM +0530, Kamlakant Patel wrote:
> From: Jayachandran C <jnair@caviumnetworks.com>
>=20
> Get the input clock frequency to the controller from the linux clk
> API, if it is available. This allows us to pass in the block input
> frequency either from ACPI (using APD) or from device tree.
>=20
> The old hardcoded frequency is used as default for backwards compatibilit=
y.
>=20
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-next, thanks!


--cqp3ung5gy4f5epd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmfCgACgkQFA3kzBSg
KbbjtRAAitBQJBOFx9ic0ALof9lo9y6eu8F3ZrBkOAfrmM/0fk0/VU0zlt2X9iII
i6G1qj6V6hab2V2msubaMkX9//hNb7e6OHoVsA8dhLiriMxEEifVYq6mILu8Tl3R
Vn5SgKUXy2rORD7/AEkNe+3D7ubRoyIfVPlWIWPAtsS2l6K+iMONaGXBd1YhKOGS
rOEjsg6bzBuHc1XT7MPoq/Pgq+YCF7tLmQvvVzpivijrVAQ5chR/QwHcAOawTEjw
VjXkhmdfcn6nKdnAyQqwQ80AR+wNjJJCIVuepgkcIg5Sqro4lTpu+Z9wWZghAhBT
UhiSwAw0ejl9O53K+sgEwZ5fuxe3IksaqNUTnJ5C2Gg88ms6W3ly/8Sx+5qsukIn
648jW5X2mvhMUu6o0iHBKkfMOj8ENqUdSDj3C5BbeXXyKM+4S9tn7BZP43IKFKty
cqKt9BWzWWNIxKEaVnAT/vSLcyZ3umiSUSqx3mvVKmpWorfBYhEowwdllOlAyuvL
8VcogQoi4iVWhwmdTlNnX+OeBfZRgGMY/bjQ5+o469UNzEQOD6s0XdTj22a//two
ARtDQxSV+9S1FLuKJFg5sbHbTJJQILX+PWIH+gyW5Pa3QjPi5+4emlzP7r9qhWx2
xXmmGqB499CgFDT8aQdqyG/KdGoubwAn6i96EclPCXvxIY/5ng0=
=imq6
-----END PGP SIGNATURE-----

--cqp3ung5gy4f5epd--
