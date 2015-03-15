From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: cadence: fixup wait_for_completion_timeout
 return handling
Date: Sun, 15 Mar 2015 10:23:39 +0100
Message-ID: <20150315092338.GD3393@katana>
References: <1423587310-18103-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423587310-18103-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2015 at 11:55:10AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. The
> return variable is renamed to make the timeout condition clearly readable
> and the type adjusted to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!


--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBU+aAAoJEBQN5MwUoCm2vNMQAK5pnFv0np0WyRAu37sNkujo
dwbc0Krf8+TPmwjZ7y7YVL69P2X/JhA568AzQ5l8QhsOFzV9nhfUqHV9lQAqBkr1
vgix7YozHhpbvWZXhrwhCTeEiF/oTRZjjtFhQy/0cueQzY9YHl6wyaIuDdXUfAUq
v295G7I1cPU4a17MCVffc+7OoNLHcgCYTN5XLrUObq3fZXR7ao573WGq64geU7tk
9h+UwK2woRq7jii5D7MhYxdoUDma8KE950Q11oyIGiBrXJ/TdvVDhd8uquq4X2ia
XGAJIcqIpIyag+jMFuOJrag4RiWFxHm+Z9RlW4AzaTdMN4EJxkrvNgSM37x3a8to
eOeuQaGcduZLbNy03y1YEi5K5EwH9NgZmGJzNcKljX7mSg1T/YoV6O+VgK7ik4kd
dEWAr/MJ9UTmYsNs0X37w8QnD1ZwSewVt6i+C+mBH7uYZTqv2Lbnf2C8+/oMWDvs
OGfvYtUqR+jh/Fgez6BD2OogibWSnkUEe8/pQTfo/fZYw0K9w75TpaZai8+yNdcu
2kpxzeReqA4ER9dHMaeoMW/negGeI8HOMAiUDmoErBTL1dQzrnaKgp2h+bHMtPdR
RdMurm78DeRCXbq4fUZVCh2uEXjAFN+vcCFCK5Me0+0DwHFyuOS310WIK8njiThZ
A9R7ExuVS1u9inwyATfu
=HZua
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
