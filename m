From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Date: Thu, 13 Sep 2018 16:50:30 +0300
Message-ID: <d4ebb8a5-9e56-20c5-2bda-03ca2a40378e@linux.intel.com>
References: <20180913162132.17c9c2b3@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913162132.17c9c2b3@xhacker.debian>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 09/13/2018 11:21 AM, Jisheng Zhang wrote:
> On some platforms, the sda/scl pins are muxed with gpio functions, so
> they could be used for recovery. Select the gpio/default pin function
> when prepare/unprepare recovery.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> 
> since v1:
>   - use IS_ERR_OR_NULL
> 
>   drivers/i2c/busses/i2c-designware-core.h   |  3 +++
>   drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
...
> +	pinctrl = devm_pinctrl_get(dev->dev);
> +	if (PTR_ERR(pinctrl) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	if (!IS_ERR_OR_NULL(pinctrl)) {
> +		dev->pinctrl = pinctrl;
> +		s = pinctrl_lookup_state(pinctrl, PINCTRL_STATE_DEFAULT);
> +		if (!IS_ERR_OR_NULL(s))
> +			dev->pins_default = s;
> +		s = pinctrl_lookup_state(pinctrl, "gpio");
> +		if (!IS_ERR_OR_NULL(s))
> +			dev->pins_gpio = s;
> +	}
> +

Should these be documented in 
Documentation/devicetree/bindings/i2c/i2c-designware.txt?

-- 
Jarkko
