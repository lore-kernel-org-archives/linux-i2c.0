From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Thu, 5 Mar 2009 15:57:13 +0100
Message-ID: <20090305155713.46ac1968@hyperion.delvare>
References: <gngvea$eqj$1@ger.gmane.org>
	<20090218173645.GD3049@pengutronix.de>
	<gnjplc$hqd$1@ger.gmane.org>
	<20090220135300.353cd53a@hyperion.delvare>
	<go12jd$ec4$1@ger.gmane.org>
	<20090225090002.2c31dbf1@hyperion.delvare>
	<go5ta2$rtu$1@ger.gmane.org>
	<20090226142854.2b6f72e4@hyperion.delvare>
	<go8c65$o7g$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/CzzQLkmw2mH+qLAa_tWejW7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <go8c65$o7g$1@ger.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--MP_/CzzQLkmw2mH+qLAa_tWejW7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Michael,

On Fri, 27 Feb 2009 10:36:04 +0100, Michael Lawnick wrote:
> Jean Delvare said the following:
> > I have no idea what you mean here, sorry. Correct identification of
> > what?
>
> Probably I'm still hanging around with what you might call the legacy
> model. When I started with I2C devices in LINUX, I supported the
> I2C-device driver with possible I2C addresses in array normal_i2c[].
> I2C Subsystem then called for every adapter and address
> .attach_adapter->i2c_probe->myProbe() which tries to identify whether
> the I2C device at given bus/address is really the applicable device.
> myProbe() returned 0 or an error as an initialization and test result.
> This was my starting point in this thread. You sound as if this no
> longer supported to be used that way?!

It is supported in a slightly different form.

> Again I find me not understanding what the differences are between
> 'legacy' and 'new' model. :-(

Differences are so important that I don't know where to start ;)

> > (...)
> > I think you really need to clear up you mind with the concepts of
> > device and driver. There is no such thing as an "instance of a driver".
> > When you load an I2C device driver module, there's (normally) only one
> > driver that is registered, regardless of the number of current or
> > future supported I2C devices in the system. I2C device instances (which
> > we tend to name "I2C clients" in the Linux kernel) can then come and go
> > at any point in time. Reloading the module has zero effect; it's
> > neither required nor even useful.
> 
> What I call an instance is the equivalent of the resulting entry in
> /sys/bus/i2c/devices

OK, device instance then.

> Adding a new entry on runtime for an already loaded I2C device driver
> module is my quest.

This will be done automatically if the bus segment hosting the new I2C
device is properly registered and the device can be detected using ID
registers.

> > This is one of the 3 ways the new model can work, yes.
>
> And the other 2?

I wrote a document explaining the 3 available methods. I am attaching
it to this mail. Please read it. If it is clear enough, I plan to add
it to Documentation/i2c. If it's no clear enough, well, ask your
additional questions and I'll try to improve the document.

> >> What I need is a user space initiated additional registration of a device.
> > 
> > While this could be implemented (see my short proposals above) I never
> > meant it to be used beyond debugging or temporary workaround.
> > Instantiating devices from user-space suggests that user-space knows
> > things about the hardware which the kernel itself doesn't know, this
> > doesn't sound exactly right.
>
> As hot plug isn't supported in I2C, it is the typical case that user
> space is the first who knows that there is a new device.
> Oh, probably I see the difference in our views: You might think of I2C
> as a silly additional part of bigger devices. The initialization of the
> big device then does include the announcement of the I2C sub part.
> Well, I'm handling I2C as completely standalone system. There is no
> bigger device. The I2C device is just mapped into sysFs, controlling is
> done via user space applications. For me I2C is more like a bus system
> like PCI, where devices get plugged in and out.

I2C as a system bus is perfectly valid and supported. This is what many
embedded systems use.

I2C bus control (such as declaration of which devices are there)
through sysfs doesn't exist today, but could be added for cases such as
yours. I also can see the value of making mux drivers have a standard
sysfs interface to disable some channels, to allow hot-plug scenarios
such as yours. But I'd rather integrate Rodolfo's work as is first, and
add features later. Even that promises to be slow...

-- 
Jean Delvare

--MP_/CzzQLkmw2mH+qLAa_tWejW7
Content-Type: text/plain; name=how-to-instantiate-i2c-devices.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=how-to-instantiate-i2c-devices.txt

How to instantiate I2C devices
==============================

Unlike PCI or USB devices, I2C devices are not enumerated at the hardware
level. Instead, the software must know which devices are connected on each
I2C bus segment, and what address these devices are using. For this
reason, the kernel code must instantiate I2C devices explicitly. There are
several ways to achieve this, depending on the context and requirements.


Method 1: Declare the I2C devices by bus number
-----------------------------------------------

This method is appropriate when the I2C bus is a system bus as is the case
for many embedded systems. On such systems, each I2C bus has a number
which is known in advance. It is thus possible to pre-declare the I2C
devices which live on this bus. This is done with an array of struct
i2c_board_info which is registered by calling i2c_register_board_info().

Example (from omap2 h4):

static struct i2c_board_info __initdata h4_i2c_board_info[] = {
	{
		I2C_BOARD_INFO("isp1301_omap", 0x2d),
		.irq		= OMAP_GPIO_IRQ(125),
	},
	{	/* EEPROM on mainboard */
		I2C_BOARD_INFO("24c01", 0x52),
		.platform_data	= &m24c01,
	},
	{	/* EEPROM on cpu card */
		I2C_BOARD_INFO("24c01", 0x57),
		.platform_data	= &m24c01,
	},
};

static void __init omap_h4_init(void)
{
	(...)
	i2c_register_board_info(1, h4_i2c_board_info,
			ARRAY_SIZE(h4_i2c_board_info));
	(...)
}

The above code declares 3 devices on I2C bus 1, including their respective
addresses and custom data needed by their drivers. When the I2C bus in
question is registered, the I2C devices will be instantiated automatically
by i2c-core.

The devices will be automatically unbound and destroyed when the I2C bus
they sit on goes away (if ever.)


Method 2: Instantiate the devices explicitly
--------------------------------------------

This method is appropriate when a larger device uses an I2C bus for
internal communication. A typical case is TV adapters. These can have a
tuner, a video decoder, an audio decoder, etc. usually connected to the
main chip by the means of an I2C bus. You won't know the number of the I2C
bus in advance, so the method 1 described above can't be used. Instead,
you can instantiate your I2C devices explicitly. This is done by filling
a struct i2c_board_info and calling i2c_new_device().

Example (from the sfe4001 network driver):

static struct i2c_board_info sfe4001_hwmon_info = {
	I2C_BOARD_INFO("max6647", 0x4e),
	.irq		= -1,
};

int sfe4001_init(struct efx_nic *efx)
{
	(...)
	efx->board_info.hwmon_client =
		i2c_new_device(&efx->i2c_adap, &sfe4001_hwmon_info);

	(...)
}

The above code instantiates 1 I2C device on the I2C bus which is on the
network adapter in question.

A variant of this is when you don't know for sure if an I2C device is
present or not (for example for an optional feature which is not present
on cheap variants of a board but you have no way to tell them apart), or
it may have different addresses from one board to the next (manufacturer
changing its design without notice). In this case, you can call
i2c_new_probed_device() instead of i2c_new_device().

Example (from the pnx4008 OHCI driver):

static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };

