From: jacopo mondi <jacopo@jmondi.org>
Subject: Re: [RFT] i2c: sh_mobile: let RuntimePM do the clock handling
Date: Wed, 8 Nov 2017 19:41:53 +0100
Message-ID: <20171108184153.GC26922@w540>
References: <20171108085037.1318-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171108085037.1318-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Nov 08, 2017 at 09:50:37AM +0100, Wolfram Sang wrote:
> No need to do it manually.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> jacopo: can you test this on Migo-R, please, on top of the other I2C patches?

Done.

No appreciable differences with this patch applied, the image sensor
is properly detected and I can grab an image.

For this one as well:
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
   j
>
> I tested it on a Lager and it worked there. Will try Gen3 later, too.
>
>  drivers/i2c/busses/i2c-sh_mobile.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index ebd146ccb24465..80561ffbcf7b46 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -702,7 +702,6 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
>
>  	/* Wake up device and enable clock */
>  	pm_runtime_get_sync(pd->dev);
> -	clk_prepare_enable(pd->clk);
>
>  	/* Process all messages */
>  	for (i = 0; i < num; i++) {
> @@ -743,7 +742,6 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
>  	iic_wr(pd, ICCR, 0);
>
>  	/* Disable clock and mark device as idle */
> -	clk_disable_unprepare(pd->clk);
>  	pm_runtime_put_sync(pd->dev);
>
>  	return err ?: num;
> --
> 2.11.0
>
