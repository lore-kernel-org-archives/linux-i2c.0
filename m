From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 00/16] i2c: remove __dev* attributes for retirement of
 HOTPLUG
Date: Wed, 28 Nov 2012 11:47:16 +0100
Message-ID: <20121128104716.GC14238@pengutronix.de>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 03:59:37PM -0500, Bill Pemberton wrote:
> This is a respin of the patches to remove the __dev* attributes in the
> i2c subsystem.
>=20
> The attributes __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit are no longer needed since CONFIG_HOTPLUG is being
> removed as an option.

Thanks. Will wait one more day for acks, then probably squash them into
one and make this the last commit for 3.8. Is that okay with you?

Regards,

    Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlC167QACgkQD27XaX1/VRtNCACZAYk09uWfzm5+MOSWQLGzuSxh
BCgAnjIMpQq5AYmzUWbOm5xuvpJczA8t
=ISjT
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
