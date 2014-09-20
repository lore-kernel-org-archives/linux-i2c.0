From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: Rework probe() to get clock a bit
 later
Date: Sat, 20 Sep 2014 11:35:02 +0200
Message-ID: <20140920093502.GF1612@katana>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411032367-20274-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2014 at 12:26:06PM +0300, Mika Westerberg wrote:
> In order to be able to create missing clock for AMD (and in future possib=
ly
> others) we move getting clock for the device a bit later. Also make ACPI/=
DT
> configuration in the same place depending on from where the device was
> enumerated from.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHUpGAAoJEBQN5MwUoCm28I8P/1MglYYCH5WsmhR7zuEDvjX8
nFNxmEohz4B6gVyr8UGryn7FMbod0CGT4su2GAXD405y4obYKxCRJMLACR5kJa6d
/fID24kKF/Jen9/Kmyy3+DtiQIyRTAeSVZlSHyNc/ejFZdKRPT5KMqAQa0QiN9ZK
zxrLSWWATVyTyXcDkKLQbHze4em3csANrk0ESG7WR6f75tMri6wKu5z/0pU9uRun
ZSDIGh7Cxxp8UhRycFy3Zi89kI897kQZeXSRF0w2LZkXAE7ZwAr52465yfaIhBqk
7mxpNkMnXuS7wOv3ZXAdGPLMBEQrK0VGMvoK+mOAIJ5iJ/tubsk6WkpnAMBV69nb
2J80+CEkgi/8wQLJJ8GHmdw3Dx+tlr5YCaynU419N+ujkyJ8raZp6yLqpefH5mAQ
91avOYJ+s4/vkjWoEuirUYFSLvPVXW6PIk3kNLZOVL8gddSnzsu/O3g7G4u4xD+C
/bzCogmXteXnRbbJe+DlCwuAX6tjdTHrrTLF/L1937N1+lhnIFgVPim2AW190DHm
u4vLhs7aQABpSBN+/GUwsNRIihCeeIu8Z91FIxvTcr2UzzbWW3MQeaWkkO6nXeHa
sBXywVvEFOj6Kl5+wGegY69Il2toWRhPXadowzIjZxwqdijjCMWUTz5JaDJub2XM
2vpsvr8D0CrjKTBCRrV1
=MmcG
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
