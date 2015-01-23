From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Fri, 23 Jan 2015 15:04:06 +0200
Message-ID: <1422018246.31903.162.camel@linux.intel.com>
References: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1422014045-20584-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150123124155.GA1906@katana> <20150123124805.GP1850@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150123124805.GP1850-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2015-01-23 at 14:48 +0200, Mika Westerberg wrote:
> On Fri, Jan 23, 2015 at 01:41:55PM +0100, Wolfram Sang wrote:
> > On Fri, Jan 23, 2015 at 01:54:03PM +0200, Andy Shevchenko wrote:
> > > There is no need to duplicate same data for each controller. If we need
> > > specific stuff for a certain controller in the future we may add it later. The
> > > patch leaves one controller per platform.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/i2c-designware-pcidrv.c | 63 ++++++------------------------
> > >  1 file changed, 11 insertions(+), 52 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > index 5c6fca7..435a8ec 100644
> > > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > @@ -40,13 +40,7 @@
> > >  #define DRIVER_NAME "i2c-designware-pci"
> > >  
> > >  enum dw_pci_ctl_id_t {
> > > -	medfield_0,
> > > -	medfield_1,
> > > -	medfield_2,
> > > -	medfield_3,
> > > -	medfield_4,
> > > -	medfield_5,
> > > -
> > > +	medfield,
> > >  	baytrail,
> > >  	haswell,
> > >  };
> > > @@ -98,47 +92,12 @@ static struct dw_scl_sda_cfg hsw_config = {
> > >  };
> > >  
> > >  static struct  dw_pci_controller  dw_pci_controllers[] = {
> > > -	[medfield_0] = {
> > > -		.bus_num     = 0,
> > 
> > Wasn't that bus_num used to ensure stable bus numbers? Adding Mika.
> 
> That's right.
> 
> However, I don't think anybody really uses Medfield outside Intel so in
> that sense this patch should not break anything.

I think better to ask David who is closer to that Intel MID area.

AFAIU, technically due to fake PCI bus on Medfield even with automatic
bus number you will get stable assignment, though it might be changed
once from the original version.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy
