From: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-bcm2708: fixes cdiv uneven number
Date: Wed, 6 May 2015 20:35:00 +0200
Message-ID: <20150506183500.GA2099@debbr>
References: <1430516629-32692-1-git-send-email-linux_wi@tinag.ch>
 <CAA7nrtgTOg0YBKavBhV+=9fvxxjtd143aODZpfR=TSN7STrrXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAA7nrtgTOg0YBKavBhV+=9fvxxjtd143aODZpfR=TSN7STrrXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 04, 2015 at 10:20:42AM +0530, rajeev kumar wrote:
> On Sat, May 2, 2015 at 3:13 AM, Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org> wrote:
> > Prevents that cdiv can be an uneven number as per datasheet cdiv is
> > always rounded down to an even number.
> >
> > Datasheet at page 34 on
> > http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> >
> > Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
> > ---
> Reviewed-by: Rajeev Kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> >  drivers/i2c/busses/i2c-bcm2708.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-bcm2708.c b/drivers/i2c/busses/i2c-bcm2708.c
> > index 81e9374..dd7094a 100644
> > --- a/drivers/i2c/busses/i2c-bcm2708.c
> > +++ b/drivers/i2c/busses/i2c-bcm2708.c
> > @@ -67,6 +67,9 @@
> >  #define BSC_S_DONE             0x00000002
> >  #define BSC_S_TA               0x00000001
> >
> > +#define BSC_CDIV_MAX           0xFFFE
> > +#define BSC_CDIV_BITMASK       0xEFFF
BSC_CDIV_BITMASK needs to be 0xFFFE; please don't change

> > +
> >  #define I2C_TIMEOUT_MS 150
> >  #define I2C_WAIT_LOOP_COUNT 40
> >
> > @@ -441,9 +444,15 @@ static int bcm2708_i2c_probe(struct platform_device *pdev)
> >
> >         bus_hz = clk_get_rate(bi->clk);
> >         cdiv = bus_hz / baudrate;
> > -       if (cdiv > 0xffff) {
> > -               cdiv = 0xffff;
> > +       /* as per datasheet cdiv is always rounded down to an even number */
> > +       if (cdiv > BSC_CDIV_MAX) {
> > +               cdiv = BSC_CDIV_MAX;
> >                 baudrate = bus_hz / cdiv;
> > +       } else {
> > +               if ((cdiv & BSC_CDIV_BITMASK) != cdiv) {
> > +                       cdiv &= BSC_CDIV_BITMASK;
> > +                       baudrate = bus_hz / cdiv;
> > +               }
> >         }
> >         bi->cdiv = cdiv;
> >
> > --
> > 2.1.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
