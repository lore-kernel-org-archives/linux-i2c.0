From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch v1] i2c: imx: add runtime pm support to improve the performance
Date: Thu, 11 Jun 2015 14:59:24 +0530
Message-ID: <CAM=Q2cuEChJySEex99e_xqfgXORZxDHqpGve7hbh-+nQVYPxAg@mail.gmail.com>
References: <1433987404-28957-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433987404-28957-1-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 11, 2015 at 7:20 AM, Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> In our former i2c driver, i2c clk is enabled and disabled in
> xfer function, which contributes to power saving. However,
> the clk enable process brings a busy wait delay until the core
> is stable. As a result, the performance is sacrificed.
>
> To weigh the power consuption and i2c bus performance, runtime
> pm is the good solution for it. The clk is enabled when a i2c
> transfer starts, and disabled afer a specifically defined delay.
>
> Without the patch the test case (many eeprom reads) executes with approx:
> real 1m7.735s
> user 0m0.488s
> sys 0m20.040s
>
> With the patch the same test case (many eeprom reads) executes with approx:
> real 0m54.241s
> user 0m0.440s
> sys 0m5.920s
>
> From the test result, the patch get better performance.
>
> Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-imx.c | 78 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 785aa67..cc4b5d6 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -53,6 +53,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>
>  /** Defines ********************************************************************
>  *******************************************************************************/
> @@ -118,6 +119,8 @@
>  #define I2CR_IEN_OPCODE_0      0x0
>  #define I2CR_IEN_OPCODE_1      I2CR_IEN
>
> +#define I2C_PM_TIMEOUT         10 /* ms */
> +
>  /** Variables ******************************************************************
>  *******************************************************************************/
>
> @@ -520,9 +523,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>
>         i2c_imx_set_clk(i2c_imx);
>
> -       result = clk_prepare_enable(i2c_imx->clk);
> -       if (result)
> -               return result;
>         imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
>         /* Enable I2C controller */
>         imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
> @@ -575,7 +575,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>         /* Disable I2C controller */
>         temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
>         imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> -       clk_disable_unprepare(i2c_imx->clk);
>  }
>
>  static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
> @@ -583,6 +582,9 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>         struct imx_i2c_struct *i2c_imx = dev_id;
>         unsigned int temp;
>
> +       if (pm_runtime_suspended(i2c_imx->adapter.dev.parent))
> +               return IRQ_NONE;
> +

Didn't quite get this one.