static int __devinit usb_hcd_pnx4008_probe(struct platform_device *pdev)
{
	(...)
	struct i2c_adapter *i2c_adap;
	struct i2c_board_info i2c_info;

	(...)
	i2c_adap = i2c_get_adapter(2);
	memset(&i2c_info, 0, sizeof(struct i2c_board_info));
	strlcpy(i2c_info.name, "isp1301_pnx", I2C_NAME_SIZE);
	isp1301_i2c_client = i2c_new_probed_device(i2c_adap, &i2c_info,
						   normal_i2c);
	i2c_put_adapter(i2c_adap);
	(...)
}

The above code instantiates up to 1 I2C device on the I2C bus which is on
the OHCI adapter in question. It first try at address 0x2c, if nothing is
found there it tries address 0x2d, and if still nothing is found, it
simply gives up.

The driver which instantiated the I2C device is responsible for destroying
it on cleanup. This is done by calling i2c_unregister_device() on the
pointer that was earlier returned by i2c_new_device() or
i2c_new_probed_device().


Method 3: Probe an I2C bus for certain devices
----------------------------------------------

Sometimes you do not have enough information about an I2C device, not even
to call i2c_new_probed_device(). The typical case is hardware monitoring
chips on PC mainboards. There are several dozen models, which can live
at 25 different addresses. Given the huge number of mainboards out there,
it is next to impossible to build an exhaustive list of the hardware
monitoring chips being used. Fortunately, most of these chips have
manufacturer and device ID registers, so they can be identified by
probing.

In that case, I2C devices are neither declared nor instantiated
explicitly. Instead, i2c-core will probe for such devices as soon as their
drivers are loaded, and if any is found, an I2C device will be
instantiated automatically. In order to prevent any misbehavior of this
mechanism, the following restrictions apply:
* The I2C device driver must implement the detect() method, which
  identifies a supported device by reading from arbitrary registers.
* Only buses which are likely to have a supported device and agree to be
  probed, will be probed. For example this avoids probing for hardware
  monitoring chips on a TV adapter.

Example:
See lm90_driver and lm90_detect() in drivers/hwmon/lm90.c

I2C devices instantiated as a result of such a successful probe will be
destroyed automatically when the driver which detected them is removed,
or when the underlying I2C bus is itself destroyed, whichever happens
first.

Those of you familiar with the i2c subsystem of 2.4 kernels and early 2.6
kernels will find out that this method 3 if essentially similar to what
was done there. Two significant differences are:
* Probing is only one way to instantiate I2C devices now, while it was the
  only way back then. Where possible, methods 1 and 2 should be preferred.
  Method 3 should only be used when there is no other way.
* I2C buses must now explicitly say which I2C driver classes can probe
  them (by the means of the class bitfield), while all I2C buses were
  probed by default back then.

--MP_/CzzQLkmw2mH+qLAa_tWejW7--
