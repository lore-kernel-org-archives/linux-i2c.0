From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: device tree bindings for i2c speed
 mode
Date: Wed, 20 Aug 2014 10:36:21 +0100
Message-ID: <20140820093621.GC21174@leverpostej>
References: <1408473276-10847-1-git-send-email-atull@opensource.altera.com>
 <20140820093459.GB21174@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140820093459.GB21174@leverpostej>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org" <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org" <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org" <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org" <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, "yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org" <yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 20, 2014 at 10:34:59AM +0100, Mark Rutland wrote:
> On Tue, Aug 19, 2014 at 07:34:35PM +0100, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
> > From: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> > 
> > Add "speed-mode" Device Tree property to select between
> > standard and fast i2c mode.  Previously, driver was hardwired
> > as fast mode.  Default to fast mode if property is not
> > present.
> > 
> > Signed-off-by: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> > ---
> >  .../devicetree/bindings/i2c/i2c-designware.txt     |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > index 5199b0c..0e4cd21 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > @@ -9,6 +9,8 @@ Required properties :
> >  Recommended properties :
> >  
> >   - clock-frequency : desired I2C bus clock frequency in Hz.
> > + - speed-mode      : 0 = standard (0 - 100Kb/s)
> > +                   : 1 = fast (<= 400Kb/s) <== default
> 
> This is a bit opaque.
> 
> Is this a limit on the max bit-rate the device should operate at?
> 
> Why not just have an optional boolean property to limit to standard
> speed?

I see there's a new patch doing this based on clock-frequency, so feel
free to ignore this.

Mark.
