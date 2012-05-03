From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V1 1/2] i2c: tegra: fix 10bit address configuration
Date: Thu, 3 May 2012 10:18:30 +0200
Message-ID: <20120503081830.GA9574@pengutronix.de>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>
 <1335251976-31925-2-git-send-email-ldewangan@nvidia.com>
 <20120424105815.1d9e7d95@endymion.delvare>
 <4FA221FA.2030305@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA221FA.2030305-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2012 at 11:43:14AM +0530, Laxman Dewangan wrote:
> On Tuesday 24 April 2012 02:28 PM, Jean Delvare wrote:
> >On Tue, 24 Apr 2012 12:49:35 +0530, Laxman Dewangan wrote:
> >>The slave address of device to be configured in packet
> >>header as follows:
> >>     7 bit address: PacketHeader3[7:1]
> >>     10 bit address: PacketHeader3[9:0]
> >>
> >>Fixing the code to make packet header3 properly.
> >>
> >>Signed-off-by: Laxman Dewangan<ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >>---
> >>
> >Looks good.
> >
> >Acked-by: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> >
> Can it be apply? This is independent of other change in this series
> which is under discussion/review.

Applied to next. Or do you need it in 3.4?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+iP1YACgkQD27XaX1/VRvN8QCbBzF0UAd/UwxcljvYhWDgkGo/
o7IAoK4I9E+AgLV9gM3PF51tPR2DWx8g
=7WHf
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
