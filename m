From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] Add static bus numbering support to i2c-versatile
Date: Tue, 10 Feb 2009 12:24:29 +0000
Message-ID: <1234268669.8798.10.camel@pc1117.cambridge.arm.com>
References: <20090209203045.0c7a32a4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090209203045.0c7a32a4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2009-02-09 at 19:30 +0000, Jean Delvare wrote:
> On Mon, 09 Feb 2009 18:03:38 +0000, Catalin Marinas wrote:
> > diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
> > index 4678bab..15b5e8a 100644
> > --- a/drivers/i2c/busses/i2c-versatile.c
> > +++ b/drivers/i2c/busses/i2c-versatile.c
> > @@ -96,13 +96,20 @@ static int i2c_versatile_probe(struct platform_device *dev)
> >       writel(SCL | SDA, i2c->base + I2C_CONTROLS);
> > 
> >       i2c->adap.owner = THIS_MODULE;
> > +     if (dev->id >= 0)
> > +             i2c->adap.nr = dev->id;
> >       strlcpy(i2c->adap.name, "Versatile I2C adapter", sizeof(i2c->adap.name));
> >       i2c->adap.algo_data = &i2c->algo;
> >       i2c->adap.dev.parent = &dev->dev;
> >       i2c->algo = i2c_versatile_algo;
> >       i2c->algo.data = i2c;
> > 
> > -     ret = i2c_bit_add_bus(&i2c->adap);
> > +     if (dev->id >= 0)
> > +             /* static bus numbering */
> > +             ret = i2c_bit_add_numbered_bus(&i2c->adap);
> > +     else
> > +             /* dynamic bus numbering */
> > +             ret = i2c_bit_add_bus(&i2c->adap);
> 
> Why don't you merge both tests? This would simplify the code and make
> it clearer.

Good point. Please see below. Thanks.


Add static bus numbering support to i2c-versatile

From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>

If dev->id is not -1, the platform code may use static bus numbering
rather than dynamic. The patch also changes the i2c_versatile_init to a
subsys_initcall rather than module_init to make sure it is initialised
before the I2C devices initialisation.

Signed-off-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-versatile.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index 4678bab..fede619 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -102,7 +102,13 @@ static int i2c_versatile_probe(struct platform_device *dev)
 	i2c->algo = i2c_versatile_algo;
 	i2c->algo.data = i2c;
 
-	ret = i2c_bit_add_bus(&i2c->adap);
+	if (dev->id >= 0) {
+		/* static bus numbering */
+		i2c->adap.nr = dev->id;
+		ret = i2c_bit_add_numbered_bus(&i2c->adap);
+	} else
+		/* dynamic bus numbering */
+		ret = i2c_bit_add_bus(&i2c->adap);
 	if (ret >= 0) {
 		platform_set_drvdata(dev, i2c);
 		return 0;
@@ -146,7 +152,7 @@ static void __exit i2c_versatile_exit(void)
 	platform_driver_unregister(&i2c_versatile_driver);
 }
 
-module_init(i2c_versatile_init);
+subsys_initcall(i2c_versatile_init);
 module_exit(i2c_versatile_exit);
 
 MODULE_DESCRIPTION("ARM Versatile I2C bus driver");


-- 
Catalin
