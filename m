From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Problem Configuring Micron sensor MT9D131 using i2c
Date: Fri, 30 May 2008 16:33:22 +0200
Message-ID: <20080530143322.GA4872@pengutronix.de>
References: <1106299A6DFA0E4D8E13CFD83A7611F09E2CA1@IE10EV813.global.ds.honeywell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4899609359587304066=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1106299A6DFA0E4D8E13CFD83A7611F09E2CA1-8tR4ov5Cr7uXeP9mKtfZqKJzXdaVS04K4Jgwf8ORaLoAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Tekkalkot, Seetaram (IE10)" <Seetaram.Tekkalkot-TF0kVB3jB5US+FvcfC7Uqw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============4899609359587304066==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 30, 2008 at 04:36:03PM +0530, Tekkalkot, Seetaram (IE10) wrote:

> 1.	As per the datasheet the i2c read address is 0x91 and write
> address is 0x90, should I set any of these slave addresses based on
> whether I am reading or writing?
The datasheet seems obscure. An I2C-address is 7-bit and then there is a
bit stating if the access shall be r/w. Of course, together they form a
byte, but the address is 7 bit _only_ (there is a 10 bit extension, but
this exception does not apply here). So, the _address_ is 0x48.

> 2.	I am using 7 bits from 0x91 which 0x48, is this correct?
Yes.

> 3.	Why i2cdetect doesn't detect this device and also i2cget can't
> read from register 0x00?
Is there anything detected on that bus? Is there something else
connected to that bus?

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIQBAyD27XaX1/VRsRAl09AJ0fJjhMpTJkQRHpi9UZ3ffdLRK9JACfVR06
6I6CvcRP8CajTfaMcBB73FQ=
=hPRG
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--


--===============4899609359587304066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4899609359587304066==--
