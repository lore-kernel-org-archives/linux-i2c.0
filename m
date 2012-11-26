From: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 26 Nov 2012 11:45:06 +0000
Message-ID: <50B35642.7030104@pcserviceselectronics.co.uk>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>	<50B20670.5070509@pcserviceselectronics.co.uk> <CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Viresh Kumar wrote:
> On 25 November 2012 17:22, Paul Carpenter
> <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
>> Viresh Kumar wrote:
>>> Add i2c bus recovery infrastructure to i2c adapters as specified in the
>>> i2c
>>> protocol Rev. 03 section 3.1.16 titled "Bus clear".
>>>
>>> http://www.nxp.com/documents/user_manual/UM10204.pdf
>> You should also take note of section 3.1.14 and its notes on Software
>> Reset -
>>     "Precautions must be taken to ensure that a device is not
>>      pulling down the SDA or SCL line after applying the supply
>>      voltage, since these low levels would block the bus"
> 
> Hmm.. This patch has taken a very long time for being accepted, and the
> reason for that was, it was generalizing much more than what is required.
> 
> And I am not sure, if checking SCL low would be considered like that only. :)
> 
> @Wolfram: I would need your point of view on that, before trying it out.

Unless you know why the bus is stuck, how can you reset reminder this
method ONLY works if SCL is high and SDA probably was low and the slave 
device is what is stuck in wrong state. NOTE SCL and SDA high can be 
considered as BUS IDLE or having passed SDA = 1 waiting next clock edge
or state transition without other state information.

 From i2c protocol Rev. 03 section 3.1.16 titled "Bus clear" first bit -

   "In the unlikely event where the clock (SCL) is stuck LOW, the
    preferential procedure is to reset the bus using the HW reset signal
    if your I2C devices have HW reset inputs. If the I2C devices do not
    have HW reset inputs, cycle power to the devices to activate the
    mandatory internal Power-On Reset (POR) circuit."

So if you do not check that SCL is NOT stuck Low the rest will just do
nothing, it wont clear the bus and the fault will not be reported.
The open drain nature of the bus means that you may attempt to toggle it
but if SCL is stuck low nothing will happen on the bus.

Attempting to configure an SCL drive as any form of high driving output
will create a situation that when the SCL is driven high a high driver
on the GPIO will be driving into a stuck low situation potentially
creating a short between a power source and a power sink, that in most
cases will damage or shorten life of one or both ends.

In over 10 years of using I2C in various forms the only times I have
seen bus stuck or device in wrong state

1/ Some code changed a bus switch when Bus was NOT idle
	i.e mid transaction
2/ Bit-banged I2C software was wrong incomplete transaction
3/ Short on bus
4/ Faulty device
5/ Faulty design so 1 and 0 thresholds were compromised

If you ever support multi-master you need to monitor SCL to ensure your
clock toggling is doing what you expect.

>>> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
>>> +{
>>> +    struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>>> +    struct device *dev = &adap->dev;
>>> +    int ret = 0;
>> Where is the check that SCL is NOT low (bus fault or device doing clock
>> stretching)
> 
> Pending for Wolfram's point of view :)
> 
>>> +static int i2c_generic_recovery(struct i2c_adapter *adap)
>>> +{
>>> +    /*
>>> +     * By this time SCL is high, as we need to give 9 falling-rising
>>> edges
>>> +     */
>> In my view that needs to be done by an actual check of the real SCL not
>> assumption.
> 
> Checking that would be tricky. For GPIO recovery, we have to make it GPIO
> first in input mode and read its value. Right?

Depends on the GPIO, some even when set as output can still be read as
that is the way the GPIO registers are constructed in some cases.

-- 
Paul Carpenter          | paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
<http://www.gnuh8.org.uk/>  GNU H8 - compiler & Renesas H8/H8S/H8 Tiny
<http://www.badweb.org.uk/> For those web sites you hate
