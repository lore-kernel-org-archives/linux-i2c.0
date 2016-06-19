From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: designware: Use transfer timeout from ioctl
 I2C_TIMEOUT
Date: Sun, 19 Jun 2016 18:54:01 +0200
Message-ID: <20160619165400.GA2933@tetsubishi>
References: <1466127995-28318-1-git-send-email-weifeng.voon@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466127995-28318-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Weifeng Voon <weifeng.voon@intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com
List-Id: linux-i2c@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 09:46:35AM +0800, Weifeng Voon wrote:
> This allows applications to set the transfer timeout in 10ms increments v=
ia
> ioctl I2C_TIMEOUT.
>=20
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>

Applied to for-next, thanks!


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZs4oAAoJEBQN5MwUoCm2XkQQAKnZLczXKysQFmp2HxbmeKXk
sxQkiGzpcLWvZGrDRdUxYGe55rmb30Rw1tfpANZj9XuWsgQ9fX9s0Q19Ta/qytw6
cjIm1d9gJWvsxSLCAR+lVKldGL1M3j7oVIVqMPnSUQeHBvlMBK8mbm9u6zc8ff6X
IOkEdtj4AVoFfJDs7hT1eCRcZR2WEgYDFm8it07s0qUluk4VDk5e2y1hqX6E3Eoc
b1anmlP12RRGu1sxp+uvhzwD0DDC4dKQDQtJ1VO9+CHRWzJGGXzRhPLTzZS8mxDy
NSCWpo1zr9LxRxqNPLa8bWN009maXwVTrneyRfH4YbrypD5wF/k6MJi84hZB7EZX
N312BncgNBqihIX26uJITBluiIQtXQHXpZrqYqbth7BA587tSm4PArgZc9xU7en3
2h6tUrcFy6MxaiOt92ThSeBfxYkP+Zy984ttIrceeHvdG8+ZhWx0zU4elaeJ0XYj
1GnDWOhOZiUnY6+f/GUYk2SrZY/p2V3N1lR32aynf4Q4dvzu7nSIqkg54LCELTRk
BbcHyY7fbAaQtQhnYB2vN6CC7h+ZiHdnu9ZkKvRgwaVh+8CMm+qOE1FbOzKnr+UW
CZbv64/5UGFC6KkxLrSek3r+LLFtQRReOQdrct8dlnEpu1Qc5/QOid4+WSo145IA
TYuuiXIOxumXwVkf9Sw/
=Xz0W
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
