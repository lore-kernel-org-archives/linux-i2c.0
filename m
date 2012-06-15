From: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: Fwd: [PATCH 1/3] i2c: Add Device Tree support to the Nomadik
 I2C driver
Date: Fri, 15 Jun 2012 19:07:29 +0530
Message-ID: <20120615133729.GA12716@bnru02>
References: <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD8BAD2.50703@linaro.org>
 <CACRpkdZFi34nChnMEo6yik67zk9owZLk-6zcdP7mmOXyLz8uqQ@mail.gmail.com>
 <4FDAFA17.6050502@linaro.org>
 <CAE2-_9rRYxjU9QQgtBv9ReMY5x+oRiJG1cDQahYHanjDrwVUYA@mail.gmail.com>
 <20120615115042.GA27480@bnru02>
 <4FDB2E57.4030904@linaro.org>
 <20120615130544.GA28537@bnru02>
 <4FDB3642.5030804@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FDB3642.5030804-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 15, 2012 at 15:18:58 +0200, Lee Jones wrote:
> On 15/06/12 14:05, Srinidhi Kasagar wrote:
> > On Fri, Jun 15, 2012 at 14:45:11 +0200, Lee Jones wrote:
> >> On 15/06/12 12:50, Srinidhi Kasagar wrote:
> >>> [...]
> >>>>
> >>>>
> >>>> From: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>> Date: Tue, 17 Apr 2012 16:04:13 +0100
> >>>> Subject: [PATCH 1/1] i2c: Add Device Tree support to the Nomadik I2C driver
> >>>>
> >>>> Here we apply the bindings required for successful Device Tree
> >>>> probing of the i2c-nomadik driver. We also apply a fall-back
> >>>> configuration in case either one is not provided, or a required
> >>>> element is missing from the one supplied.
> >>>>
> >>>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> Signed-off-by: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>> ---
> >>>>    drivers/i2c/busses/i2c-nomadik.c |   82 +++++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 80 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> >>>> index a92440d..58e8114 100644
> >>>> --- a/drivers/i2c/busses/i2c-nomadik.c
> >>>> +++ b/drivers/i2c/busses/i2c-nomadik.c
> >>>> @@ -23,6 +23,7 @@
> >>>>    #include<linux/io.h>
> >>>>    #include<linux/regulator/consumer.h>
> >>>>    #include<linux/pm_runtime.h>
> >>>> +#include<linux/of.h>
> >>>>
> >>>>    #include<plat/i2c.h>
> >>>>
> >>>> @@ -899,15 +900,86 @@ static const struct i2c_algorithm nmk_i2c_algo = {
> >>>>          .functionality  = nmk_i2c_functionality
> >>>>    };
> >>>>
> >>>> +static struct nmk_i2c_controller u8500_i2c = {
> >>>> +       /*
> >>>> +        * Slave data setup time; 250ns, 100ns, and 10ns, which
> >>>> +        * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
> >>>> +        */
> >>>> +       .slsu           = 0xe,

And BTW, I forgot to mention: This slsu stuff is not needed at all.
It is required only in case of slave mode operation, which the
driver does not support. You can perhaps consider deprecating
this parameter from device tree list as well as from platform data.

> >>>> +       .tft            = 1,      /* Tx FIFO threshold */
> >>>> +       .rft            = 8,      /* Rx FIFO threshold */
> >>>> +       .clk_freq       = 100000, /* std. mode operation */
> >>>> +       .timeout        = 200,    /* Slave response timeout(ms) */
> >>>> +       .sm             = I2C_FREQ_MODE_FAST,
> >>>
> >>> How is this possible? you are setting clk_freq as 100kb/s and mode
> >>> as fast mode which is supposed to be 400kb/s.
> >>
> >> That's not how I read it:
> >
> > But it is not readable. It confuses people.
> 
> I understood it. :)
> 
> If you think it's unclear speak to the author, Linus. He's CC'ed.

It is!

/srinidhi
