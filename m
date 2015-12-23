From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: retry transfer on transient failure
Date: Wed, 23 Dec 2015 18:51:47 +0200
Message-ID: <1450889507.30729.311.camel@linux.intel.com>
References: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65384 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbbLWQxh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 11:53:37 -0500
In-Reply-To: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Rolland Chau <zourongrong@gmail.com>

On Wed, 2015-12-23 at 18:43 +0200, Baruch Siach wrote:
> Set the i2c_adapter retries field to a sensible value. This allows
> the i2c core
> to retry master_xfer() when it returns -EAGAIN. Currently the i2c-
> designware
> driver returns -EAGAIN only on Tx arbitration failure
> (DW_IC_TX_ARB_LOST).

While this patch looks okay I have another proposal.
Let me time I'm going to mock up the idea.

>=20
> Reported-by: Rolland Chau <zourongrong@gmail.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> =C2=A0drivers/i2c/busses/i2c-designware-core.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c
> b/drivers/i2c/busses/i2c-designware-core.c
> index de7fbbb374cd..f7b34b360dc9 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -860,6 +860,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
> =C2=A0
> =C2=A0	snprintf(adap->name, sizeof(adap->name),
> =C2=A0		=C2=A0"Synopsys DesignWare I2C adapter");
> +	adap->retries =3D 3;
> =C2=A0	adap->algo =3D &i2c_dw_algo;
> =C2=A0	adap->dev.parent =3D dev->dev;
> =C2=A0	i2c_set_adapdata(adap, dev);

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
