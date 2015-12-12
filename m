From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] I2C: designware: fix IO timeout issue for AMD
 controller
Date: Sat, 12 Dec 2015 18:03:22 +0100
Message-ID: <20151212170322.GB1530@katana>
References: <1449835373-4669-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56749 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbbLLRDe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Dec 2015 12:03:34 -0500
Content-Disposition: inline
In-Reply-To: <1449835373-4669-1-git-send-email-Xiangliang.Yu@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2015 at 08:02:53PM +0800, Xiangliang Yu wrote:
> Because of some hardware limitation, AMD I2C controller can't
> trigger pending interrupt if interrupt status has been changed
> after clearing interrupt status bits. Then, I2C will lost
> interrupt and IO timeout.
>=20
> According to hardware design, this patch implements a workaround
> to disable i2c controller interrupt and re-enable i2c interrupt
> before exiting ISR.
>=20
> To reduce the performance impacts on other vendors, use unlikely
> function to check flag in ISR.
> ---

Don't manually add "---". This breaks a lot of workflow scripts.
"Patchwork" missed your Signed-off, for example!

> Changes in v2:
>     - pass flags with ->driver_data
>     - unmask interrupt right after masking

This paragraph...

>=20
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> ---

=2E.. needs to go here.

However, I fixed it this time and applied to for-current, thanks!


--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbFNaAAoJEBQN5MwUoCm2u50P+gPcfoUv1GdjK6bFMHFWfnuE
stErUWfP8vq2V1SFGUulRd9crvVqm7JWqx3GlUnXgIot9haNGp83RKvhQTnpASN8
r4hA7p8CUN+li/8NkfAS+QNsTZ1M7HBDtoWazEhjM/EV/N8zdT5Lbk+bJw7ScB7K
sVAzy8XQB14LBPEHotoM3zGkXYQOf9NKxhTAerqRXKi5LE7ae7dlNSVWLo1QEGUH
HqTiRgVw/DWPcTywDdMq34GmCxbUmA3+ALtGsDNvnKT/0wxB2PKmfvW+3HX2JAST
LR8nn6mwj/hvfh8thL1V2btDV0+4MPkLnJpxkxd5H0infJ3auKjjXPrBXZusIQBU
4YYt+swhXY51HfTFmeE9PGHLkzbzTFOLX30LqxllEgsXET/lg4LVYCEUA+sTJvc8
KCoq4UHPxgqBpJF8VOusfXSe6EJAhtxs3+lvkK251aJfbQXQUmwZn/mONLI32zM7
6xaezdd3vd3NqHzJt6mtffAEF2LkEbdkgExnYw2C/sdF7fGGkgucJLH39/MkesQn
qm4+8IbBQ1ciDch74nHxoRwA6LSRUZxuzGa3+mV7VBYFjinu/1R+E4XabXyKEVOb
cVnKqn9IH8LW2tc7CXYM+rStUGfh9rDgwQnb708GbxXMila9ugdCKWY3ky3/cxxE
md/NnprEilTlUZTRvJYB
=8GGs
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
