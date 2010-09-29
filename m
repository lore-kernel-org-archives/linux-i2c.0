From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Race in i2c_new_device()
Date: Wed, 29 Sep 2010 14:52:13 +0200
Message-ID: <20100929145213.262715c5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael, Rodolfo, David,

I found a race condition in function i2c_new_device():

	/* Check for address business */
	status = i2c_check_addr_busy(adap, client->addr);
	if (status)
		goto out_err;

	client->dev.parent = &client->adapter->dev;
	client->dev.bus = &i2c_bus_type;
	client->dev.type = &i2c_client_type;
#ifdef CONFIG_OF
	client->dev.of_node = info->of_node;
#endif

	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
		     client->addr);
	status = device_register(&client->dev);
	if (status)
		goto out_err;

i2c_check_addr_busy() relies on the device tree maintained by the
driver core to figure out whether an address is busy. This tree is
updated only when device_register() returns. This means that, in the
event where i2c_new_device() is run twice in parallel for the same
address on related I2C segments, both may pass the
i2c_check_addr_busy() check, and then either one of the
device_register() calls will fail with the driver code complaining
about duplicate bus_id (which could already happen in previous kernels,
as the race condition isn't new) or both will succeed and we end up
with a parent and child I2C segments with an i2c client at the same
address - which is wrong. This last case is new, and possible only
since multiplexing support was added.

I was about to add a new mutex protecting this code flow, but suddenly
realized that it might deadlock when registering i2c multiplexer
devices. For such devices, the probe function will register i2c
adapters, on which i2c_scan_static_board_info() may be called, which in
turn will call i2c_new_device(). So anyone describing multiplexed
topologies as static board information will hit the deadlock.

At this point, I am rather clueless if and how this problem should be
solved, so I would welcome suggestions.

Maintaining our own list of busy addresses would probably work, however
we tried hard to get rid of duplicate housekeeping work in the past few
years and I would be very unhappy if we have to go backwards.

Another possibility is to ignore the issue and consider this check as
best effort. It can only fail if the provided device information is
incorrect, in which case it will have to be fixed anyway. In that case,
we can discuss whether it makes sense to keep i2c_check_addr_busy(), if
we know it's not 100% reliable, we might as well do without it. The
only benefit I see in keeping it is that it should make it easier to
spot the error and correct it.

Opinions?

Thanks,
-- 
Jean Delvare
