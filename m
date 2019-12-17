From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 06/10] mfd: Add core driver for AD242x A2B
 transceivers
Date: Tue, 17 Dec 2019 13:16:04 -0600
Message-ID: <c3885b01-e6ec-1b67-6e48-69e3fc40bb62@linux.intel.com>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-8-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209183511.3576038-8-daniel@zonque.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org
List-Id: linux-i2c@vger.kernel.org


> +config MFD_AD242X
> +	bool "Analog Devices AD242x A2B support"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C=y && OF

is there a specific reason why I2C needs to be built-in (as opposed to 'm')?

> +/* See Table 3-2 in the datasheet */

is the datasheet public? I thought it was only available under NDA.

> +	master->sync_clk = devm_clk_get(dev, "sync");
> +	if (IS_ERR(master->sync_clk)) {
> +		ret = PTR_ERR(master->sync_clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get sync clk: %d\n", ret);
> +
> +		return ret;
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "clock-frequency",
> +				 &master->sync_clk_rate)) {
> +		ret = clk_set_rate(master->sync_clk, master->sync_clk_rate);

shouldn't you check the rate before setting it?

> +		if (ret < 0) {
> +			dev_err(dev, "Cannot set sync clock rate: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	master->sync_clk_rate = clk_get_rate(master->sync_clk);
> +	if (master->sync_clk_rate != 44100 && master->sync_clk_rate != 48000) {
> +		dev_err(dev, "SYNC clock rate %d is invalid\n",
> +			master->sync_clk_rate);
> +		return -EINVAL;
> +	}

this is a bit odd, you set the rate in case there is a property but get 
it anyways. the last block could be an else?

> +
> +	ret = clk_prepare_enable(master->sync_clk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable sync clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Master node setup */
> +
> +	ret = regmap_write(regmap, AD242X_CONTROL,
> +			   AD242X_CONTROL_MSTR | AD242X_CONTROL_SOFTRST);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad242x_wait_for_irq(master, &master->run_completion, 10);

what is 10?


> +static int ad242x_master_remove(struct i2c_client *i2c)
> +{
> +	struct ad242x_master *master = i2c_get_clientdata(i2c);
> +
> +	if (master->sync_clk)
> +		clk_disable_unprepare(master->sync_clk);

earlier you tested for IS_ERR(master->sync_clk)?

> +	for (i = 0; i < 4; i++) {

what is 4? 4 hops?
