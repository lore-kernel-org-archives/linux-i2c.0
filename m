From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Fri, 27 Feb 2009 10:36:04 +0100
Message-ID: <go8c65$o7g$1@ger.gmane.org>
References: <gngvea$eqj$1@ger.gmane.org>	<20090218173645.GD3049@pengutronix.de>	<gnjplc$hqd$1@ger.gmane.org>	<20090220135300.353cd53a@hyperion.delvare>	<go12jd$ec4$1@ger.gmane.org>	<20090225090002.2c31dbf1@hyperion.delvare>	<go5ta2$rtu$1@ger.gmane.org> <20090226142854.2b6f72e4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090226142854.2b6f72e4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Jean Delvare said the following:
> Hi Michael,
> 
> On Thu, 26 Feb 2009 12:09:52 +0100, Michael Lawnick wrote:
>> Jean Delvare said the following:
>> > On Tue, 24 Feb 2009 16:09:33 +0100, Michael Lawnick wrote:
>> >> The idea: when deferring the instantiation of the adapters of MUX1,
>> >> there should be something like a hot-plug event.
>> >> AFAIK, after adding an adapter via i2c_add_numbered_adapter(), the I2C
>> >> subsystem will probe for all currently known clients on this new bus.
>> >> Correct?
>> >> If so, this should cascade through the newly plugged in board.
>> > 
>> > For I2C chip drivers which do device autodetection (lm75 and eeprom are
>> > amongst them but for example at24 is not) yes. For other drivers (say
>> > at24) there should be a board definition for the new i2c bus segment.
>> 
>> I don't get the point here. The problem of correct identification will
>> have to be solved in any case.
> 
> I have no idea what you mean here, sorry. Correct identification of
> what?
> 
Probably I'm still hanging around with what you might call the legacy
model. When I started with I2C devices in LINUX, I supported the
I2C-device driver with possible I2C addresses in array normal_i2c[].
I2C Subsystem then called for every adapter and address
.attach_adapter->i2c_probe->myProbe() which tries to identify whether
the I2C device at given bus/address is really the applicable device.
myProbe() returned 0 or an error as an initialization and test result.
This was my starting point in this thread. You sound as if this no
longer supported to be used that way?!
Again I find me not understanding what the differences are between
'legacy' and 'new' model. :-(

...

> Alternatively, if you know the I2C bus number, you can get a pointer to
> the i2c_adapter in question using i2c_get_adapter(), and pass the
> result to i2c_new_device(). Don't forget to call i2c_put_adapter() when
> you're done.
> 
Ok, I will check.

...

> I think you really need to clear up you mind with the concepts of
> device and driver. There is no such thing as an "instance of a driver".
> When you load an I2C device driver module, there's (normally) only one
> driver that is registered, regardless of the number of current or
> future supported I2C devices in the system. I2C device instances (which
> we tend to name "I2C clients" in the Linux kernel) can then come and go
> at any point in time. Reloading the module has zero effect; it's
> neither required nor even useful.

What I call an instance is the equivalent of the resulting entry in
/sys/bus/i2c/devices
Adding a new entry on runtime for an already loaded I2C device driver
module is my quest.

> 
>> So far I have seen, the new model assumes a static network of devices
>> that can be initialized on boot strap. Information for this is taken
>> from device tree or kernel configuration data.
> 
> This is one of the 3 ways the new model can work, yes.
> 
And the other 2?

>> What I need is a user space initiated additional registration of a device.
> 
> While this could be implemented (see my short proposals above) I never
> meant it to be used beyond debugging or temporary workaround.
> Instantiating devices from user-space suggests that user-space knows
> things about the hardware which the kernel itself doesn't know, this
> doesn't sound exactly right.
> 
As hot plug isn't supported in I2C, it is the typical case that user
space is the first who knows that there is a new device.
Oh, probably I see the difference in our views: You might think of I2C
as a silly additional part of bigger devices. The initialization of the
big device then does include the announcement of the I2C sub part.
Well, I'm handling I2C as completely standalone system. There is no
bigger device. The I2C device is just mapped into sysFs, controlling is
done via user space applications. For me I2C is more like a bus system
like PCI, where devices get plugged in and out.

>> I have the typical S/W engineers problem: no H/W, no documentation, but
>> should design and implement a system that has to run out of the box when
>> first version of H/W arrives ;-)
> 
> And you have the additional typical problem that stubborn kernel
> subsystem maintainers can't read your mind and magically figure out
> what you need and implement it in the day.

;-) And therefore I'm searching for a tool to read the maintainer's mind
to find out what the code he made should work like. (Btw. this tool is
customarily called documentation |)
                                 V
> 
>> Therefore I asked for links in the OP so I can understand the idea of
>> the so called 'new I2C model'. The kernel documentation seems not to be
>> sufficient to achieve my goals.
...
-- 
Kind regards,
Michael
