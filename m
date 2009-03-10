From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help on selecting one (and only one) i2c bus
Date: Tue, 10 Mar 2009 16:30:44 +0100
Message-ID: <20090310163044.571e4aff@hyperion.delvare>
References: <000001c9a0c6$bf92af80$b23e81a4@par.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <000001c9a0c6$bf92af80$b23e81a4-J7BnVcvkGbbQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ayman,

On Mon, 9 Mar 2009 15:52:56 +0100, Ayman KHAMOUMA wrote:
> I'm new on I2C device drivers programming and I'm facing a little problem, I can't find how to select my i2c-0 bus (I have 3 of them: i2c-0, i2c-1 and i2c-2) I'd like my probe function to probe only this bus and ignore the others.
> I guess I can find the solution with the i2c_address_data structure, but I don't really understand how to use it...

It would help if you would first tell us what kernel version you are
using, what device you are writing a driver for, and what
architecture / system type this is all working on.

> Do I have to use the ignore_range array ?

ignore_range has gone away long ago. The last kernel that had it was
2.6.12.6, released in late August 2005. Are really you using such an
old kernel?

> Once filed, I have nothing to do ?
> 
> The device I want to probe/send data to is located on bus i2c-0 and at the adresses 0x00 to 0x15

I seriously doubt this. Addresses 0x00, 0x01 and 0x02 are very special
for I2C, no device can use them. I suspect you are mixing register
addresses (the map of which is internal and specific to each device)
with device addresses on the bus.

> I guess I have to do:
> static unsigned short ignore_range[] = { 0x00, 0x16, 0xff, 0x01, 0x00, 0xff, 0x02, 0x00, 0xff, I2C_CLIENT_END };
> 
> Am I right ?

No, this is seriously wrong. But I can't tell more without additional
information about what you are trying to achieve in the first place.

-- 
Jean Delvare
