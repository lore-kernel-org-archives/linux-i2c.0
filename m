From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 2
Date: Tue, 18 Mar 2008 15:25:44 +0200
Message-ID: <31e679430803180625u482e6bf7r1be713f6b1aeac4d@mail.gmail.com>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-2-git-send-email-me@felipebalbi.com>
	<1205585237-21492-3-git-send-email-me@felipebalbi.com>
	<1205585237-21492-4-git-send-email-me@felipebalbi.com>
	<20080315124918.GA21547@kedavra.cpe.vivax.com.br>
	<20080315125458.GB21547@kedavra.cpe.vivax.com.br>
	<20080315131309.GA24990@kedavra.cpe.vivax.com.br>
	<20080316105617.GA4503@kedavra.cpe.vivax.com.br>
	<20080318141528.53f4b2d8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080318141528.53f4b2d8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hmm...

On Tue, Mar 18, 2008 at 3:15 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Huuuuu, I'm just see this:
>
>
>  On Sun, 16 Mar 2008 12:56:18 +0200, Felipe Balbi wrote:
>
>
> > -static int isp1301_probe(struct i2c_adapter *bus, int address, int kind)
>  > +static int __init isp1301_probe(struct i2c_client *client)
>  >  {
>  >       int                     status;
>  >       struct isp1301          *isp;
>  > -     struct i2c_client       *i2c;
>  >
>  >       if (the_transceiver)
>  >               return 0;
>  > @@ -1492,45 +1470,29 @@ static int isp1301_probe(struct i2c_adapter *bus, int address, int kind)
>  >       init_timer(&isp->timer);
>  >       isp->timer.function = isp1301_timer;
>  >       isp->timer.data = (unsigned long) isp;
>  > -
>  > -     isp->irq = -1;
>  > -     isp->c.addr = address;
>  > -     i2c_set_clientdata(&isp->c, isp);
>  > -     isp->c.adapter = bus;
>  > -     isp->c.driver = &isp1301_driver;
>  > -     strlcpy(isp->c.name, DRIVER_NAME, I2C_NAME_SIZE);
>  > -     isp->client = i2c = &isp->c;
>  > +     isp->client = client;
>  >
>  >       /* if this is a true probe, verify the chip ... */
>  > -     if (kind < 0) {
>  > -             status = isp1301_get_u16(isp, ISP1301_VENDOR_ID);
>  > -             if (status != I2C_VENDOR_ID_PHILIPS) {
>  > -                     dev_dbg(&bus->dev, "addr %d not philips id: %d\n",
>  > -                             address, status);
>  > -                     goto fail1;
>  > -             }
>  > -             status = isp1301_get_u16(isp, ISP1301_PRODUCT_ID);
>  > -             if (status != I2C_PRODUCT_ID_PHILIPS_1301) {
>  > -                     dev_dbg(&bus->dev, "%d not isp1301, %d\n",
>  > -                             address, status);
>  > -                     goto fail1;
>  > -             }
>  > +     status = isp1301_get_u16(isp, ISP1301_VENDOR_ID);
>  > +     if (status != I2C_VENDOR_ID_PHILIPS) {
>  > +             dev_dbg(&client->dev, "not philips id: %d\n", status);
>  > +             goto fail1;
>  > +     }
>  > +     status = isp1301_get_u16(isp, ISP1301_PRODUCT_ID);
>  > +     if (status != I2C_PRODUCT_ID_PHILIPS_1301) {
>  > +             dev_dbg(&client->dev, "not isp1301, %d\n", status);
>  > +             goto fail1;
>  >       }
>  >
>  > -     status = i2c_attach_client(i2c);
>  > -     if (status < 0) {
>  > -             dev_dbg(&bus->dev, "can't attach %s to device %d, err %d\n",
>  > -                             DRIVER_NAME, address, status);
>  >  fail1:
>  >               kfree(isp);
>  >               return 0;
>  > -     }
>
>  This is an unconditional failure, isn't it? So if I may ask: how did
>  you test this patch to not notice this?

I'll fix this one...

>  > -     isp->i2c_release = i2c->dev.release;
>  > -     i2c->dev.release = isp1301_release;
>  > +
>  > +     isp->i2c_release = client->dev.release = isp1301_release;
>
>  And this is a functional change which I really doubt was made on
>  purpose. It will make isp1301_release loop forever.

I can't see why holding the function in struct isp1301_omap will make
it loop forever. There's actually a comment on the code that says:

static void isp1301_release(struct device *dev)
{
	struct isp1301		*isp = dev_get_drvdata(dev);

	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
	if (isp->i2c_release)
		isp->i2c_release(dev);
	kfree (isp);
}

>  Don't know about you, but I am seriously tired by this patch. We're
>  working on it for more than 2 months, it must have seen half a dozen
>  revisions by now, and it's still broken enough for me to be sure that
>  it wasn't even tested.

Like i told before, I don't have access anymore to omap1 or omap2
boards. I asked Dave to test when he had anytime but it looks like
he hadn't any :-s

>  The obvious reason is that this patch does several things at once. It's
>  not just converting the driver to a new-style i2c driver, it is also
>  moving the board-specific code out of the driver (or plain killing it
>  without explanations), and on top of this you add unrelated code
>  cleanups (or breakage). Patches are supposed to be split into
>  functional changes that are easy to review and test, exactly to avoid
>  this situation.

Looks like you're right here.

>  So I'll just drop this patch for now. I can't afford pushing broken
>  stuff into -mm. Let me know when you have something better and well
>  tested.

Fair enough, but i won't have a way to test this patch. So better
letting someone
else play with it.

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
