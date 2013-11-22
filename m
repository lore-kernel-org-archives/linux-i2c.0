From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v2] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Fri, 22 Nov 2013 19:31:23 +0100
Message-ID: <20131122183123.GM14627@ns203013.ovh.net>
References: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ludovic.desroches@atmel.com
Cc: nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 17:08 Fri 22 Nov     , ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> With some devices, transfer hangs during I2C frame transmission. This issue
> disappears when reducing the internal frequency of the TWI IP. Even if it is
> indicated that internal clock max frequency is 66MHz, it seems we have
> oversampling on I2C signals making TWI believe that a transfer in progress
> is done.

so now the IP run a 16MHz

you could also mention that now we save power too

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> 
> This fix has no impact on the I2C bus frequency.
> 
> Cc: <stable@vger.kernel.org> #3.10+
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> 
> v2: update commit message
> 
>  arch/arm/mach-at91/sama5d3.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> index 4012797..4ee0de5 100644
> --- a/arch/arm/mach-at91/sama5d3.c
> +++ b/arch/arm/mach-at91/sama5d3.c
> @@ -95,19 +95,19 @@ static struct clk twi0_clk = {
>  	.name		= "twi0_clk",
>  	.pid		= SAMA5D3_ID_TWI0,
>  	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>  };
>  static struct clk twi1_clk = {
>  	.name		= "twi1_clk",
>  	.pid		= SAMA5D3_ID_TWI1,
>  	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>  };
>  static struct clk twi2_clk = {
>  	.name		= "twi2_clk",
>  	.pid		= SAMA5D3_ID_TWI2,
>  	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>  };
>  static struct clk mmc0_clk = {
>  	.name		= "mci0_clk",
> -- 
> 1.7.9.5
> 
