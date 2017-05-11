From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix false warning from
 i2c_dw_clk_rate()
Date: Thu, 11 May 2017 17:00:49 +0300
Message-ID: <1494511249.6967.11.camel@linux.intel.com>
References: <20170511124949.26650-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4238 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933109AbdEKOAz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 11 May 2017 10:00:55 -0400
In-Reply-To: <20170511124949.26650-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Thu, 2017-05-11 at 15:49 +0300, Jarkko Nikula wrote:
> Commit bd698d24b1b5 ("i2c: designware: Get selected speed mode
> sda-hold-time via ACPI") causes a false warning from i2c_dw_clk_rate()
> in case platform doesn't provide explicit input clock but provides
> valid
> SCL timing parameters via ACPI.
> 
> After above commit timing parameters only for the selected speed is
> get
> but code in i2c_dw_init() tries to calculate missing parameters using
> the input clock which leads to a warning when there is no input clock
> defined.
> 
> Fix this by reordering the code such a way that timing parameters
> validation/calculation and setting is done for the selected speed
> only.
> While at it do the calculation only once during the first call.

> +static void i2c_dw_set_timings(struct dw_i2c_dev *dev)
> +{
> +	u32 reg;
> +
> +	/* set standard and fast speed deviders for high/low periods
> */
> +	dev->sda_falling_time = dev->sda_falling_time ?: 300; /* ns
> */
> +	dev->scl_falling_time = dev->scl_falling_time ?: 300; /* ns
> */
> +
> +	switch (dev->master_cfg & DW_IC_CON_SPEED_MASK) {
> +	case DW_IC_CON_SPEED_STD:
> +		i2c_dw_set_timings_sm(dev);
> +		break;
> +	case DW_IC_CON_SPEED_FAST:
> +		i2c_dw_set_timings_fm(dev);
> +		break;
> +	case DW_IC_CON_SPEED_HIGH:
> +		i2c_dw_set_timings_hsm(dev);
> +		break;
>  	}

I would put same suffixes to the helper functions, i.e.
_sm -> _std
_fm -> _fast
_hsm-> _high

> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
