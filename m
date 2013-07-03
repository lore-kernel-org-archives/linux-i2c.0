From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 3 Jul 2013 16:20:03 +0200
Message-ID: <201307031620.03785.arnd@arndb.de>
References: <20130625163902.GA2973@katana> <201307031343.11647.arnd@arndb.de>
 <20130703132905.GC3929@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130703132905.GC3929-7oYq3qWSd+k@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, vincent.stehle@freescale
Cc: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 03 July 2013, Christian Ruppert wrote:
> On Wed, Jul 03, 2013 at 01:43:11PM +0200, Arnd Bergmann wrote:
> > On Wednesday 26 June 2013, Wolfram Sang wrote:
> > >   On Wed, Jun 26, 2013 at 10:55:06AM +0200, Christian Ruppert wrote:
> > > > This patch makes the SDA hold time configurable through device tree.
> > > > 
> > > > Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > > > Signed-off-by: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > > 
> > > Applied to for-next, thanks for keeping at it and providing lots of
> > > useful information. Much appreciated!
> > 
> > Sorry, but I got a regression that I didn't find reported elsewhere
> > so far, even though it breaks a lot of the ARM defconfig builds:
> > 
> > drivers/built-in.o: In function `dw_i2c_probe':
> > /git/arm-soc/drivers/i2c/busses/i2c-designware-platdrv.c:125: undefined reference to `__udivdi3'
> > 
> > I suspect you want something like the change below.
> 
> This looks similar to a patch Vincent Stehle submitted yesterday, see
> https://lkml.org/lkml/2013/7/2/145

Thanks for the link. Actually his patch looks wrong to me, because

 dev->sda_hold_time = div_u64((u64)ic_clk * ht + 500000, 1000000); 

assigns the division remainder to sda_hold_time, not the quotient.


	Arnd

> > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index def79b5..57e3a07 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -119,10 +119,13 @@ static int dw_i2c_probe(struct platform_device *pdev)
> >  	if (pdev->dev.of_node) {
> >  		u32 ht = 0;
> >  		u32 ic_clk = dev->get_clk_rate_khz(dev);
> > +		u64 hold_time;
> >  
> >  		of_property_read_u32(pdev->dev.of_node,
> >  					"i2c-sda-hold-time-ns", &ht);
> > -		dev->sda_hold_time = ((u64)ic_clk * ht + 500000) / 1000000;
> > +		hold_time = (u64)ic_clk * ht + 500000;
> > +		do_div(hold_time, 1000000);
> > +		dev->sda_hold_time = hold_time;
> >  	}
> >  
> >  	dev->functionality =
