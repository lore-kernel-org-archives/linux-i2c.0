From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Fri, 22 Nov 2013 15:51:41 +0100
Message-ID: <3869.3847637207$1385131943@news.gmane.org>
References: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com>
 <20131122143350.GA7420@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131122143350.GA7420@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, Nov 22, 2013 at 03:33:51PM +0100, Wolfram Sang wrote:
> On Fri, Nov 22, 2013 at 03:07:08PM +0100, ludovic.desroches@atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > There are still I2C unexpected behaviors which are solved by reducing TWI
> > internal frequency.
> > 
> > Cc: <stable@vger.kernel.org> #3.10+
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> I think the commit message needs more details. Is this a true bugfix
> because the real bus frequency was too high because of the wrong
> divider? Is this a workaround which makes things work but will make the
> bus frequency slower than it should be?

This fix doesn't concern the i2c bus frequency, only the internal IP frequency.

TWI has been validated at 66MHz. With some devices, transfer hangs during i2c
frame transmission. This issue disappears when reducing the internal frequency
of the IP. Maybe there is some oversampling on i2c signals.
Unfortunately, I have no clear status about the root cause that's why
the commit message was imprecise.


Regards

Ludovic
> 
> > ---
> >  arch/arm/mach-at91/sama5d3.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> > index 4012797..4ee0de5 100644
> > --- a/arch/arm/mach-at91/sama5d3.c
> > +++ b/arch/arm/mach-at91/sama5d3.c
> > @@ -95,19 +95,19 @@ static struct clk twi0_clk = {
> >  	.name		= "twi0_clk",
> >  	.pid		= SAMA5D3_ID_TWI0,
> >  	.type		= CLK_TYPE_PERIPHERAL,
> > -	.div		= AT91_PMC_PCR_DIV2,
> > +	.div		= AT91_PMC_PCR_DIV8,
> >  };
> >  static struct clk twi1_clk = {
> >  	.name		= "twi1_clk",
> >  	.pid		= SAMA5D3_ID_TWI1,
> >  	.type		= CLK_TYPE_PERIPHERAL,
> > -	.div		= AT91_PMC_PCR_DIV2,
> > +	.div		= AT91_PMC_PCR_DIV8,
> >  };
> >  static struct clk twi2_clk = {
> >  	.name		= "twi2_clk",
> >  	.pid		= SAMA5D3_ID_TWI2,
> >  	.type		= CLK_TYPE_PERIPHERAL,
> > -	.div		= AT91_PMC_PCR_DIV2,
> > +	.div		= AT91_PMC_PCR_DIV8,
> >  };
> >  static struct clk mmc0_clk = {
> >  	.name		= "mci0_clk",
> > -- 
> > 1.7.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
