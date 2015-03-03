From: Christian Ruppert <christian.ruppert@alitech.com>
Subject: Re: [PATCH] i2c: designware: Suppress error message if platform_get_irq()
 returns -EPROBE_DEFER
Date: Tue, 03 Mar 2015 17:28:16 +0100
Message-ID: <54F5E120.3090705@alitech.com>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Christian Ruppert <christian.ruppert@abilis.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On 2015-03-03 16:27, Alexey Brodkin wrote:
> There's no point in printing error message if platform_get_irq()
> returns -EPROBE_DEFER because probe deferring subsystem already outputs
> message in bootlog like this:
>  --->8---
>  platform e001d000.i2c: Driver i2c_designware requests probe deferral
>  --->8---
> 
> Moreover in case of probe deferral following message may mislead user:
>  --->8---
>  i2c_designware e001d000.i2c: no irq resource?
>  --->8---
> even though it's expected that platform_get_irq() may return
> -EPROBE_DEFER.
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Christian Ruppert <christian.ruppert@abilis.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index c270f5f..01c1b17 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -144,7 +144,8 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "no irq resource?\n");

Presented like this I wonder if this merits being a dev_err at all.
Wouldn't dev_dbg be more adequate? This might remove the need for the
condition and also avoid bothering everyone if something in the platform
device structures or device tree is not right.

>  		return irq; /* -ENXIO */
>  	}
>  
> 
