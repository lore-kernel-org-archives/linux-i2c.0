From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2] i2c: at91: ensure state is restored after suspending
Date: Fri, 17 Feb 2017 09:24:39 +0100
Message-ID: <20170217082439.mcfxoccwiwoj5ako@rfolt0960.corp.atmel.com>
References: <20170216172759.27837-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170216172759.27837-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 16, 2017 at 06:27:59PM +0100, Alexandre Belloni wrote:
> When going to suspend, the I2C registers may be lost because the power to
> VDDcore is cut. Restore them when resuming.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
> Changes in v2:
>  - don't cache unecessary registers and simply call at91_init_twi_bus()
> 
> 
>  drivers/i2c/busses/i2c-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 0b86c6173e07..c925a690cb32 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1180,6 +1180,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
>  
>  static int at91_twi_resume_noirq(struct device *dev)
>  {
> +	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
>  	int ret;
>  
>  	if (!pm_runtime_status_suspended(dev)) {
> @@ -1191,6 +1192,8 @@ static int at91_twi_resume_noirq(struct device *dev)
>  	pm_runtime_mark_last_busy(dev);
>  	pm_request_autosuspend(dev);
>  
> +	at91_init_twi_bus(twi_dev);
> +
>  	return 0;
>  }
>  
> -- 
> 2.11.0
> 
