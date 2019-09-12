From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/3] i2c: bcm2835: Avoid clk stretch quirk for BCM2711
Date: Thu, 12 Sep 2019 19:21:02 +0200
Message-ID: <c43878d8-e7d0-bc13-107b-2b6045692504@gmail.com>
References: <1566925456-5928-1-git-send-email-wahrenst@gmx.net>
 <1566925456-5928-3-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566925456-5928-3-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Wolfram Sang <wsa@the-dreams.de>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 27/08/2019 19:04, Stefan Wahren wrote:
> The I2C block on the BCM2711 isn't affected by the clk stretching bug.
> So there is no need to apply the corresponding quirk.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 67752f7..ab5502f 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> 
> @@ -389,7 +390,7 @@ static const struct i2c_algorithm bcm2835_i2c_algo = {
>  };
> 
>  /*
> - * This HW was reported to have problems with clock stretching:
> + * The BCM2835 was reported to have problems with clock stretching:
>   * http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
>   * https://www.raspberrypi.org/forums/viewtopic.php?p=146272
>   */
> @@ -475,7 +476,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  	adap->algo = &bcm2835_i2c_algo;
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
> -	adap->quirks = &bcm2835_i2c_quirks;
> +	adap->quirks = of_device_get_match_data(&pdev->dev);
> 
>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
> 
> @@ -501,7 +502,8 @@ static int bcm2835_i2c_remove(struct platform_device *pdev)
>  }
> 
>  static const struct of_device_id bcm2835_i2c_of_match[] = {
> -	{ .compatible = "brcm,bcm2835-i2c" },
> +	{ .compatible = "brcm,bcm2711-i2c" },
> +	{ .compatible = "brcm,bcm2835-i2c", .data = &bcm2835_i2c_quirks },

RPi4 FW seems to still use bcm2835-i2c as compatible in it's DTB blob. Does this
break the driver or is this something we can improve by changing the FW blob in
the future without breaking the driver now?

Regards,
Matthias

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, bcm2835_i2c_of_match);
> --
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
