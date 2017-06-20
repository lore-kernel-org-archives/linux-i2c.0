From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 19 Jun 2017 21:02:46 -0700
Message-ID: <CAFd5g471kpgskO1MkBPZgFLbwAqncT_NZy=igVRkYJpxDNRVyg@mail.gmail.com>
References: <20170603012952.2192-1-brendanhiggins@google.com>
 <20170603012952.2192-5-brendanhiggins@google.com> <20170619141322.devvmcbjaeq4jnv5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170619141322.devvmcbjaeq4jnv5@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Kachalov Anton <mouse-Pma6HLj0uuo@public.gmane.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg-Bxea+6Xhats@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ryan Chen <ryan_chen-SAlXDmAnmOAqDJ6do+/SaQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I thought all of the comments made sense and will be addressed in my
next revision,
except the following:

>> +static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>> +{
>> +     unsigned long time_left, flags;
>> +     int ret = 0;
>> +     u32 command;
>> +
>> +     spin_lock_irqsave(&bus->lock, flags);
>> +     command = readl(bus->base + ASPEED_I2C_CMD_REG);
>> +
>> +     if (command & ASPEED_I2CD_SDA_LINE_STS) {
>> +             /* Bus is idle: no recovery needed. */
>> +             if (command & ASPEED_I2CD_SCL_LINE_STS)
>> +                     goto out;
>> +             dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
>> +                     command);
>> +
>> +             reinit_completion(&bus->cmd_complete);
>> +             writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
>> +             spin_unlock_irqrestore(&bus->lock, flags);
>> +
>> +             time_left = wait_for_completion_timeout(
>> +                             &bus->cmd_complete, bus->adap.timeout);
>> +
>> +             spin_lock_irqsave(&bus->lock, flags);
>> +             if (time_left == 0)
>> +                     goto reset_out;
>> +             else if (bus->cmd_err)
>> +                     goto reset_out;
>> +             /* Recovery failed. */
>> +             else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
>> +                        ASPEED_I2CD_SCL_LINE_STS))
>> +                     goto reset_out;
>> +     /* Bus error. */
>> +     } else {
>> +             dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
>> +                     command);
>
> Same dbg message as in the condition? Move it out of the 'if'?

Message is the same; that's true; however, I only want to print this
if I am actually doing
the recovery. There is a case in the first condition where we actually
don't attempt recovery.
(See both SDA and SCL high). Nevertheless, now that I am looking at
this. I think it might
make sense to make the dbg statements different since I can explain
what type of recovery
I am attempting.

>
>> +
>> +             reinit_completion(&bus->cmd_complete);
>> +             writel(ASPEED_I2CD_BUS_RECOVER_CMD,
>> +                    bus->base + ASPEED_I2C_CMD_REG);
>
> Out of interest: What does the RECOVER_CMD do?

According to the documentation, it attempts to create 1 to 8 SCL
cycles to force any stuck
device to let go of the SDA line. It then puts the hardware in a sane
state once it detects
that the bus has been recovered. I will put a comment to this effect.

>
>> +             spin_unlock_irqrestore(&bus->lock, flags);
>> +
>> +             time_left = wait_for_completion_timeout(
>> +                             &bus->cmd_complete, bus->adap.timeout);
>> +
>> +             spin_lock_irqsave(&bus->lock, flags);
>> +             if (time_left == 0)
>> +                     goto reset_out;
>> +             else if (bus->cmd_err)
>> +                     goto reset_out;
>> +             /* Recovery failed. */
>> +             else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
>> +                        ASPEED_I2CD_SDA_LINE_STS))
>> +                     goto reset_out;
>> +     }
>> +
>> +out:
>> +     spin_unlock_irqrestore(&bus->lock, flags);
>> +
>> +     return ret;
>> +
>> +reset_out:
>> +     spin_unlock_irqrestore(&bus->lock, flags);
>> +
>> +     return aspeed_i2c_reset(bus);
>> +}

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
