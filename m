From: Pandy Gao <pandy.gao@nxp.com>
Subject: RE: [Patch V5 2/2] i2c: imx: add low power i2c bus driver
Date: Wed, 30 Nov 2016 02:26:06 +0000
Message-ID: <AM4PR0401MB17801344E30C3F05EBBC905EF68C0@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1479714704-3014-1-git-send-email-pandy.gao@nxp.com>
 <1479714704-3014-2-git-send-email-pandy.gao@nxp.com>
 <20161129213512.GB15594@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0076.outbound.protection.outlook.com ([104.47.2.76]:20352
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756109AbcK3GBB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Nov 2016 01:01:01 -0500
In-Reply-To: <20161129213512.GB15594@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "cmo@melexis.com" <cmo@melexis.com>, "robh@kernel.org" <robh@kernel.org>, "vz@mleia.com" <vz@mleia.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Andy Duan <fugang.duan@nxp.com>

 From: Wolfram Sang <mailto:wsa-dev@sang-engineering.com> Sent: Wednesday, =
November 30, 2016 5:35 AM
> To: Pandy Gao <pandy.gao@nxp.com>
> Cc: wsa@the-dreams.de; u.kleine-koenig@pengutronix.de;
> cmo@melexis.com; robh@kernel.org; vz@mleia.com; linux-
> i2c@vger.kernel.org; Frank Li <frank.li@nxp.com>; Andy Duan
> <fugang.duan@nxp.com>
> Subject: Re: [Patch V5 2/2] i2c: imx: add low power i2c bus driver
>=20
>=20
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
>=20
> Here you say GPL v2 or later, while at the end you declare GPL V2 only.
> This needs to be made consistent.
>=20
> > +static irqreturn_t lpi2c_imx_isr(int irq, void *dev_id) {
> > +	struct lpi2c_imx_struct *lpi2c_imx =3D dev_id;
> > +	unsigned int temp;
> > +
> > +	lpi2c_imx_intctrl(lpi2c_imx, 0);
> > +	temp =3D readl(lpi2c_imx->base + LPI2C_MSR);
> > +
> > +	if (temp & MSR_RDF) {
> > +		lpi2c_imx_read_rxfifo(lpi2c_imx);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (temp & MSR_TDF) {
> > +		lpi2c_imx_write_txfifo(lpi2c_imx);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	complete(&lpi2c_imx->complete);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> Minor nit: Why can't you have one single exit point (e.g. only one 'retur=
n
> IRQ_HANDLED') here?

Thanks,  will change it in next version.=20
=20
> > +MODULE_LICENSE("GPL v2");
>=20
> Here is GPL v2 only...

Thanks, will change it in next version.

Best Regards
Gao Pan
