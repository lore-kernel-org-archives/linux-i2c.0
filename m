From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: make *CNT values configurable
Date: Thu, 26 Oct 2017 17:16:07 +0300
Message-ID: <4ddeadd3-aa31-87f4-cd8d-ddf2132edb49@linux.intel.com>
References: <20171025185022.GA25920@sjc-ads-4188.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:34119 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbdJZOUd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Oct 2017 10:20:33 -0400
In-Reply-To: <20171025185022.GA25920@sjc-ads-4188.cisco.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shikhar Dogra <shidogra@cisco.com>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com

Hi

On 10/25/2017 09:50 PM, Shikhar Dogra wrote:
> The values are already configurable from ACPI.
> 
> This patch makes the high count (HCNT) and low count (LCNT)
> register values configurable through device tree.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Shikhar Dogra <shidogra@cisco.com>
> ---
>   Documentation/devicetree/bindings/i2c/i2c-designware.txt | 16 ++++++++++++++++
>   drivers/i2c/busses/i2c-designware-platdrv.c              | 12 ++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fee26dc..2b9ddca 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,6 +20,18 @@ Optional properties :
>    - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>      This value which is by default 300ns is used to compute the tHIGH period.
>   
> + - i2c-ss-hcnt : should contain the I2C controller standard speed HCNT value.
> +   If this is not set we use the calculated and more conservative values.
> +
> + - i2c-ss-lcnt : should contain the I2C controller standard speed LCNT value.
> +   If this is not set we use the calculated and more conservative values.
> +
> + - i2c-fs-hcnt : should contain the I2C controller fast speed HCNT value.
> +   If this is not set we use the calculated and more conservative values.
> +
> + - i2c-fs-lcnt : should contain the I2C controller fast speed LCNT value.
> +   If this is not set we use the calculated and more conservative values.
> +

Worth to add also properties for high-speed while at it.

Out of curiosity, are calculated values by using 
"i2c-sda-falling-time-ns" and "i2c-scl-falling-time-ns" properties 
non-optimal on your platform and controller clock?

> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 6b00061c..25c3b0c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -177,6 +177,18 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>   		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>   				     &clk_freq);
>   
> +		of_property_read_u16(pdev->dev.of_node,
> +				     "i2c-ss-hcnt", &dev->ss_hcnt);
> +

This patch is against old kernel. These were converted near 2 years ago 
by the commit 4c5301abbf81 ("i2c: designware: Convert to use unified 
device property API")

-- 
Jarkko
