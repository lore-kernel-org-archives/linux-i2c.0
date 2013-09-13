From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client devices
Date: Fri, 13 Sep 2013 07:30:55 -0700
Message-ID: <87bo3whjz4.fsf@linaro.org>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
	<1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
	<87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130913065434.GZ7393@intel.com> (Mika Westerberg's message of
	"Fri, 13 Sep 2013 09:54:34 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-i2c@vger.kernel.org

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Thu, Sep 12, 2013 at 02:34:21PM -0700, Kevin Hilman wrote:
>> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> > index f32ca29..44374b4 100644
>> > --- a/drivers/i2c/i2c-core.c
>> > +++ b/drivers/i2c/i2c-core.c
>> > @@ -248,11 +248,30 @@ static int i2c_device_probe(struct device *dev)
>> >  					client->flags & I2C_CLIENT_WAKE);
>> >  	dev_dbg(dev, "probe\n");
>> >  
>> > +	/* Make sure the adapter is active */
>> > +	pm_runtime_get_sync(&client->adapter->dev);
>> > +
>> > +	/*
>> > +	 * Enable runtime PM for the client device. If the client wants to
>> > +	 * participate on runtime PM it should call pm_runtime_put() in its
>> > +	 * probe() callback.
>> > +	 */
>> > +	pm_runtime_get_noresume(&client->dev);
>> > +	pm_runtime_set_active(&client->dev);
>> 
>> Why the set_active here?
>> 
>> For hardware that is disabled/powered-off on startup, there will now be
>> a mismatch between the hardware state an the RPM core state.
>
> The call to pm_runtime_get_noresume() should make sure that the device is
> in active state (at least in state where it can access the bus) if I'm
> understanding this right.

No, after _get_noresume(), nothing happens to the hardware.  It simply
increments the usecount.  From pm_runtime.h:

static inline void pm_runtime_get_noresume(struct device *dev)
{
	atomic_inc(&dev->power.usage_count);
}

So after the _get_noresume() and _set_active() you're very likely to
have a disconnect between the hardware state and what state RPM thinks
the hardware is in.

Kevin
