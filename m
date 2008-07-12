From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Date: Sat, 12 Jul 2008 10:22:59 +0200
Message-ID: <20080712082259.GA16810@pengutronix.de>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca> <4877ADF6.8070702@scram.de>
	<20080711191502.GA21847@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1100626352313778528=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080711191502.GA21847-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============1100626352313778528==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 11:15:02PM +0400, Anton Vorontsov wrote:

> > Nope, it was a bug in the i2c documentation fixed recently:
>=20
> Nope? I'm looking into i2c-core.c:
>=20
> .. i2c_new_device(...)
> {
> 	client->irq =3D info->irq;
>=20
> Core will blindly pass irq, so clients should ensure that irq contains
> correct value. And as far as there is no common scheme of checking that
> "there is no irq specified", the most safe option is -1.

I wonder if -1 is really the safest; even kernel functions related to
irqs are not consistent if "irq" is int or unsigned int. So, -1 could
cause subtle signedness defects.

The whole "no irq" mess really needs to be cleared generally. It just
disturbed me that i2c_core was imposing -1, whilst some other subsystem
may have chosen 0. IMHO, subsystems like i2c should pass irqs
transparently. This is why I submitted the patch for i2c documentation.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIeGnjD27XaX1/VRsRArEiAJ9xfVOqDCtbNBdZwYcDEW7rV69+kACfeWzP
l8tV0MpEEcfv3agorJmyMP0=
=no9Z
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--


--===============1100626352313778528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1100626352313778528==--
