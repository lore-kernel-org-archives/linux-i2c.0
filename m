From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH 3/8] i2c: at91: use an id table for SoC dependent
 parameters
Date: Mon, 3 Sep 2012 08:16:59 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC8F387@wm021.weinmann.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com>
 <20120831142944.GA23867@game.jcrosoft.org> <5040CF80.8060201@atmel.com>
 <504122D3.70507@gmail.com> <20120901091054.GA17540@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120901091054.GA17540-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, 'Sylwester Nawrocki' <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Nicolas Ferre' <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org'" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean-Christophe PLAGNIOL-VILLARD wrote on Saturday, September 01, 2012 11:11 AM:
> On 22:47 Fri 31 Aug     , Sylwester Nawrocki wrote:
> > On 08/31/2012 04:51 PM, Nicolas Ferre wrote:
> > >>> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-
> at91/at91rm9200.c
> > >>> index f2112f9..0bc91e5 100644
> > >>> --- a/arch/arm/mach-at91/at91rm9200.c
> > >>> +++ b/arch/arm/mach-at91/at91rm9200.c
> > >>> @@ -187,7 +187,7 @@ static struct clk_lookup periph_clocks_lookups[]
> = {
> > >>>   	CLKDEV_CON_DEV_ID("pclk", "ssc.0",&ssc0_clk),
> > >>>   	CLKDEV_CON_DEV_ID("pclk", "ssc.1",&ssc1_clk),
> > >>>   	CLKDEV_CON_DEV_ID("pclk", "ssc.2",&ssc2_clk),
> > >>> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c",&twi_clk),
> > >>> +	CLKDEV_CON_DEV_ID(NULL, "at91rm9200_i2c",&twi_clk),
> > >> use i2c-xxx as on other drivers
> > >>
> > >> and I do not like to have platform_device_id
> > >
> > > Me, I like it and find this implementation very elegant.
> > >
> > >> as we need to touch the driver to add a new soc
> > >
> > > So what? We still keep the compatibility if the new SoC has it
> > > compatibility assured with previous revision: there is nothing to modify.
> >
> > I agree. The driver would need to be touched to support new SoC only if
> > the IP there have had some differences, which would have needed to be
> > resolved anyway.
> >
> > >> please use platform data
> >
> > Using platform data for the dt platforms would have been more
> troublesome,
> > wouldn't it ? I like Ludovic's approach which handles both: dt and non-dt
> > cases in uniform way from the driver's POV.
> no you will describe it via DT as done on all the other drivers
> >
> > > No, it does not have to be exposed to the user: these data are highly
> > > dependent on the actual hardware (IP revision in fact). So, no need to
> > > mess with platform data.
> no I really see no point on these list of platform_id it's does not look more
> nice just more huggly to have x names. This is at the end the same as
> passing
> platform data via soc info (add_xx or dtsi)
> 
> And here you just do the same as cpu_is via names.

That's what the names suggest, but it's not the case. What the DEV_IDs
stand for is actually an IP version which cannot be read out from the IP
directly. So the version information is coded at a place where it should
be available: in the SoC setup code (not in the driver code, as with the
cpu_is() variant). Example: the name at91sam9g10 does not stand for
the cpu type but for the IP class which is also used on g45 SoC. 

> 
> The driver need to read IP revision instead

That would be the easiest solution, but the IP does not know it's
version. The DEV_ID approach is a workaround for this limitation.

Regards,
Niko
