From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/4] i2c: designware: add i2c gpio recovery option
Date: Thu, 28 Sep 2017 13:58:41 +0300
Message-ID: <1506596321.16112.156.camel@linux.intel.com>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
         <1504073857-122449-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62630 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbdI1LHM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Sep 2017 07:07:12 -0400
In-Reply-To: <1504073857-122449-5-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On Wed, 2017-08-30 at 14:17 +0800, Phil Reid wrote:
> From: Tim Sander <tim@krieglstein.org>
> 
> This patch contains much input from Phil Reid and has been tested
> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
> SCL and SDA GPIO's. I am still a little unsure about the recover
> in the timeout case (i2c-designware-core.c:770) as i could not
> test this codepath.

 
> -	if (abort_source & DW_IC_TX_ARB_LOST)
> +	if (abort_source & DW_IC_TX_ARB_LOST) {
> +		i2c_recover_bus(&dev->adapter);
>  		return -EAGAIN;

> -	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
> +	} else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)

else is redundant.

>  		return -EINVAL; /* wrong msgs[] data */
>  	else

Ditto.

>  		return -EIO;

> +static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
> +{
> +	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
> +	struct i2c_adapter *adap = &dev->adapter;
> +	struct gpio_desc *gpio;
> +	int r;
> +
> +	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio)) {
> +		r = PTR_ERR(gpio);

> +		if ((r == -ENOENT) || (r == -ENOENT))

Copy'n'paste typo?

> +			return 0;
> +		return r;
> +	}
> +	rinfo->scl_gpiod = gpio;
> +
> +	gpio = devm_gpiod_get_optional(dev->dev, "sda", GPIOD_IN);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +	rinfo->sda_gpiod = gpio;
> +
> +	rinfo->recover_bus = i2c_generic_scl_recovery;
> +	rinfo->prepare_recovery = i2c_dw_prepare_recovery;
> +	rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
> +	adap->bus_recovery_info = rinfo;
> +

> +	dev_info(dev->dev,
> +		"adapter: %s running with gpio recovery mode! scl:%i
> sda:%i\n",
> +		adap->name, !!rinfo->scl_gpiod, !!rinfo->sda_gpiod);

Instead of doing numbers, better just to list available descriptors,
e.g.

...("... %s scl\n", rinfo->sda_gpiod ? "sda,");

No need to explain that scl doesn't need any check here.

And I'm not sure why do you need adap->name here. Can you show an
example of output from your test platform?

> +	if (!ret)
> +		ret = i2c_dw_init_recovery_info(dev);

Better to 
if (ret)
 return ret;

return i2c...();

> +
>  	return ret;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
