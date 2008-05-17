From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on
	Freescale	CPM1/CPM2 controllers
Date: Sat, 17 May 2008 15:46:45 +0200
Message-ID: <20080517134645.GA4404@pengutronix.de>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080516083743.GA4180@pengutronix.de>
	<20080516210818.26bf8cb8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5018864832524044558=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080516210818.26bf8cb8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, htoa-hi6Y0CQ0nG0@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, tmbinc-hi6Y0CQ0nG0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============5018864832524044558==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2008 at 09:08:18PM +0200, Jean Delvare wrote:
> Would you have the possibility to review and ack this patch (with the
> suggested fix above, of course)? I'd like to include it in my i2c tree
> now as it has been around for some time but I'm a bit short of time to
> review it and I also can't test it. If you can do that then I'll trust
> your review and take the patch quickly.
Well, I could review it and give further testing on Monday. Still, I
wouldn't call my experiences in the linux-kernelspace (yet) big enough
to trust only this review. Still, thanks for your trust :)

> With the time saved, I could, say, review the at24c driver ;)
Hehe, nice offer. Though, I'd suggest to wait for the upcoming version
of the at24-driver, which will include proper device table support. I
already made up my mind how to implement it, just have to get hacking.

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILuHFD27XaX1/VRsRArLtAKCmBnLajeKqkQ10Kgi2qNuJIE2HpQCgyOpB
BFLKFf/3LFZDU10DrYRG0kI=
=SByJ
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


--===============5018864832524044558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5018864832524044558==--
