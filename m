From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: balance clk enable/disable on removal
Date: Mon, 1 Feb 2016 16:21:07 +0200
Message-ID: <56AF69D3.4070300@linux.intel.com>
References: <1454106696-5867-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454106696-5867-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-i2c@vger.kernel.org

On 01/30/2016 12:31 AM, Alexey Khoroshilov wrote:
> It seems clk_disable_unprepare() is missed in dw_i2c_plat_remove(),
> so the patch adds it.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 438f1b4964c0..8f19b7b81fe0 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -267,6 +267,7 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
>   	i2c_del_adapter(&dev->adapter);
>
>   	i2c_dw_disable(dev);
> +	i2c_dw_plat_prepare_clk(dev, false);
>
I tried this quickly and it appears more work is needed. When 
CONFIG_PM_SLEEP is set then autosuspending will do the unprepare and 
this patch causes double unprepare at remove. But when CONFIG_PM_SLEEP 
is not set then indeed those clk calls are out of sync.

-- 
Jarkko
