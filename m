From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Fix SMBus port selection for AMD Family 17h
 chips
Date: Fri, 13 Oct 2017 21:01:00 +0200
Message-ID: <20171013190100.wjmjwyjmj6nt53i3@ninjato>
References: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zamswe7sddd6m5a4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--zamswe7sddd6m5a4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2017 at 04:51:26PM -0700, Guenter Roeck wrote:
> AMD Family 17h uses the KERNCZ SMBus controller. While its documentation
> is not publicly available, it is documented in the BIOS and Kernel
> Developer=E2=80=99s Guide for AMD Family 15h Models 60h-6Fh Processors.
>=20
> On this SMBus controller, the port select register is at PMx register
> 0x02, bit 4:3 (PMx00 register bit 20:19).
>=20
> Without this patch, the 4 SMBus channels on AMD Family 17h chips are
> mirrored and report the same chips on all channels.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to for-current, thanks!


--zamswe7sddd6m5a4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhDWsACgkQFA3kzBSg
KbZuXA//XnJBuJ8scgpE2OEVITqZV+yUuPcXqayZKgUfzYKYy+OOMToDY6GBXdJ+
YTIjlgI9FkaUTDNr+vQYCCL4YfKDxOraszAmlCWpEPx+NfI5jDsmpfOV7mKSxxov
42D806R58WH5fr714UO+F2vOj9E1v7NjR/1bAulS05XmxxVFU+bWzB5V/WksNxCM
rJCUvb/6aU75Vm+scl7yMebYfASpeojK+LecmBgYLlDasRnpnMKRPOuGFO/FiU9z
Ddpe7cv8EziJkIMydrorArXuxqRwg35XlZFv8HdIcX5sQ1qb6dy6FXkZN09Zkj1Y
Y9EHWc3whCWCCITNziTPQuHiuSAQ6Eg2AsvTAmQbKQvenPa2LzxGDZ95T9WL6yuC
bZTKsvmxbRUWHgrsln0OLcb9SW8T/tc4jZxDyA5Em+dFyg/Q7TmVYyhOObC2p31J
vfOEDT2rRWBhE/Fh/ptx4jp7XzECNK3EOrWNisQsXJ+EaGM/Rf/HdNXfRcKx2SZb
ZBkUvfEpFr7jX6ibwP7BQnRWGYbQhEbqY004d8lwWqZNyodLnW9gPNV5wqIR1eox
yg0Xlxk5nBH+sUV7OnRcWBOi2xNPMcfAxrlRnd3lXRtE0P0RkBNfLg5cMLeshBt0
2wlyvThvEq0+zCmkt9Rhb5gD1aSOMYTdUVB9cEo6OkNslmvQJYU=
=XcW+
-----END PGP SIGNATURE-----

--zamswe7sddd6m5a4--
