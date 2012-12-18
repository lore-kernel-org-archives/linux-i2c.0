From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
Date: Tue, 18 Dec 2012 07:02:32 +0100
Message-ID: <20121218060232.GL23971@game.jcrosoft.org>
References: <1354743732-11581-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1354743732-11581-1-git-send-email-manabian@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: ludovic.desroches@atmel.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 22:42 Wed 05 Dec     , Joachim Eastwood wrote:
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hi,
> 
> AT91RM9200 is gaining DT support now so let's add an id to the i2c driver.
> 
> Tested on custom RM9200 board. Since the driver doesn't support pinctrl
> muxing yet I had to add pinctrl hogs for the i2c pins in my dts for it
> to work.

IIRC the i2c IP have quite a lots of issue on rm9200 and until sam9g45

it not recommended to use it instead use i2c-gpio

Best Regards,
J.
> 
> regards
> Joachim Eastwood
> 
>  drivers/i2c/busses/i2c-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index b4575ee..c504aa8 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -584,6 +584,9 @@ static const struct platform_device_id at91_twi_devtypes[] = {
>  #if defined(CONFIG_OF)
>  static const struct of_device_id atmel_twi_dt_ids[] = {
>  	{
> +		.compatible = "atmel,at91rm9200-i2c",
> +		.data = &at91rm9200_config,
> +	} , {
>  		.compatible = "atmel,at91sam9260-i2c",
>  		.data = &at91sam9260_config,
>  	} , {
> -- 
> 1.8.0
> 
