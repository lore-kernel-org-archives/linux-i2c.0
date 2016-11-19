From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [RFC PATCH v2 5/7] iio: multiplexer: new iio category and iio-mux
 driver
Date: Sat, 19 Nov 2016 23:08:19 +0100
Message-ID: <365eb334-d27a-e91b-7ca7-9e10c7ede9a6@axentia.se>
References: <1479419289-17553-1-git-send-email-peda@axentia.se>
 <1479419289-17553-6-git-send-email-peda@axentia.se>
 <e462780e-305b-2cb9-1acd-c66dee312fac@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e462780e-305b-2cb9-1acd-c66dee312fac-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2016-11-19 16:49, Jonathan Cameron wrote:
> On 17/11/16 21:48, Peter Rosin wrote:
>> When a multiplexer changes how an iio device behaves (for example
>> by feeding different signals to an ADC), this driver can be used
>> create one virtual iio channel for each multiplexer state.
>>
>> Depends on the generic multiplexer driver.
> I'm not really following what all the ext info stuff in here is about.
> Could you add a little more description of that?

Certainly. I have two needs for this series. The first one is simple
when it comes to the iio part and complex because the mux is shared
between three 8-way muxes on three of the inputs to an ADS-1015 ADC.
The forth ADC line to the ADS-1015 is not muxed. Those three muxes
are of course GPIO-controlled and share GPIO pins. And the GPIO
pins also control an i2c bus that is muxed 8-ways as well. There are
eight (possible) batteries, and we monitor voltage/current/temp with
the 3 muxed ADC lines, and 8 chargers sit on i2c behind the i2c mux.
I guess it felt natural for the HW designer to select battery with
the GPIO lines, but that do not fit too well with the code as it
is without this series...

For this first need, the iio mux does not need ext_info.

The second need is simple in the mux part but worse in the iio
department. It's another 8-way mux that simply muxes an ADC line,
so that is simple. However, the ADC line is the envelope detector
that just got added to linux-next, and it has two ext_info
attributes that needs to be set differently for different mux
states. Two of the states need "invert" to be false, the rest need
"invert" to be true. And it is also preferable to have different
values for "compare_interval" for different mux states since the
signals on the diffrent mux states have the different frequency
characteristics.

True, I could have the ext-info attributes go straight through
the mux, and just start by writing values to "invert"
and "compare_interval", and only then read a sample. But then I
would need to lock out other users during the duration of this
transaction. I believe that the best place to put that lock is
in the iio mux (when it locks its control-mux) and not leave it
to userspace to solve this in some brittle cooperative manner.

> Perhaps an example of how it is used and what the resulting interface
> looks like?

The resulting interface is just a copy of the (ext_info) interface
exposed by the parent channel (with a cache that is rewritten to
the parent on every iio mux state change). I have plans to add code
to not rewrite ext_info attributes that have never been changed in
any mux state.

Below I have an example file listing.

device0 is a dpot (mcp4561).
device1 is a dac  (dpot-dac, wrapping the above dpot).
device2 is an adc (envelope-detector, wrapping the above dac)
device3 is a mux  (iio-mux, wrapping the above adc)

The 8-way iio-mux have no signals attached on mux states 0 and 1, which
is why the first channel for device 3 is in_altvoltage2.

Ultimately, I would like some knob to hide devices 0, 1 and 2 from
userspace. They need/should only be visible to in-kernel users. Or
is there such a knob already?

Cheers,
Peter

$ ls /sys/bus/iio/devices/iio\:device*
/sys/bus/iio/devices/iio:device0:
dev                           out_resistance_raw_available
name                          out_resistance_scale
of_node                       power
out_resistance0_raw           subsystem
out_resistance1_raw           uevent

/sys/bus/iio/devices/iio:device1:
dev                         out_voltage0_scale
name                        power
of_node                     subsystem
out_voltage0_raw            uevent
out_voltage0_raw_available

/sys/bus/iio/devices/iio:device2:
dev                              name
in_altvoltage0_compare_interval  of_node
in_altvoltage0_invert            power
in_altvoltage0_raw               subsystem
in_altvoltage0_scale             uevent

/sys/bus/iio/devices/iio:device3:
dev                              in_altvoltage5_raw
in_altvoltage2_compare_interval  in_altvoltage5_scale
in_altvoltage2_invert            in_altvoltage6_compare_interval
in_altvoltage2_raw               in_altvoltage6_invert
in_altvoltage2_scale             in_altvoltage6_raw
in_altvoltage3_compare_interval  in_altvoltage6_scale
in_altvoltage3_invert            in_altvoltage7_compare_interval
in_altvoltage3_raw               in_altvoltage7_invert
in_altvoltage3_scale             in_altvoltage7_raw
in_altvoltage4_compare_interval  in_altvoltage7_scale
in_altvoltage4_invert            name
in_altvoltage4_raw               of_node
in_altvoltage4_scale             power
in_altvoltage5_compare_interval  subsystem
in_altvoltage5_invert            uevent
