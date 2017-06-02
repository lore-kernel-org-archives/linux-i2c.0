From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 2 Jun 2017 02:29:39 -0700
Message-ID: <CAFd5g45en_S0NYgufoET_Lwgu3Rs=7RafsFJZeCUiYCWyxogag@mail.gmail.com>
References: <20170525064925.16867-1-brendanhiggins@google.com>
 <20170525064925.16867-5-brendanhiggins@google.com> <1496197001.3354.19.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1496197001.3354.19.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Kachalov Anton <mouse-Pma6HLj0uuo@public.gmane.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg-Bxea+6Xhats@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I addressed all of your comments in my next revision except the one below.

>> +     time_left = wait_for_completion_timeout(&bus->cmd_complete,
>> +                                             bus->adap.timeout);
>> +
>> +     spin_lock_irqsave(&bus->lock, flags);
>> +     bus->msgs = NULL;
>> +     if (time_left == 0)
>> +             ret = -ETIMEDOUT;
>> +     else
>> +             ret = bus->cmd_err;
>> +     spin_unlock_irqrestore(&bus->lock, flags);
>
> I would make the interrupt handler self-clear msgs and I would copy
> cmd_err to a separate field (or ensure it's only set by the interrupt
> handler when msgs is non-NULL, by the completion code).
>
> That way you avoid the above lock which is racy, slave activity could
> get in there and trigger an error interrupt clobbering cmd_err for
> example no ? Or am I missing something...

The slave handler does not touch these fields, so that should be fine.
The only way I can think
that we could get in this state is if we had some sort of error
interrupt fire after we handled a
STOP or previous error; this should not happen, but I think it is
better to be safe than sorry.
Nevertheless, I do not think it is necessary to do more than what I
have already done because
it would mean the bus is in a pretty bad state anyway. Maybe I should
just drop the locks here.

If you disagree, could you elaborate on what you meant by putting
cmd_err in a separate field?
Did you just mean having one for xfer and one for everything else (like resets)?

>
>> +     /* If nothing went wrong, return number of messages transferred. */
>> +     if (ret >= 0)
>> +             return bus->msgs_index + 1;
>> +     else
>> +             return ret;
>> +}
>> +
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
