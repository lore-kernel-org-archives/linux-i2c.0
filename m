From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Thu, 26 Feb 2009 14:28:54 +0100
Message-ID: <20090226142854.2b6f72e4@hyperion.delvare>
References: <gngvea$eqj$1@ger.gmane.org>
	<20090218173645.GD3049@pengutronix.de>
	<gnjplc$hqd$1@ger.gmane.org>
	<20090220135300.353cd53a@hyperion.delvare>
	<go12jd$ec4$1@ger.gmane.org>
	<20090225090002.2c31dbf1@hyperion.delvare>
	<go5ta2$rtu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <go5ta2$rtu$1@ger.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Thu, 26 Feb 2009 12:09:52 +0100, Michael Lawnick wrote:
> Jean Delvare said the following:
> > On Tue, 24 Feb 2009 16:09:33 +0100, Michael Lawnick wrote:
> >> The idea: when deferring the instantiation of the adapters of MUX1,
> >> there should be something like a hot-plug event.
> >> AFAIK, after adding an adapter via i2c_add_numbered_adapter(), the I2C
> >> subsystem will probe for all currently known clients on this new bus.
> >> Correct?
> >> If so, this should cascade through the newly plugged in board.
> > 
> > For I2C chip drivers which do device autodetection (lm75 and eeprom are
> > amongst them but for example at24 is not) yes. For other drivers (say
> > at24) there should be a board definition for the new i2c bus segment.
> 
> I don't get the point here. The problem of correct identification will
> have to be solved in any case.

I have no idea what you mean here, sorry. Correct identification of
what?

> > This might be a little difficult to implement with the traditional
> > i2c_register_board_info() due to the hotplug nature is not all plugins
> > have the same set of I2C chips. But some custom code using
> > i2c_new_device() should do.
> 
> This would have to be done in kernel, doesn't it?

At the moment, yes. However, for some I2C drivers it is possible to
pass module parameters to force the instantiation of specific
i2c clients. This approach has shown its limits in the past (the most
problematic part being that the i2c adapter is identified by number,
while said number is usually not known in advance.)

> I dislike such an idea. 

I have been thinking about a way to instantiate (and destroy) i2c
clients from user-space. There are in fact two possible approaches. One
solely based on sysfs, where you would write the instantiation data to
a sysfs attribute file places in each i2c_adapter's directory. One
based on configfs. The former is much more simple and could be
implemented in a few hours, however it will not allow for fine-grained
device configuration. Anyway I didn't have the time to implement either
approach yet.

> Furthermore I raise the question of my previous posting again:
> For kernel space init I assume its a call to i2c_new_device(). Here I'm
> wondering where I should get the adapter info from.

I did answer this question already. But I can answer again.
i2c_new_device() is meant for I2C bus drivers which know what devices
are on the bus. The I2C bus driver does have a pointer to the
i2c_adapter, that it can pass to i2c_new_device().

Alternatively, if you know the I2C bus number, you can get a pointer to
the i2c_adapter in question using i2c_get_adapter(), and pass the
result to i2c_new_device(). Don't forget to call i2c_put_adapter() when
you're done.

> >> This defer could be implemented by removing auto instantiation (module
> >> parameter)
> > 
> > Auto instantiation only happens if the bus driver asks for it (through
> > an I2C_CLASS_* flag). If you don't want it, no need for a module
> > parameter, simply don't set any class flag.
>
> What was meant is the auto instantiation of sub controllers.

You presumably mean i2c bus segments.

> I'm talking based on i2c-pca954x.c posted by Rodolfo Giometti on
> 01/28/09. I can't see an class attribute there. So how gets it
> instantiated? Until now I assumed an automatic call of probe() for every
> host controller.

I didn't read Rodolfo's code yet (I would love to but I just can't find
the time, as I have many other ultra-urgent tasks accumulating since
the beginning of the month) but it I would expect the i2c-pca954x
driver to require platform data to determine the number of bus
segments, the mux combinations to read them, the class for each
segment, maybe the desired bus number for each segment, etc. I don't
think it is any realistic to expect a mux chip client to configure
itself automatically, especially when these mux chips can't be reliably
identified in the first place.

> > (...)
> > What is wrong with auto instantiation as it is implemented today?
>
> The point of time when it is done (AFAICS);-)

Yes, I agree this is a problem :( Currently I am fighting on the v4l
side to get rid of the legacy binding model. I don't see much point in
tackling other i2c-core issues before this is done, because the legacy
binding model gets in the way of about everything serious.

> (...)
> Until now I can see no way to initiate an additional instantiation of an
> I2C driver without reloading the module.

I think you really need to clear up you mind with the concepts of
device and driver. There is no such thing as an "instance of a driver".
When you load an I2C device driver module, there's (normally) only one
driver that is registered, regardless of the number of current or
future supported I2C devices in the system. I2C device instances (which
we tend to name "I2C clients" in the Linux kernel) can then come and go
at any point in time. Reloading the module has zero effect; it's
neither required nor even useful.

> So far I have seen, the new model assumes a static network of devices
> that can be initialized on boot strap. Information for this is taken
> from device tree or kernel configuration data.

This is one of the 3 ways the new model can work, yes.

> What I need is a user space initiated additional registration of a device.

While this could be implemented (see my short proposals above) I never
meant it to be used beyond debugging or temporary workaround.
Instantiating devices from user-space suggests that user-space knows
things about the hardware which the kernel itself doesn't know, this
doesn't sound exactly right.

> I have the typical S/W engineers problem: no H/W, no documentation, but
> should design and implement a system that has to run out of the box when
> first version of H/W arrives ;-)

And you have the additional typical problem that stubborn kernel
subsystem maintainers can't read your mind and magically figure out
what you need and implement it in the day.

> Therefore I asked for links in the OP so I can understand the idea of
> the so called 'new I2C model'. The kernel documentation seems not to be
> sufficient to achieve my goals.
> Currently I'm waiting for 2 MUXes and an LM75, so I can connect them to
> our current MUX-less board and start to play.

The documentation might not be perfect, right. It should become clearer
once we get completely rid of the legacy model. Contributions to
enhance the documentation are welcome, too.

-- 
Jean Delvare
