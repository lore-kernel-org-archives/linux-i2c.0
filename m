From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] i2c: at91: fix compilation issue due to header move
Date: Fri, 9 Nov 2012 14:23:48 +0100
Message-ID: <509D03E4.2040502@atmel.com>
References: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ludovic.desroches@atmel.com
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

Le 11/09/2012 11:11 AM, ludovic.desroches@atmel.com a =E9crit :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> arch/arm/mach-at91/include/mach/at_hdmac.h has been move to
> include/linux/platform_data/dma-atmel.h, commit 7cdc39e.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>
> Hi,
>
> This is a fix for 3.7.
>
> Regards
>
> Ludovic

Sorry don't take care about this patch, I'll put it into the dma patch =

I've to update.

I have it into my tree for a while, I've forgotten it is not yet included.

Sorry for the noise.

Regards

Ludovic

>
>   drivers/i2c/busses/i2c-at91.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index a9fbad8..e2e9837 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -32,7 +32,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>
> -#include <mach/at_hdmac.h>
> +#include <linux/platform_data/dma-atmel.h>
>
>   #define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
>   #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
>
