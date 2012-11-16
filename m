From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 11/11] i2c: pxa: no need slave addr for i2c master mode
 reset
Date: Fri, 16 Nov 2012 14:55:57 +0100
Message-ID: <20121116135557.GC7313@pengutronix.de>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
 <1352384284-15660-11-git-send-email-liangs@marvell.com>
 <78895A20B3CF7D49B5589B604D36692B1B59F88BFD@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <78895A20B3CF7D49B5589B604D36692B1B59F88BFD-r8ILAu4/owuq90oVIqnETxL4W9x8LtSr@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jett Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 08, 2012 at 06:25:24AM -0800, Leo Song wrote:

> Would you please help to review and merge these 11 patches for
> drivers/i2c/busses/i2c-pxa.c?

There are already a few formal things:

- For large series, please write a cover-letter describing the series in
  total (use --cover-letter). The omap guys do this very well, check the
  list archive.

- why would upstream need Change-Id: in the patch description?

- the cover letter should also state what testing you did. the pxa
  driver is used in lots of different SoCs and I'd like to know how
  much this was tested on other systems regarding regressions.

- if you can't test it on other machines, ask for help. Putting alkml on
  CC is one way to do this

- I'd ask you to add alkml anyway since your patches include hooks to
  the mach and there are people having more experience on this platform
  than me

I didn't really have a look at the code yet, since I ask you to resend
it fixing the above points first. But from a glimpse, you should try to
avoid adding function pointers to platform_data at all costs. Maybe you
can think of alternative solutions.

Regards and thanks for the submission,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCmRe0ACgkQD27XaX1/VRudGACeOmFn5J1I8/TH0itf5gxRPgtQ
nUEAn1yGKakUBwca26l3Ilrha2p7v8zJ
=TIYk
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
