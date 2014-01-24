From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-piix4: Add support for AMD ML and CZ SMBus
 changes
Date: Fri, 24 Jan 2014 17:47:53 +0100
Message-ID: <20140124164734.GA2629@katana>
References: <1390428346-2235-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390428346-2235-1-git-send-email-shane.huang-5C7GfCeVMHo@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carl Peng <carl.peng-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 02:05:46PM -0800, Shane Huang wrote:
> The locations of SMBus register base address and enablement bit are chang=
ed
> from AMD ML, which need this patch to be supported.
>=20
> Signed-off-by: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>

Applied to for-current, thanks! stable added.


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS4pk5AAoJEBQN5MwUoCm2lsYP/RQOMixHpxkUsgNBOw9jVodt
R+wAqzVjTtIi+0WhpjfBe8Sh8a2efwq8WTskM+p9wTp5M+XQ/uvCsE/TooFQ8fCq
iZRTCaRrxWW0d28jckDrLZyZyUaH2bJ8NSgG4xFwEtz9OVZgFfQyGdy/QjFAJ1a5
U0MZNorU4E+Mqg4Vm9uBIO6wM3lAWukBUzYyd8rC3FLKLS/USs0XIUU+eAqvKv+t
7iZySm6Fq91iz8EqBhDFVIcMxi+pb2GpWeL8Ski8UTgipfuvP9I4aeuyCw8OvuqV
vi4MH4ydNl1hZ58Udqi99UJdpJpaDgm6+XSg0oVH9MmUrUKGunsKDYd65vDZCjCL
DYN4NTh0mVX0In2KePnpsuh5LkFA5nmm4z6h21nlVYkgJPfSXwZ8BsN3rm3vfEef
CEslSHdmou7gPZxfp828rKC1/MoRswVzZWxt7Xhnk8Xq1c3MRUMAoPWhXC17kNpD
+85RixRnjRkYvTikcsFqD349wTWceZq6mCqUwUErP7AChm2JPQDxUYfFT7Lp4UWH
YrBqTYVF9krz9kr1YkhHUMQI9Oc8MbOgEPuqa+97I/AVlB05CX8VSfrwSQsv4UCu
d1Gz4U6iVfPyH/+9pLdICslpLMSM/EMNmvx2lkZ5kF0+kU5GiJy9ZR1sznAKUd+Y
EfDDpq1ntbQLRV49HdDz
=eNRn
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
