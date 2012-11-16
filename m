From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: s3c2410: Add fix for i2c suspend/resume
Date: Fri, 16 Nov 2012 12:46:17 +0100
Message-ID: <20121116114617.GE19028@pengutronix.de>
References: <1352182259-28903-1-git-send-email-a.kesavan@samsung.com>
 <CAM=Q2ctBMmg32-Dd6V5pwEEzxCnATs1se4RD_+zgLLOGohgSzw@mail.gmail.com>
 <CAM4voa=hnKR_ovUu_uzy8o5wQ2WXazKceLTWh=tj02YWRgRbYA@mail.gmail.com>
 <CAM4voa==f81W-pC80Q43NzvF6uXXVZmLH2_Ta4A3x3EuboQWVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM4voa==f81W-pC80Q43NzvF6uXXVZmLH2_Ta4A3x3EuboQWVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2012 at 09:10:33AM +0530, Abhilash Kesavan wrote:
> Hi,
>=20
> Any comments on this fix ?

Yes, I agree with Shubhrajyoti here and the code should be refactored so
that gpio initialization is only done once at probe-time unless there is
a real reason to do at suspend/resume.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCmJ4kACgkQD27XaX1/VRsQmACdH0+hRJPSWPUn5H7cI3dH5epl
YVYAnA29w6XX9D4cDRVR865VmAvJ2eIk
=xq+7
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
