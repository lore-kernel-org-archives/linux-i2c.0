From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c-next v5 2/5] i2c: Add support for 'timeout-ms' and
 '#retries' OF properties
Date: Thu, 4 Oct 2018 09:26:02 -0700
Message-ID: <1832adbf-fa95-ccfc-00e5-63568059bcd1@linux.intel.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
 <20181003223107.16133-3-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003223107.16133-3-jae.hyun.yoo@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1214,6 +1214,7 @@ EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
>   static int i2c_register_adapter(struct i2c_adapter *adap)
>   {
>   	int res = -EINVAL;
> +	u32 timeout_ms;

Will change it to:

u32 timeout_ms = 0;

>   
>   	/* Can't register until after driver model init */
>   	if (WARN_ON(!is_registered)) {
> @@ -1239,8 +1240,21 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>   	INIT_LIST_HEAD(&adap->userspace_clients);
>   
>   	/* Set default timeout to 1 second if not already set */
> -	if (adap->timeout == 0)
> -		adap->timeout = HZ;
> +	if (adap->timeout == 0) {
> +		if (adap->dev.of_node)
> +			res = of_property_read_u32(adap->dev.of_node,
> +						   "timeout-ms",
> +						   &timeout_ms);
> +		if (res)
> +			timeout_ms = 0;
> +

Also, it should be:

if (adap->dev.of_node)
	of_property_read_u32(adap->dev.of_node, "timeout-ms",
			     &timeout_ms);

Will submit a new patch set.

Thanks,
Jae

> +		adap->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : HZ;
> +	}
> +
> +	/* Set retries value if it has the OF property */
> +	if (adap->dev.of_node)
> +		of_property_read_u32(adap->dev.of_node, "#retries",
> +				     &adap->retries);
>   
>   	/* register soft irqs for Host Notify */
>   	res = i2c_setup_host_notify_irq_domain(adap);
> 
