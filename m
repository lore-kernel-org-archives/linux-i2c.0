From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
 bus
Date: Mon, 8 Feb 2010 16:05:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8@dbde02.ent.ti.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	 <1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com>
 <225d086e1002050553tc1a696avce827cc115f56b1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <225d086e1002050553tc1a696avce827cc115f56b1c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org" <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Philby,

On Fri, Feb 05, 2010 at 19:23:43, Philby John wrote:
> Hello Sekhar,
>

[...]

> >> +/* Generate a pulse on the i2c clock pin. */
> >> +static void generic_i2c_clock_pulse(unsigned int scl_pin)
> >> +{
> >> +     u16 i;
> >> +
> >> +     if (scl_pin) {
> >> +             /* Send high and low on the SCL line */
> >> +             for (i = 0; i < 9; i++) {
> >> +                     gpio_set_value(scl_pin, 0);
> >> +                     udelay(20);
> >> +                     gpio_set_value(scl_pin, 1);
> >> +                     udelay(20);
> >> +             }
> >
> > Before using the pins as GPIO, you would have to set the
> > functionality of these pins as GPIO. You had this code in
> > previous incarnations of this patch - not sure why it is
> > dropped now.
> >
>
> Don't seem to remember having the code in the old versions at least
> not in generic_i2c_clock_pulse(). The functions disable_i2c_pins() and
> enable_i2c_pins() were discarded as the i2c protocol spec. did not
> specify the need. Moreover bus recovered without it. (Tested on DM355
> and Dm6446).

Yes, I was referring to the davinci_cfg_reg() calls in
{disable|enable}_i2c_pins() functions. Per the specification
of the DaVinci devices, a pin needs to be muxed as 'GPIO' if
it is to be used as GPIO controlled by GPIO module. It may
have worked on couple of devices but cannot be guaranteed to
work on all DaVinci devices (esp. DA8XX ones).

>
> > Couple of good to haves:
> >

[...]

> >
> > The I2C peripheral on da8xx itself contains a mode where its
> > pins could be used as GPIO - so no need for SoC level muxing
> > and need for the platform data. This seems to be missing from
> > DM355 though. Thankfully there is a revision id within the I2C
> > memory map which will help you differentiate the two cases
> > (revision 0x5 vs 0x6)
>
> I did not entirely follow your above statement. Will usage of
> gpio_request() solve the problem for da8xx and DM355 or does it
> require a if else condition?

You require special casing for I2C version 0x6.
Have a look here: http://focus.ti.com/lit/ug/sprufl9a/sprufl9a.pdf
I was referring to registers described in sections
3.15-3.20

> A reminder that the present code will
> only work for DM6446 and DM355. I do not have a DA8xx to test specific
> functionality if it were to be added.

Right. It is only an enhancement (and only good
to have at that). This should not stop the current
patch from getting in.

Thanks,
Sekhar
