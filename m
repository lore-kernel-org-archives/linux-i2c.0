From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 1/2] i2c: designware: Make master module optional
Date: Wed, 25 Mar 2020 09:47:47 +0200
Message-ID: <c3d2d5ff-605a-bdb7-275b-872fdfd10ccd@linux.intel.com>
References: <20200323100451.28808-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26435 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgCYHru (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Mar 2020 03:47:50 -0400
In-Reply-To: <20200323100451.28808-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

On 3/23/20 12:04 PM, Andy Shevchenko wrote:
> In some cases we know that the controller will be always used in slave mode and
> master is just a bulk. In order to drop that, introduce a separate configuration
> parameter for master mode. Default it to core to avoid regressions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/i2c/busses/Kconfig                  | 10 ++++++++++
>   drivers/i2c/busses/Makefile                 |  5 ++++-
>   drivers/i2c/busses/i2c-designware-core.h    | 19 ++++++++++++++++++-
>   drivers/i2c/busses/i2c-designware-master.c  |  4 ++--
>   drivers/i2c/busses/i2c-designware-pcidrv.c  |  2 +-
>   drivers/i2c/busses/i2c-designware-platdrv.c |  6 +-----
>   6 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ddca08f8a76..1df238ff8dd0 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -527,6 +527,16 @@ config I2C_DAVINCI
>   config I2C_DESIGNWARE_CORE
>   	tristate
>   
> +config I2C_DESIGNWARE_MASTER
> +	bool "Synopsys DesignWare Master"
> +	default I2C_DESIGNWARE_CORE
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Synopsys DesignWare I2C master adapter.
> +
> +	  This is not a standalone module, this module compiles together with
> +	  i2c-designware-core.
> +

I think we should go to a opposite direction - reduce the number of 
I2C_DESIGNWARE_ config options rather than add new ones. We already have 
5 config options for it.

Size of i2c-designware-core.ko is around 12 kB with all master, slave 
and Baytrail semaphore code built in so I don't think it justifies the 
added config complexity. I think distributions will have anyway all of 
those options set.

Having those code in separate modules and load only when needed might 
make sense as that would save a few kB of RAM.

-- 
Jarkko
