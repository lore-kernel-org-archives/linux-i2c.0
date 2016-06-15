From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 1/3] i2c: designware-pci: Make bus number allocation
 robust
Date: Wed, 15 Jun 2016 16:42:54 +0300
Message-ID: <f2466d99-ca2d-127c-ae90-54ec8a1ae25c@linux.intel.com>
References: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17836 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899AbcFONm5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 09:42:57 -0400
In-Reply-To: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On 06/15/2016 01:55 AM, Andy Shevchenko wrote:
> On some platforms, such as Intel Medfield, the I2C slave devices are enumerated
> through SFI tables where bus numbering is expected to be defined in the OS.
> Make the bus number allocation robust for such platforms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 84 ++++++++++++------------------
>  1 file changed, 34 insertions(+), 50 deletions(-)
...
> -	[medfield_3] = {
> -		.bus_num     = 3,
> -		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> -		.tx_fifo_depth = 32,
> -		.rx_fifo_depth = 32,
> -		.clk_khz      = 25000,
> -	},
> -	[medfield_4] = {
> -		.bus_num     = 4,
> -		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
> -		.tx_fifo_depth = 32,
> -		.rx_fifo_depth = 32,
> -		.clk_khz      = 25000,
> -	},
> -	[medfield_5] = {
> -		.bus_num     = 5,
> +	[medfield] = {
> +		.bus_num = -1,
>  		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
>  		.tx_fifo_depth = 32,
>  		.rx_fifo_depth = 32,
>  		.clk_khz      = 25000,
> +		.setup = mfld_setup,

Now bus 3 speed is pumped up to fast speed. Can it cause problems?

-- 
Jarkko
