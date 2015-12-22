From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Tue, 22 Dec 2015 14:51:13 -0600
Message-ID: <5679B7C1.6010408@amd.com>
References: <1450319025-19120-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151218101348.GG1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0067.outbound.protection.outlook.com ([207.46.100.67]:36891
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933323AbbLVUvW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 22 Dec 2015 15:51:22 -0500
In-Reply-To: <20151218101348.GG1762@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mika,

On 12/18/2015 4:13 AM, Mika Westerberg wrote:
> [....]
> So instead of this, what if we do not assign dev->get_clk_rate_khz at
> all and then do something like below in the core driver?

I like the changes below since it is clear to see within the core file 
how things are handled when get_clk_rate_khz is not assigned (i.e. 
input_clock_hz = 0), and not necessary relying on the platform driver to 
return 0 in this case.

So, at this point, I can re-submit the V3 and combine these changes, and 
we both can sign-off. How does that sound?

Thanks,
Suravee

> Of course we still need the other changes you did in this patch to cope
> with the missing clock.
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 8c48b27ba059..25dccd8df772 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -271,6 +271,17 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
>   		 enable ? "en" : "dis");
>   }
>
> +static unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
> +{
> +	/*
> +	 * Clock is not necessary if we got LCNT/HCNT values directly from
> +	 * the platform code.
> +	 */
> +	if (WARN_ON_ONCE(!dev->get_clk_rate_khz))
> +		return 0;
> +	return dev->get_clk_rate_khz(dev);
> +}
> +
>   /**
>    * i2c_dw_init() - initialize the designware i2c master hardware
>    * @dev: device private data
> @@ -281,7 +292,6 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
>    */
>   int i2c_dw_init(struct dw_i2c_dev *dev)
>   {
> -	u32 input_clock_khz;
>   	u32 hcnt, lcnt;
>   	u32 reg;
>   	u32 sda_falling_time, scl_falling_time;
> @@ -295,8 +305,6 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>   		}
>   	}
>
> -	input_clock_khz = dev->get_clk_rate_khz(dev);
> -
>   	reg = dw_readl(dev, DW_IC_COMP_TYPE);
>   	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
>   		/* Configure register endianess access */
> @@ -325,12 +333,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>   		hcnt = dev->ss_hcnt;
>   		lcnt = dev->ss_lcnt;
>   	} else {
> -		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
> +		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
>   					4000,	/* tHD;STA = tHIGH = 4.0 us */
>   					sda_falling_time,
>   					0,	/* 0: DW default, 1: Ideal */
>   					0);	/* No offset */
> -		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
> +		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
>   					4700,	/* tLOW = 4.7 us */
>   					scl_falling_time,
>   					0);	/* No offset */
> @@ -344,12 +352,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>   		hcnt = dev->fs_hcnt;
>   		lcnt = dev->fs_lcnt;
>   	} else {
> -		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
> +		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
>   					600,	/* tHD;STA = tHIGH = 0.6 us */
>   					sda_falling_time,
>   					0,	/* 0: DW default, 1: Ideal */
>   					0);	/* No offset */
> -		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
> +		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
>   					1300,	/* tLOW = 1.3 us */
>   					scl_falling_time,
>   					0);	/* No offset */
>
