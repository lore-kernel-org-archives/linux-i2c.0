From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 26 Nov 2012 18:21:25 +0530
Message-ID: <CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA@mail.gmail.com>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
	<50B20670.5070509@pcserviceselectronics.co.uk>
	<CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>
	<50B35642.7030104@pcserviceselectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B35642.7030104-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 26 November 2012 17:15, Paul Carpenter
<paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
> Unless you know why the bus is stuck, how can you reset reminder this
> method ONLY works if SCL is high and SDA probably was low and the slave
> device is what is stuck in wrong state. NOTE SCL and SDA high can be
> considered as BUS IDLE or having passed SDA = 1 waiting next clock edge
> or state transition without other state information.
>
> From i2c protocol Rev. 03 section 3.1.16 titled "Bus clear" first bit -
>
>   "In the unlikely event where the clock (SCL) is stuck LOW, the
>    preferential procedure is to reset the bus using the HW reset signal
>    if your I2C devices have HW reset inputs. If the I2C devices do not
>    have HW reset inputs, cycle power to the devices to activate the
>    mandatory internal Power-On Reset (POR) circuit."
>
> So if you do not check that SCL is NOT stuck Low the rest will just do
> nothing, it wont clear the bus and the fault will not be reported.
> The open drain nature of the bus means that you may attempt to toggle it
> but if SCL is stuck low nothing will happen on the bus.
>
> Attempting to configure an SCL drive as any form of high driving output
> will create a situation that when the SCL is driven high a high driver
> on the GPIO will be driving into a stuck low situation potentially
> creating a short between a power source and a power sink, that in most
> cases will damage or shorten life of one or both ends.
>
> In over 10 years of using I2C in various forms the only times I have
> seen bus stuck or device in wrong state
>
> 1/ Some code changed a bus switch when Bus was NOT idle
>         i.e mid transaction
> 2/ Bit-banged I2C software was wrong incomplete transaction
> 3/ Short on bus
> 4/ Faulty device
> 5/ Faulty design so 1 and 0 thresholds were compromised
>
> If you ever support multi-master you need to monitor SCL to ensure your
> clock toggling is doing what you expect.

Hi Paul,

I completely agree with what you said, and i also feel the need of it now.
We don't have a solution for SCL stuck low, just by playing with pad values.
And need some sort of reset of device, etc as mentioned by you earlier.

What we can do here, is check SCL's value and give an error message for
SCL stuck low + return error.

The short circuit mentioned earlier will not happen in our case as we
are setting gpio flags as OPEN_DRAIN and so we would never be writing
1 on SCL pad.

Though i would still need confirmation from Wolfram before implementing
this change.

>> Checking that would be tricky. For GPIO recovery, we have to make it GPIO
>> first in input mode and read its value. Right?
>
>
> Depends on the GPIO, some even when set as output can still be read as
> that is the way the GPIO registers are constructed in some cases.

Yes. Probably can read it in output mode too.

--
viresh
