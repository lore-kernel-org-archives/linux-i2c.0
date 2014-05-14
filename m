From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2] i2c-designware: Mask all interrupts during i2c
 controller enable
Date: Wed, 14 May 2014 17:53:41 +0200
Message-ID: <20140514155341.GB12911@katana>
References: <7286EAF50D3F4E4AADE7FEECEBF8B5A547FF93E0@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7286EAF50D3F4E4AADE7FEECEBF8B5A547FF93E0-8oqHQFITsIHTXloPLtfHfbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2014 at 11:03:19PM +0000, Du, Wenkai wrote:
> Hi all,
>=20
> Updated problem descriptions from Mika's feedback and new test data:=20
>=20
> There have been "i2c_designware 80860F41:00: controller timed out" errors
> on a number of Baytrail platforms. The issue is caused by incorrect value=
 in
> Interrupt Mask Register (DW_IC_INTR_MASK)  when i2c core is being enabled=
=2E=20
> This causes call to __i2c_dw_enable() to immediately start the transfer w=
hich
> leads to timeout. There are 3 failure modes observed:
>=20
> 1. Failure in S0 to S3 resume path
>=20
> The default value after reset for DW_IC_INTR_MASK is 0x8ff. When we start=
=20
> the first transaction after resuming from system sleep, TX_EMPTY interrup=
t=20
> is already unmasked because of the hardware default.
>=20
> 2. Failure in normal operational path
>=20
> This failure happens rarely and is hard to reproduce. Debug trace showed =
that
> DW_IC_INTR_MASK had value of 0x254 when failure occurred, which meant=20
> TX_EMPTY was unmasked.
>=20
> 2. Failure in S3 to S0 suspend path
>=20
> This failure also happens rarely and is hard to reproduce. Adding debug t=
race
> that read DW_IC_INTR_MASK made this failure not reproducible. But from IS=
R=20
> call trace we could conclude TX_EMPTY was unmasked when problem occurred.
>=20
>=20
> The patch masks all interrupts before the controller is enabled to resolv=
e the
> faulty DW_IC_INTR_MASK conditions.
>=20
> Signed-off-by: Wenkai Du <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Fixed the commit message and improved the comment to:
	/* enforce disabled interrupts (due to HW issues) */"

Applied to for-current, thanks!


--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTc5GFAAoJEBQN5MwUoCm2p+YP/1cc1fFM7NIC6itbZOgCv1YY
qLaDsPK1KubCDls98cL6OEXVR7UCEF1QvnQW1KiW79r8jyooG4vaXhNhSbI+nCD+
GNlR0uSdCSVDfw2X/vaAl7GQDOIwqZfMRhi2miNP28py9LsV/OH1QajzWnfcq4ir
5E7uWA1cBKnE7CoAnHY2g9qj5geCTWeXrYQiCYmI0C8wszpwe8QOffvXnlGZWwa7
GUBhORwjrYKOb5EXPye/S7IAkN8AVV6Q4/hX9me01G38rIomCSOp3u4h/TDwgiFF
E0RRnyfGC8xk24a8tS8kINtlhwI9YIpHsQi5fEbGtephsNFwQEFYTaln9EkbhKEq
eLk0oneqFgM2Gpk+aUufcjiZe1UlDXYLAjqTNWzQmXGqVKZJCH90iCyohJREKCqn
RMr/qRwnIJTrZO6pzJSPnqGuq9JOB/dNM4A+oXwbpoc1d4etgCf4M82dq+QPJsId
krbywNaYHKIGxvrAWe+8xHQNoshLwK4/oXfLVLqsuwQAntM/k0lO3GWuU6DYDWht
ASXM8cel1XcwxADFS4B4ejRzOydYX/DW4Vhxk7q4metv1i6bYBWUqireyUsF0Oyl
mAMhaCaw5RwqSnpXKaxEY2pRswrYFY0EoEGuSFuESKhbh0b6AsU2eOg7lFJhJd5X
27wP/AENDPRCHDEKfB9r
=gSO5
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
