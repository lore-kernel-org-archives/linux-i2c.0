From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help on selecting one (and only one) i2c bus
Date: Wed, 11 Mar 2009 12:22:57 +0100
Message-ID: <20090311122257.7c7805f0@hyperion.delvare>
References: <20090310163044.571e4aff@hyperion.delvare>
	<000301c9a237$e6d3c8f0$b23e81a4@par.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <000301c9a237$e6d3c8f0$b23e81a4-J7BnVcvkGbbQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ayman,

On Wed, 11 Mar 2009 11:55:22 +0100, Ayman KHAMOUMA wrote:
> After some researches I guess I have to use the normal_i2c and ignore
> arrays:
> 
> static unsigned short normal_i2c[] = { 0x71, I2C_CLIENT_END};
> static unsigned short ignore[] = { 0x01, 0x71, 0x02, 0x71, I2C_CLIENT_END};
> 
> static struct i2c_client_address_data addr_data = {
>     .normal_i2c = normal_i2c,
>     .ignore     = ignore,
> };
> 
> Int the init function I have to allocate a major to the driver, and than add
> the I2c driver:
> i2c_add_driver(&i2c_my_drv);
> 
> After doing that, i2c_my_drv.attach_adapter is called.
> 
> Which will call (among others) my probe function, in which I call
> i2c_attach_client.
> 
> 
> Am I in the right way ?

No. You're using the old, deprecated way to instantiate devices, and
you are abusing it (the ignore array wasn't meant to be used the way
you do.)

You said you're using kernel 2.6.23.17, it's not brand new, but it's
not too old either. At any rate, it already includes the new-style
device binding. So, instead of using the old binding model and then
fight to get your driver to _not_ attach to improper devices/addresses,
you should use the new model and explicitly instantiate your device, so
that your driver won't even try to bind to the wrong devices.

I have posted an explanation about how to do this recently:
http://marc.info/?l=linux-i2c&m=123659553713018&w=2

You should convert your driver to a new-style one and use either method
1 or method 2, whichever is easier for you. See the following document
for a guide on how to update your code:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/i2c/upgrading-clients;hb=HEAD

It's for kernel 2.6.26 and later but it should mostly apply to 2.6.23
too. The only big difference I can think of is that 2.6.23 doesn't have
struct i2c_device_id, instead the device driver binding is based on the
i2c driver name. I can help you with this if you can't figure it out.

As a side note, the fact that you needed to add buses 1 and 2 to the
ignore list suggests that something is wrong with your I2C bus driver.
It is rather unlikely that all 3 I2C buses on your system have a device
at address 0x71, so your old-style driver shouldn't have instantiated 3
devices. If it did, it strongly suggests that the quick write i2c-core
is using to check for the presence of a device at a given address
improperly reported success in all cases. You really should check your
I2C bus driver and in particular the implementation of 0-byte messages
before going further with the device driver.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
