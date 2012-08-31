From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 3/8] i2c: at91: use an id table for SoC dependent
 parameters
Date: Fri, 31 Aug 2012 16:29:44 +0200
Message-ID: <20120831142944.GA23867@game.jcrosoft.org>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com>
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
Cc: devicetree-discuss@lists.ozlabs.org, n.voss@weinmann.de, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 11:21 Fri 31 Aug     , ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Use the id_table to store configuration structures which are depending on
> SoC.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  arch/arm/mach-at91/at91rm9200.c          |  2 +-
>  arch/arm/mach-at91/at91rm9200_devices.c  | 11 +----
>  arch/arm/mach-at91/at91sam9260.c         |  3 +-
>  arch/arm/mach-at91/at91sam9260_devices.c |  8 ++-
>  arch/arm/mach-at91/at91sam9261.c         |  3 +-
>  arch/arm/mach-at91/at91sam9261_devices.c | 17 +++----
>  arch/arm/mach-at91/at91sam9263.c         |  2 +-
>  arch/arm/mach-at91/at91sam9263_devices.c |  2 +-
>  arch/arm/mach-at91/at91sam9g45.c         |  4 +-
>  arch/arm/mach-at91/at91sam9g45_devices.c |  4 +-
>  arch/arm/mach-at91/at91sam9rl.c          |  4 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c  |  2 +-
>  drivers/i2c/busses/i2c-at91.c            | 85 +++++++++++++++++++++++++-------
>  13 files changed, 95 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index f2112f9..0bc91e5 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -187,7 +187,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
>  	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
>  	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "at91rm9200_i2c", &twi_clk),
use i2c-xxx as on other drivers

and I do not like to have platform_device_id

as we need to touch the driver to add a new soc

please use platform data

Best Regards,
J.
