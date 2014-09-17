From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Intel BayTrail PMIC I2C bus support
Date: Wed, 17 Sep 2014 12:02:02 +0100
Message-ID: <20140917120202.3b9058ae@alan.etchedpixels.co.uk>
References: <1410543367-6565-1-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410543367-6565-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 12 Sep 2014 10:36:07 -0700
"David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> +#if IS_ENABLED(CONFIG_I2C_SHARED_CONTROLLER)
> +extern int i2c_acquire_ownership(struct device *dev);
> +extern int i2c_release_ownership(struct device *dev);
> +#endif

You can just have the prototypes anyway - no need for more ifdefs than
required


> +#if IS_ENABLED(CONFIG_I2C_SHARED_CONTROLLER)
> +int i2c_shared_controller_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> +	int num)
> +{
> +	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
> +	int err;
> +
> +	if (dev->shared_host) {
> +		err = dev->acquire_ownership(dev->dev);
> +		if (!err) {
> +			err = i2c_dw_xfer(adap, msgs, num);
> +			dev->release_ownership(dev->dev);
> +		} else
> +			dev_WARN(dev->dev, "couldnt acquire ownership\n");
> +
> +		return err;
> +	} else
> +		return i2c_dw_xfer(adap, msgs, num);
> +}
> +
> +static struct i2c_algorithm i2c_sc_algo = {
> +	.master_xfer	= i2c_shared_controller_xfer,
> +	.functionality	= i2c_dw_func,
> +};
> +#endif

I think this might be a lot cleaner if you put these pieces as functions
into i2c-designware-sem.c or a similar file and made the methods NULL
functions in the header in the case it's not supported ? Most of the
ifdeffery would then vanish into the extra file and keep the core code
cleaner ?


Alan
