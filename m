From: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Subject: Re: Implementing bus recovery
Date: Wed, 27 Aug 2014 13:02:30 +0200
Message-ID: <53FDBAC6.4090807@aqwary.com>
References: <53F796B1.2000400@aqwary.com> <CAJjB1q+_KbLBKXNMvG6DWHcuVOvmJs3XmT3B8yb-_a0K12ZJtw@mail.gmail.com> <53FB1369.802@aqwary.com> <CAJjB1qLO86mDntbnMZKWNycmuW4QGDuZVd_EhqB2XSenunzOxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJjB1qLO86mDntbnMZKWNycmuW4QGDuZVd_EhqB2XSenunzOxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(btw, I noticed my emails were badly formatted. Hopefully I have fixed
that now)

Den 2014-08-27 05:08, Mark Roszko skrev:
>> We are using a sama5d3-based machine which is almost entirely dt based, so passing callbacks to the driver using the platform data seems like a bad fit. >Hard coding these calls in the driver won't really work either (even for a single machine) since not all instances of the adapter exist on the same peripheral. >Ie, one adapter is on peripheral A and the others are on peripheral B for this specific soc.
> 
>  I forgot the SAMA5 doesn't keep the TWI peripherals on the same
> pinmux positions. Even more variance with the other Atmel SoCs using
> the same driver. Easiest fix would be to pass the i2c_adapter pointer
> rather than i2c_bus_recovery_info which seems harmless and retains the
> recovery info pointer internally. That way you can grab the at91
> driver struct where you would have saved the pinmux before/after
> config.
> 

Gave this a shot and it seems to work fine :-)

> Btw, side thing, this may help you since you seem to care about your
> SAMA5's i2c functioning.... if you are doing smbus block reads with
> the SAMA5 you may want to pull this patch for yourself:
> https://patchwork.ozlabs.org/patch/381843/. Fixes a kernel panic and
> at91 TWI controller timeout.
> 

Nice, thanks for the heads-up :-)
