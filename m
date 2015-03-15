From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: designware: Suppress error message if
 platform_get_irq() < 0
Date: Sun, 15 Mar 2015 11:26:34 +0100
Message-ID: <20150315102634.GA13692@katana>
References: <1425891792-9248-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425891792-9248-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Christian Ruppert <christian.ruppert@abilis.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 12:03:12PM +0300, Alexey Brodkin wrote:
> As discussed here https://lkml.org/lkml/2015/3/3/568 and here
> https://lkml.org/lkml/2015/3/3/453 we're looking forward for
> implementing warnings and errors outputs right in platform_get_irq()
> instead of having all kind of different outputs in each and every driver
> that uses platform_get_irq().
>=20
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Christian Ruppert <christian.ruppert@abilis.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reworded the commit message to state the initial reason for this patch
and applied to for-next, thanks!


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBV5aAAoJEBQN5MwUoCm2TFAP/0mEr5BBdXz3eTwyCq7bbd2X
Of3535OCA5c+3ABNdQ5fldvtqg/rh8n+n5T6ETfv/lCC8aU39evwSQuMx63igAlI
EoHzYu2ZFgIcpjY5Zi6r7BZDbgE5sj1GHhgKu4WJavh+TQp221EPpOtbvdDzM1XD
/ZhOviaYLaXBG2g/hNzViASwLiAmR4050duLnzBpLSlCU9rk9rMP2WVWAx0IjCCU
NgXVqq2OJJksAd8KxxH4BfG8jJemWsS9fkFUaaRO0X9hFiMmCQBcObILv8UBenS0
o9+N4uTrlt6ZiJchyIoLesfcjRthKHwRTBEIgz+vrr7nLnCU3ELlz2EApTer1cZa
obyMcx2rx2DY+XMA6/vxDTdmOs+FnqEsTJf7Q7BkuaPF6os+h3qhlKvhnXoWKSh/
wI2tx9p39mHV3Q2MfzECNbSkmSuBvpJa+7OUk/LG+FupwdOxtgja7qje0+dyNlhB
XUGXAJ4efKAc3bRh/lVb0948bj1YLKUVrYm3sRC6uXccg/pxEthwktb3rpbu9+Dk
F/QrExYtw5mwO9ZVlkz36mIVm1FvdgLlHt6Ap7tAXxGFExXD429/W2/2HAyk3ZQ5
LR3cCoOT6Z0WhFvkxGVyiceDk9+fwIalOoGS6rpyVspzAXWyRFdjcmIg305gejdo
5O7oP1lBOBgJaV9xvvfn
=zAc7
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
