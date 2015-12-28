From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: retry transfer on transient failure
Date: Mon, 28 Dec 2015 18:34:40 +0200
Message-ID: <1451320480.30729.351.camel@linux.intel.com>
References: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19078 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbbL1QeV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 28 Dec 2015 11:34:21 -0500
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

Wolfram, regarding to this patch I have the following idea (I would
like to discuss a road map before step in implementing that).

=46irst of all I would like to refactor the existing API,
i.e.=C2=A0i2c_parse_fw_timings(). So, do exactly two things:
a) embed struct i2c_timings into struct i2c_adapter;
b) change prototype to be=C2=A0i2c_parse_fw_timings(struct i2c_adapter
*adapter, bool use_defaults).

After that, introduce a new property 'linux,i2c-retry-count' to be used
as retries field in struct i2c_adapter.

Then introduce where we do similar stuff

void i2c_parse_linux_retries(struct i2c_adapter *adapter, bool
use_defaults)
{
=C2=A0 struct device *dev =3D adapter->dev.parent;
=C2=A0 int ret;

=C2=A0 ret =3D device_property_read_u{8,16,32?}(dev, "linux,i2c-retry-c=
ount",
&adapter->retries);
=C2=A0 if (ret && use_defaults)
=C2=A0 =C2=A0 adapter->retries =3D 3;
}

And replace adapter.retries =3D 3 in the drivers by
i2c_parse_linux_retries(&adapter, true);

So, what do you think?

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
