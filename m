From: boris brezillon <b.brezillon@overkiz.com>
Subject: Re: [PATCH] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Fri, 22 Nov 2013 16:01:17 +0100
Message-ID: <528F71BD.2080407@overkiz.com>
References: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ludovic.desroches@atmel.com, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Ludovic,

On 22/11/2013 15:07, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> There are still I2C unexpected behaviors which are solved by reducing TWI
> internal frequency.

I guess I should do the same for the dt version of sama5 clks.
Nicolas, what do you think ?

Best Regards,

Boris

>
> Cc: <stable@vger.kernel.org> #3.10+
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>   arch/arm/mach-at91/sama5d3.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> index 4012797..4ee0de5 100644
> --- a/arch/arm/mach-at91/sama5d3.c
> +++ b/arch/arm/mach-at91/sama5d3.c
> @@ -95,19 +95,19 @@ static struct clk twi0_clk = {
>   	.name		= "twi0_clk",
>   	.pid		= SAMA5D3_ID_TWI0,
>   	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>   };
>   static struct clk twi1_clk = {
>   	.name		= "twi1_clk",
>   	.pid		= SAMA5D3_ID_TWI1,
>   	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>   };
>   static struct clk twi2_clk = {
>   	.name		= "twi2_clk",
>   	.pid		= SAMA5D3_ID_TWI2,
>   	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>   };
>   static struct clk mmc0_clk = {
>   	.name		= "mci0_clk",
>
