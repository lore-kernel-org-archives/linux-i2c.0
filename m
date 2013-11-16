From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Problem with multiple i2c multiplexers on one bus, and mux bus naming
Date: Sat, 16 Nov 2013 10:31:00 -0800
Message-ID: <5287B9E4.1020107@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

I have an interesting situation with multiple i2c multiplexers (pca9548) on a single i2c bus.

The problem with this is that multiple mux i2c adapters and up with the same name,
"i2c-N-mux (chan_id M)", where N is the parent bus number and M is the mux channel.
This makes it difficult to identify the actual mux chip serving a mux adapter.

Here is an example with two pca9548 in a system, both connected to i2c bus 2 (which is
itself a mux connected to bus 0).

# grep . */name
i2c-0/name:MPC adapter at 0xfff703000
i2c-1/name:MPC adapter at 0xfff703100
i2c-10/name:i2c-2-mux (chan_id 7)
i2c-11/name:i2c-2-mux (chan_id 0)
i2c-12/name:i2c-2-mux (chan_id 1)
i2c-13/name:i2c-2-mux (chan_id 2)
i2c-14/name:i2c-2-mux (chan_id 3)
i2c-15/name:i2c-2-mux (chan_id 4)
i2c-16/name:i2c-2-mux (chan_id 5)
i2c-17/name:i2c-2-mux (chan_id 6)
i2c-18/name:i2c-2-mux (chan_id 7)
i2c-19/name:i2c-0-mux (chan_id 1)
i2c-2/name:i2c-0-mux (chan_id 0)
i2c-20/name:i2c-0-mux (chan_id 2)
i2c-21/name:i2c-0-mux (chan_id 3)
i2c-22/name:i2c-0-mux (chan_id 4)
i2c-23/name:i2c-0-mux (chan_id 5)
i2c-24/name:i2c-0-mux (chan_id 6)
i2c-25/name:i2c-0-mux (chan_id 7)
i2c-3/name:i2c-2-mux (chan_id 0)
i2c-4/name:i2c-2-mux (chan_id 1)
i2c-5/name:i2c-2-mux (chan_id 2)
i2c-6/name:i2c-2-mux (chan_id 3)
i2c-7/name:i2c-2-mux (chan_id 4)
i2c-8/name:i2c-2-mux (chan_id 5)
i2c-9/name:i2c-2-mux (chan_id 6)

In this example, i2c-3 and i2c-11 share the same name, as do i2c-4 and i2c-12 and so on.
If I now have, say, temperature sensors on address 0x49 on both i2c-3 and i2c-11,
I have no means to determine the location of those temperature sensors. Sure,
I can figure it out manually, but if something changes in bus numbering I have
to start all over again.

Would it be possible to add the chip address into the mux name ? Something like
	i2c-N-XX-M-mux
where N is the parent bus number, XX is the mux i2c address, and M is the mux channel.
I understand this may require an API change, as the mux chip is not necessarily an i2c
and the i2c-mux core code doesn't really care what the mux chip is. So maybe there is
a different/better solution; ultimately, what I need is really a means to identify
the mux chip if there are multiple muxes on a single i2c bus. And, of course, unique
i2c adapter names would be nice to have as well.

Is there another way to identify the mux adapter chip through sysfs in this situation ?

Thanks,
Guenter
