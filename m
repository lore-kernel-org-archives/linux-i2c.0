From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: pca9665
Date: Fri, 19 Sep 2008 13:56:05 +0200
Message-ID: <20080919115605.GE4307@pengutronix.de>
References: <48D12295.8080008@gamic.com> <20080919100819.GC4307@pengutronix.de>
	<48D38EF5.60303@gamic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3643880781216474174=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48D38EF5.60303-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============3643880781216474174==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Fri, Sep 19, 2008 at 08:37:25AM -0300, Marco Aurelio da Costa wrote:

> I will have to understand the buffered mode first, but at worse I will=20
> have to check which mode is being used and add another logic path.

Yes, let's hope it can be worked into the current logic then...

> My ideas was to share the platform and the isa code. This is easy=20
> enough. For the PCA9665, the platform will not define the reset=20
> function, and the algorithm will not even try use it.

Okay, got it. I agree.

> I can do that then. We should then pass the frequency. For the 9564, I=20
> will just accept the chip defined frequencies.

Sounds like the right way to do it. I just wonder if we simply can
enforce this change of platform_data or if we should provide some
transition feature. Jean, Ben, others, what are your experiences?

> That is also my view. I will start coding, and will send you the patch=20
> for review later.

Happy hacking! :D

Bye,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI05NVD27XaX1/VRsRAoBXAJ4h2zQcMaDp8QvrZODemw/u1j3DcgCfSFTM
/kfXtU2gWG8X41vV8Bs/Jec=
=jUNZ
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--


--===============3643880781216474174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3643880781216474174==--
