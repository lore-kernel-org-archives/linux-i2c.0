From: Daniel Mack <daniel@zonque.org>
Subject: Re: [alsa-devel] [PATCH 06/10] mfd: Add core driver for AD242x A2B
 transceivers
Date: Wed, 18 Dec 2019 10:40:54 +0100
Message-ID: <96d1182a-d9ba-78ce-c483-6be5389e3aba@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-8-daniel@zonque.org>
 <c3885b01-e6ec-1b67-6e48-69e3fc40bb62@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c3885b01-e6ec-1b67-6e48-69e3fc40bb62@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org
List-Id: linux-i2c@vger.kernel.org

Hi Pierre,

Thanks for looking into this!

On 12/17/19 8:16 PM, Pierre-Louis Bossart wrote:
> is the datasheet public? I thought it was only available under NDA.

It was until recently, but it is now public:


https://www.analog.com/media/en/technical-documentation/user-guides/AD242x_TRM_Rev1.1.pdf

>> +    master->sync_clk = devm_clk_get(dev, "sync");
>> +    if (IS_ERR(master->sync_clk)) {
>> +        ret = PTR_ERR(master->sync_clk);
>> +        if (ret != -EPROBE_DEFER)
>> +            dev_err(dev, "failed to get sync clk: %d\n", ret);
>> +
>> +        return ret;
>> +    }
>> +
>> +    if (of_property_read_u32(dev->of_node, "clock-frequency",
>> +                 &master->sync_clk_rate)) {
>> +        ret = clk_set_rate(master->sync_clk, master->sync_clk_rate);
> 
> shouldn't you check the rate before setting it?
>
>> +        if (ret < 0) {
>> +            dev_err(dev, "Cannot set sync clock rate: %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    master->sync_clk_rate = clk_get_rate(master->sync_clk);
>> +    if (master->sync_clk_rate != 44100 && master->sync_clk_rate !=
>> 48000) {
>> +        dev_err(dev, "SYNC clock rate %d is invalid\n",
>> +            master->sync_clk_rate);
>> +        return -EINVAL;
>> +    }
> 
> this is a bit odd, you set the rate in case there is a property but get
> it anyways. the last block could be an else?

The idea is: if 'clock-frequency' is given, we use it to set the clock,
otherwise we rely on the clock having one of the two allowed rates. This
way, we also catch setups where the clock provider cannot generated the
desired frequency, or where the value of 'clock-frequency' is illegal.

>> +    ret = clk_prepare_enable(master->sync_clk);
>> +    if (ret < 0) {
>> +        dev_err(dev, "failed to enable sync clk: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /* Master node setup */
>> +
>> +    ret = regmap_write(regmap, AD242X_CONTROL,
>> +               AD242X_CONTROL_MSTR | AD242X_CONTROL_SOFTRST);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    ret = ad242x_wait_for_irq(master, &master->run_completion, 10);
> 
> what is 10?

Milliseconds. The parameter needs to get a better name I figure.


Thanks,
Daniel
