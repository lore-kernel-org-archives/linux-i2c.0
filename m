From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [Patch V5 2/2] i2c: imx: add low power i2c bus driver
Date: Tue, 29 Nov 2016 22:35:12 +0100
Message-ID: <20161129213512.GB15594@katana>
References: <1479714704-3014-1-git-send-email-pandy.gao@nxp.com>
 <1479714704-3014-2-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47998 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbcK2VfP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 16:35:15 -0500
Content-Disposition: inline
In-Reply-To: <1479714704-3014-2-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de, cmo@melexis.com, robh@kernel.org, vz@mleia.com, linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.

Here you say GPL v2 or later, while at the end you declare GPL V2 only.
This needs to be made consistent.

> +static irqreturn_t lpi2c_imx_isr(int irq, void *dev_id)
> +{
> +	struct lpi2c_imx_struct *lpi2c_imx = dev_id;
> +	unsigned int temp;
> +
> +	lpi2c_imx_intctrl(lpi2c_imx, 0);
> +	temp = readl(lpi2c_imx->base + LPI2C_MSR);
> +
> +	if (temp & MSR_RDF) {
> +		lpi2c_imx_read_rxfifo(lpi2c_imx);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (temp & MSR_TDF) {
> +		lpi2c_imx_write_txfifo(lpi2c_imx);
> +		return IRQ_HANDLED;
> +	}
> +
> +	complete(&lpi2c_imx->complete);
> +
> +	return IRQ_HANDLED;
> +}

Minor nit: Why can't you have one single exit point (e.g. only one
'return IRQ_HANDLED') here?

> +MODULE_LICENSE("GPL v2");

Here is GPL v2 only...

Rest looks good. Thanks Vladimir for the reviews!

Thanks,

   Wolfram


--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPfSQAAoJEBQN5MwUoCm2nCEP/R4EGx1pv5TIp5ITL8HXhv+6
+iwr2k9u1eH+TCB/uEdj+Pd/MKxhrHYdFvw8Ce+RhUTfzIsO4JHK9JPMeJbFY0hr
lrWuVxRebAz4ApJ5q81B4As2cozNrdXkDMvzYjJZtEZzDz/jhzNltVNuKLst9PQq
CrD0LoCnhD9/XKfGE/v3VnLjySYgT6SPhpSUugoEAfKYYMXF0+6FrLnwC5Rs7PpB
J/oKO4h8As8EBulYFBBCraHB83wsA+eQvlAYeSn8QyWSkWlhi2zhCcWq9EYHDXr5
upuXZBEkr3/xaTU/10vvjAlD7jCjgUDyS0J0BPRJA52Y9ctaTXvp4aIxTmEErNW1
1QZ/QPoVlm/aKrXR5Pro8b91cXcD1es/B06JikiMb1llrDmTVsb1P3jR8tiDhDkf
qUuibznOqkekN/qHWval7LxtD4VBcHF/bAtZzc1S1Y7Xmm3l82FzcyhqOZdoW2q6
EBhBn30V15ccx6Y4MdtsUkwQKt03nktnxLwCQdtS+qqQttYhb3cM7gs3oEueMj07
lKe7LUdzPuILjjb/jAvHssxZrUjY1h6XuMJDfbwbIpcuvqgevT3rB/J1I0u9FiNH
WsErUDNrUNd0w9DUVVxYkRjBtMcY2xlYefr0ou7U2pozNYEbZF4gpl+WX4hKvF6X
nUgCLncOSPJYS0PPq3OE
=5N+D
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
