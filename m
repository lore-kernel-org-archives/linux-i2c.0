From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/5] I2C: DaVinci: remove useless IVR read
Date: Thu, 27 Mar 2008 16:56:41 +0100
Message-ID: <20080327165641.4380a7f1@hyperion.delvare>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-3-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-4-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1206068770-15458-4-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 20 Mar 2008 20:06:08 -0700, Troy Kisky wrote:
> Interrupts are enabled at the point where
> the DAVINCI_I2C_IVR_REG is read, so unless
> an interrupt happened just at that moment,
> no interrupt would be pending. Even though
> documentation implies you should do this,
> I see no reason. If slave support is added,
> this read would cause a hard to reproduce bug.

This is only a problem if the device can operate in master mode and
slave mode concurrently. Is it the case? But even then, as you can't
have master and slave activity going on at the same time on a given I2C
bus, it only matters if some DaVinci boards have more than one i2c
buses. Is it the case?

I have to admit that I am a bit reluctant to remove this register read
if the documentation says it should be there. But if nobody objects I
can take this patch for 2.6.26.

> 
> Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 82d4b7f..da54fff 100755
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -240,7 +240,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
>  	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
>  	u32 flag;
> -	u32 stat;
>  	u16 w;
>  	int r;
>  
> @@ -264,9 +263,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	init_completion(&dev->cmd_complete);
>  	dev->cmd_err = 0;
>  
> -	/* Clear any pending interrupts by reading the IVR */
> -	stat = davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG);
> -
>  	/* Take I2C out of reset, configure it as master and set the
>  	 * start bit */
>  	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST | DAVINCI_I2C_MDR_STT;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
