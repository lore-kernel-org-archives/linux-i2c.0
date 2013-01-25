From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V9 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 25 Jan 2013 15:06:52 +0530
Message-ID: <CAKohpongZ_C0Ypquxa2fi=X_FXKQeRqCCaDkUSJ+S6o_Ft=Ypw@mail.gmail.com>
References: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar@linaro.org>
	<20130125091512.GE5684@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130125091512.GE5684-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 25 January 2013 14:45, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Jan 24, 2013 at 04:06:37PM +0530, Viresh Kumar wrote:
>> +static int i2c_generic_recovery(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>> +     int i = 0, val = 1, ret = 0;
>> +
>> +     if (bri->prepare_recovery)
>> +             bri->prepare_recovery(bri);
>> +
>> +     /*
>> +      * By this time SCL is high, as we need to give 9 falling-rising edges
>> +      */
>> +     while (i++ < RECOVERY_CLK_CNT * 2) {
>> +             /* SCL shouldn't be low here */
>> +             if (val && !bri->get_scl(adap)) {
>> +                     dev_err(&adap->dev, "SCL is stuck Low exit recovery\n");
>> +                     ret = -EBUSY;
>> +                     goto unprepare;
>> +             }
>> +
>> +             val = !val;
>> +             bri->set_scl(adap, val);
>> +             ndelay(clk_delay);
>> +
>> +             /* break if sda got high, check only when scl line is high */
>> +             if (bri->get_sda && val)
>> +                     if (bri->get_sda(adap))
>> +                             break;
>
> Didn't we agree to move the SDA check before the SCL setting?

Yes. There was a check for SCL (separately) before this loop. I got that into
this loop to save on redundant code. And now, after sending a complete clock,
we first check sda, then go to next iteration of loop and check scl.

Over that, this routine is a modified a bit again, due to Uwe's comment.

Wait for v10. You would get that in 2 mins :)

BTW, all other comments are accepted.
