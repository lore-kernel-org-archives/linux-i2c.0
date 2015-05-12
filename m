From: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Subject: Re: [PATCH v7 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Tue, 12 May 2015 14:58:32 +0200
Message-ID: <20150512125832.GB4447@schokonusskuchen.bad>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <1430901427-65146-3-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430901427-65146-3-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo
List-Id: linux-i2c@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/mm.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>

Please sort the includes to avoid duplicates.

> +struct mtk_i2c_compatible {
> +	const struct i2c_adapter_quirks *quirks;
> +	unsigned char pmic_i2c;
> +	unsigned char dcm;
> +};

I wonder if the unsigned char options can be bits in a flags variable?

> +static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
> +	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
> +	.max_num_msgs = MAX_MSG_NUM_MT6577,
> +	.max_write_len = MAX_DMA_TRANS_SIZE_MT6577,
> +	.max_read_len = MAX_DMA_TRANS_SIZE_MT6577,
> +	.max_comb_1st_msg_len = MAX_DMA_TRANS_SIZE_MT6577,
> +	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT6577,
> +};

I would think plain numbers are much more readable than defines here.
They are used only once, too.

> +static const struct of_device_id mtk_i2c_of_match[] = {
> +	{ .compatible = "mediatek,mt6577-i2c", .data = (void *)&mt6577_compat },
> +	{ .compatible = "mediatek,mt6589-i2c", .data = (void *)&mt6589_compat },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);

No need for casts.

> +static inline void mtk_i2c_writew(u16 value, struct mtk_i2c *i2c, u8 offset)
> +{
> +	writew(value, i2c->base + offset);
> +}
> +
> +static inline u16 mtk_i2c_readw(struct mtk_i2c *i2c, u8 offset)
> +{
> +	return readw(i2c->base + offset);
> +}

I am not a big fan of such extremly thin wrappers, but if you like them...

> +		rpaddr = dma_map_single(i2c->adap.dev.parent, msgs->buf,
> +						msgs->len, DMA_FROM_DEVICE);

I think you shouldn't use the adapter device here and later, but the dma
channel device.

> +	/* flush before sending start */
> +	mb();
> +	mtk_i2c_writel_dma(I2C_DMA_START_EN, i2c, OFFSET_EN);

Is mb() really needed when you use writel after that?

> +	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
> +		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
> +		mtk_i2c_init_hw(i2c);
> +		return -EREMOTEIO;

-ENXIO. Please check Documentation/i2c/fault-codes for a reference and
check all your error values.

> +	ret = of_property_read_u32(np, "clock-div", clk_src_div);
> +	if (ret < 0)
> +		return ret;

Do we need a property for that in the i2c-block? Can't the clock
provider driver deliver a properly divided clock already?


And cppcheck says:

drivers/i2c/busses/i2c-mt65xx.c:133: style: struct or union member 'mtk_i2c_data::clk_frequency' is never used.
drivers/i2c/busses/i2c-mt65xx.c:135: style: struct or union member 'mtk_i2c_data::clk_src_div' is never used.

Rest looks good, thanks!


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUfj4AAoJEBQN5MwUoCm2jwAQAKRdCzMD9b22lxoyOCaSEsuN
u16KVoeBLkARmRt55AVUjiBb8Qp+Q5Am/YpVktssltM/mxmeNeuBN8YDbpv4uWZ2
t0+7yNb1TWZEFWEE5JuEB8YvZ7qn+xjFSdFi1eHNgiTmUxzmGje3PhqnWx+BQH6T
B6eXyYu0jSafo1ADme81CiFA0KdRP84zZ3H9n62NhnpCNf7g9GHTBZ1T1wU+lco/
gcTA0qCx0uc4MpnCXsgYMuBsTj47417RbMNbWN8PWphcqsxfnrPqtsdmDel/9mFj
bQzA41z0lqwgQepVHMyEZStf8nG637dAcn79W+8AdhG4eIMGITEpd+mGcGPE7QY0
ncZNGIkgNDndWl45QwYHAadLO4/SattHmsb7cWDDkThPZ0fPYtn/k2He1ofU3a0z
r/cQ0yaw1ucNeYUDXbWESkkL4IA2P9a5CdvnZXHem4yW4SiWU8vJ+4+TWT6WaVjl
jIBP7wkIbzl6SNsCoBQvjViYeTj6LyTlLwZt9Ug88D+HqAK6xEDAqgQm2GM1XQu6
3svTkz1gFmM7/9ZSB6TtDPUJ10Yy6EneS5Wr+FSyiDzuVh1J/ImydDN8+95FFfYu
Ws0jfT55JgbidsvYfyiIa0uWQ1rVBjg/z4bXh4SVhabmlAoEYVTeFus2x1UTvIzH
Y32El/xo9UmF4aOrPOwK
=RKXb
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
