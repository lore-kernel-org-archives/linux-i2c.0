From: Giampaolo Bellini <iw2lsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Thu, 24 Jun 2010 19:49:00 +0200
Message-ID: <AANLkTikhwn0l3nK-a-4TfP-mHcJxwvw7bxe2mKyya61A@mail.gmail.com>
References: <AANLkTik5ICmrrsX0m9qzPr7TzF44HKIr5FMC4eKeGkzZ@mail.gmail.com>
	<20100624114937.23bb3efc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100624114937.23bb3efc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Jean

  thanks you so much for your time!

> This means they refer to left-aligned addresses. Linux uses
> right-aligned addresses, so your device lives at 0x20 as far as Linux
> is concerned.

effectively, after hours and hours of testing, I found by myself that
the correct addressed where 0x20 and 0x21 but was not able to
understand why the manufacturer gives me what I think was a wrong
registers map !

> Check arch/arm/mach-ks8695/board-acs5k.c and
> arch/arm/mach-pxa/cm-x300.c for examples.

I'll check these source in the next days... so pca953x driver could
just export his services to other modules ? does it nothing alone
and/or paired with gpiolib ? or it's just a question of give the
pca953x some platforms data ?

> (Assuming i2c-0 is the bus on which the chip actually lives - you can
> check with i2cdetect). That being said, I doubt that a GPIO chip can
> really be instantiated from user-space, as it needs configuration
> settings which you can't provide that way.

you are right... i've try yesterday with the correct addresses but
with no success.

thanks again...

     Giampaolo
