From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
Date: Fri, 13 Sep 2013 17:14:56 +0200
Message-ID: <52332BF0.4060605@samsung.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <20130913065434.GZ7393@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-i2c@vger.kernel.org

On 09/13/2013 08:54 AM, Mika Westerberg wrote:
> On Thu, Sep 12, 2013 at 02:34:21PM -0700, Kevin Hilman wrote:
>>> > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>> > > index f32ca29..44374b4 100644
>>> > > --- a/drivers/i2c/i2c-core.c
>>> > > +++ b/drivers/i2c/i2c-core.c
>>> > > @@ -248,11 +248,30 @@ static int i2c_device_probe(struct device *dev)
>>> > >  					client->flags & I2C_CLIENT_WAKE);
>>> > >  	dev_dbg(dev, "probe\n");
>>> > >  
>>> > > +	/* Make sure the adapter is active */
>>> > > +	pm_runtime_get_sync(&client->adapter->dev);
>>> > > +
>>> > > +	/*
>>> > > +	 * Enable runtime PM for the client device. If the client wants to
>>> > > +	 * participate on runtime PM it should call pm_runtime_put() in its
>>> > > +	 * probe() callback.
>>> > > +	 */
>>> > > +	pm_runtime_get_noresume(&client->dev);
>>> > > +	pm_runtime_set_active(&client->dev);
>> > 
>> > Why the set_active here?
>> > 
>> > For hardware that is disabled/powered-off on startup, there will now be
>> > a mismatch between the hardware state an the RPM core state.
>
> The call to pm_runtime_get_noresume() should make sure that the device is
> in active state (at least in state where it can access the bus) if I'm
> understanding this right.

I can't see how this would happen. How runtime_resume/runtime_suspend
callbacks would get invoked with this code, if, e.g. originally driver called 
pm_runtime_enable(), pm_runtime_get_sync(), pm_runtime_put_sync() in probe() ? 

pm_runtime_get_noresume() merely increments usage counter of a device. 
It seems that these changes will break the s5p-tv driver. I might be missing 
something though.

As Mark pointed out this is currently unwanted behaviour to runtime PM
activate a bus controller device manually in the core for when the client's
probe() is executed, since i2c core will activate the bus controller for when 
transfer is being carried out.  
But I can understand this is needed for ACPI and it shouldn't break existing
drivers, that do runtime PM activate the client device in probe().

Now I'm sure this will break power management of the drivers/media/exynos4-is
driver, due to incorrect power sequence (power domain and clocks handling).
I'll try to take care of it in separate patch, as I have some patches pending,
that move most of code from drivers/media/exynos4-is/fimc-is-sensor.c to 
drivers/media/i2c/s5k6a3.c.

--
Regards,
Sylwester
