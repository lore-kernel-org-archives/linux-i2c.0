From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Add SMBus alert support
Date: Tue, 16 Feb 2010 10:56:06 +0100
Message-ID: <20100216105606.003b01dd@hyperion.delvare>
References: <20100213230438.31fd0fd7@hyperion.delvare>
	<20100213230656.341ec091@hyperion.delvare>
	<4B7991CC.3020904@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B7991CC.3020904-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jonathan,

On Mon, 15 Feb 2010 18:26:20 +0000, Jonathan Cameron wrote:
> I have a couple of parts I can test this on (connected to a pxa271)
> but it may be a little while before I get to it (so don't let me
> hold the patch up!)

That would be great. You can always get the latest version of the patch
either in my i2c tree or in linux-next.

> On tiny point below.  Worth changing if you are doing another roll of the patch
> as at least in my dozy Monday evening state it confused me for a few moments!
> ...
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.33-rc7/drivers/i2c/i2c-smbus.c	2010-02-12 16:11:34.000000000 +0100
> ...
> > +/*
> > + * The alert IRQ handler needs to hand work off to a task which can issue
> > + * SMBus calls, because those sleeping calls can't be made in IRQ context.
> > + */
> > +static void smbus_alert(struct work_struct *work)
> > +{
> > +	struct i2c_smbus_alert *data;
> > +	struct i2c_client *ara;
> > +	unsigned short prev_addr = 0;	/* Not a valid address */
> > +
> > +	data = container_of(work, struct i2c_smbus_alert, alert);
> > +	ara = data->ara;
> > +
> > +	for (;;) {
> > +		s32 status;
> > +		struct alert_data data;
> Can we change the name of data here.  From readability point of view it
> would be better not to have this reliance on scope (as data used for 
> struct i2c_smbus_alert *data above. (obviously changing it above would 
> work as well!) 

Oh, yeah, of course. Thanks for pointing this out. I wish we built the
kernel with -Wshadow so that gcc could tell us automatically...

I have changed all instances of struct i2c_smbus_alert * to name
"alert", this solves the problem and should make the code more
consistent and readable.

Thanks!
-- 
Jean Delvare
