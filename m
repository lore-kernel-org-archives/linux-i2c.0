From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: Dynamically-allocated i2c_device_id vs MODULE_DEVICE_TABLE
Date: Mon, 26 Jan 2009 12:06:01 -0600
Message-ID: <ed82fe3e0901261006u2223ccb3n5d7b3be9a85df7c7@mail.gmail.com>
References: <497A3097.1030808@freescale.com>
	 <20090124165040.GL8032@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090124165040.GL8032-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jan 24, 2009 at 10:50 AM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> you seem to have managed to short-circuit part of the device
> creation process. You do not need to pass the data via the device
> driver, you should pass it when creating the device.

Yes, I think my code is broken.

> If you look at i2c_board_info which can be passed into i2c_new_device
> or similar functions, there is a platform_data field you can fill out
> and this is passed in to your probe routine in the i2c device.

I don't think this will work for me.  I'm running this on a PowerPC
system, and we use a device tree to represent the I2C devices on the
various I2C buses.  My driver does not call i2c_new_device.  This is
done for me in of_register_i2c_devices().  As soon as my driver calls
i2c_add_driver(), my I2C probe function will be called, once for each
I2C device defined in the device tree.  So I don't think I can update
the i2c_board_info structure.

>
> --
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>
>  'a smiley only costs 4 bytes'
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Timur Tabi
Linux kernel developer at Freescale
