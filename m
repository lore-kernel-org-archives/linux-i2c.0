From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 00/18] i2c: make creation of 8 bit addresses consistent
Date: Mon, 04 Apr 2016 13:31:38 +0300
Message-ID: <1459765898.2503.19.camel@linux.intel.com>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61295 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611AbcDDKal (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Apr 2016 06:30:41 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Sun, 2016-04-03 at 20:44 +0200, Wolfram Sang wrote:
> This series addresses two things which have come up in the past:
>=20
> * document that I2C_M_RD is bit 0. It is not good coding style but
> some
> =C2=A0 drivers (and userspace) silently assume so anyhow. To avoid
> regressions,
> =C2=A0 let's make that explicit.
>=20
> * use one function to generate an 8 bit address (7 bit address + RW
> bit)
> =C2=A0 from a struct msg. People did this in various ways, sometimes
> overly
> =C2=A0 brave and sometimes overly anxious with the operator precedenc=
e.
> That
> =C2=A0 was partly not nice to read and partly triggering code checker=
s.
>=20
> The new function was tested using a Renesas Lager board with the i2c-
> sh_mobile
> driver. Buildbot was happy with the series, too. A branch can be
> found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> i2c/8bit_macro
>=20
> I'd really appreciate more tests on real HW. Also happy for other
> comments,
> reviews...

=46WIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. Couple of minor question, though I'm okay with either option.

>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0Wolfram
>=20
>=20
> Wolfram Sang (18):
> =C2=A0 i2c: guarantee that I2C_M_RD will be 0x0001 forever
> =C2=A0 i2c: introduce helper function to get 8 bit address from a mes=
sage
> =C2=A0 i2c: core: use new 8 bit address helper function
> =C2=A0 i2c: i2c-bcm-iproc: use new 8 bit address helper function
> =C2=A0 i2c: i2c-bcm-kona: use new 8 bit address helper function
> =C2=A0 i2c: i2c-brcmstb: use new 8 bit address helper function
> =C2=A0 i2c: i2c-cpm: use new 8 bit address helper function
> =C2=A0 i2c: i2c-ibm_iic: use new 8 bit address helper function
> =C2=A0 i2c: i2c-img-scb: use new 8 bit address helper function
> =C2=A0 i2c: i2c-iop3xx: use new 8 bit address helper function
> =C2=A0 i2c: i2c-lpc2k: use new 8 bit address helper function
> =C2=A0 i2c: i2c-mt65xx: use new 8 bit address helper function
> =C2=A0 i2c: i2c-ocores: use new 8 bit address helper function
> =C2=A0 i2c: i2c-powermac: use new 8 bit address helper function
> =C2=A0 i2c: i2c-qup: use new 8 bit address helper function
> =C2=A0 i2c: i2c-sh_mobile: use new 8 bit address helper function
> =C2=A0 i2c: i2c-sirf: use new 8 bit address helper function
> =C2=A0 i2c: i2c-st: use new 8 bit address helper function
>=20
> =C2=A0drivers/i2c/busses/i2c-bcm-iproc.c |=C2=A0=C2=A02 +-
> =C2=A0drivers/i2c/busses/i2c-bcm-kona.c=C2=A0=C2=A0|=C2=A0=C2=A05 +--=
--
> =C2=A0drivers/i2c/busses/i2c-brcmstb.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
4 +---
> =C2=A0drivers/i2c/busses/i2c-cpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A04 +---
> =C2=A0drivers/i2c/busses/i2c-ibm_iic.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
2 +-
> =C2=A0drivers/i2c/busses/i2c-img-scb.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
4 +---
> =C2=A0drivers/i2c/busses/i2c-iop3xx.c=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A05 +----
> =C2=A0drivers/i2c/busses/i2c-lpc2k.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A04 +---
> =C2=A0drivers/i2c/busses/i2c-mt65xx.c=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A05 +----
> =C2=A0drivers/i2c/busses/i2c-ocores.c=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A05 +----
> =C2=A0drivers/i2c/busses/i2c-powermac.c=C2=A0=C2=A0|=C2=A0=C2=A04 +--=
-
> =C2=A0drivers/i2c/busses/i2c-qup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0drivers/i2c/busses/i2c-sh_mobile.c |=C2=A0=C2=A03 +--
> =C2=A0drivers/i2c/busses/i2c-sirf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A04 +---
> =C2=A0drivers/i2c/busses/i2c-st.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A03 +--
> =C2=A0drivers/i2c/i2c-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0include/linux/i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A05 +++++
> =C2=A0include/uapi/linux/i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 13 +++++++------
> =C2=A018 files changed, 28 insertions(+), 48 deletions(-)
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
