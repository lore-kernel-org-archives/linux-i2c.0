From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Add detection capability to new-style
 drivers
Date: Fri, 6 Jun 2008 16:17:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0806061550510.10290@shell4.speakeasy.net>
References: <20080606145212.76f95d52@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080606145212.76f95d52-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 6 Jun 2008, Jean Delvare wrote:
> The mechanism behind the device detection callback is as follows:
> * When a new-style i2c_driver is added, for each existing i2c_adapter,
>   address_data (those format is the same as what i2c_probe() is already
>   using for legacy drivers) is processed by i2c-core. For each relevant
>   address, the detect callback will be called, with a pointer to an
>   empty struct i2c_board_info address as the last parameter. The detect
>   callback will attempt to identify a supported device at the given
>   address, and if successful, it will fill the struct i2c_board_info
>   with the parameters required to instantiate a new-style i2c device.

Isn't the detect callback going to be the same for almost every driver?

It seems like you could have the i2c core do the detection.  Take the "to
be probed" addresses listed by the driver, do a standard i2c probe on them,
and pass a device to the driver's probe function if something is detected.
The probe function is of course free to return ENODEV if it has some
additional way to check for device presence.  If an address is on the force
list, then the device is created and passed to the driver's probe without
the core doing any kind of i2c probe.  The driver can do a non-standard
probe if it has one and return ENODEV if nothing is there.

> * When a new i2c_adapter is added, for each existing new-style
>   i2c_driver, the same happens.

It would nice if there was a no-probe option when creating an i2c_adapter.
Some hardware doesn't support probing of any kind, usually because there is
no way to detect a NAK.  In some cases the creator of the i2c_adapter knows
exactly what's on the bus it's creating and doesn't want whatever random
i2c drivers happen to be loaded to probe it.  For instance, the ivtv TV
card driver knows what tuners are on the i2c bus, while the bttv driver
doesn't.  The ivtv driver could use this to prevent an i2c driver used by
bttv from probing ivtv's i2c bus.

> * When it gets a filled struct i2c_board_info from a detect callback,
>   i2c-core will instantiate it. If a new-style driver exists for the
>   device, it will be able to bind with the device.
> * We keep track of the devices created that way, in a per-driver list.
> * When a new-style i2c_driver is removed, all devices that originate
>   from it are destroyed.

Is it necessary to remove the devices?  They are still there after all.
It's perfectly normal to have devices with no drivers loaded for them on
other busses.

> * When an i2c_adapter is removed, all devices on it that were created
>   as the result of calling a detect callback, are destroyed.

Shouldn't all devices on it, no matter how they were created, be removed?
Or is that the case?

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
