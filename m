From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 24 Jan 2013 16:30:21 +0530
Message-ID: <CAKohpokVDxer4hfKKQTbW4_XOApaSFxbHWDCMPamsGjSDB297g@mail.gmail.com>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
	<20130124072445.GA8364@nekote.pengutronix.de>
	<20130124105438.GB8668@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130124105438.GB8668-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 24 January 2013 16:24, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Jan 24, 2013 at 08:24:45AM +0100, Wolfram Sang wrote:
> Some more comments below.

Always welcomed :)

>> * if (val && bri->get_sda)
>>
>> > +                   /* Check SCL again to see fault condition */
>> > +                   if (!bri->get_scl(adap)) {
>> > +                           dev_err(&adap->dev, "SCL is stuck Low =
during recovery, exiting recovery.\n");
>>
>> > +                           goto unprepare;
>> > +                   }
>> > +
>> > +                   if (bri->get_sda(adap))
>> > +                           break;
> Indention suggests that you want this in the body of the if (val &&
> bri->get_sda). Unfortunately the C-Compiler won't notice without brac=
es.

Wow!! It was a blunder. Don't know how the braces got dropped.

My bad, but the new patchset (already posted), must have fixed it by
mistake :)

>> Checking SDA should be done before setting SCL? That would
>>
>> a) let us escape early if SDA got HIGH magically somehow until we en=
ter
>>    the for loop for the first time
>> b) breaking out of the for loop after the last pulse is moot
> You mean:
>
>         val =3D 0;
>
>         for (i =3D 0; i < RECOVERY_CLK_CNT * 2; i++, val =3D !val) {
>                 if (!val && !bri->get_scl(adap))
>                                 scl stuck low (or wait a bit to sort =
out clock streching)
>                 if (bri->get_sda && bri->get_sda(adap))
>                         break;
>
>                 bri->set_scl(adap, val);
>                 ndelay(clk_delay);
>         }
>
> Looks ok I think. This would also get rid of the seperate scl check
> before the loop.

I have done something similar in V9..
