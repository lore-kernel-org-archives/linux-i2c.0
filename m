From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Patch v3] i2c: Multiplexed I2C bus core support
Date: Tue, 20 Jul 2010 10:53:51 +0200
Message-ID: <20100720105351.58541932@hyperion.delvare>
References: <4C36E6E2.1070307@gmx.de>
	<20100719172548.2d88ed73@hyperion.delvare>
	<4C4545C7.4070508@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C4545C7.4070508-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 20 Jul 2010 08:44:23 +0200, Michael Lawnick wrote:
> Jean Delvare said the following:
> >> @@ -656,9 +709,9 @@ i2c_sysfs_new_device(struct device *dev, struct
> >> device_attribute *attr,
> >>  		return -EINVAL;
> >> 
> >>  	/* Keep track of the added device */
> >> -	i2c_lock_adapter(adap);
> >> +	rt_mutex_lock(&adap->bus_lock);
> >>  	list_add_tail(&client->detected, &adap->userspace_clients);
> >> -	i2c_unlock_adapter(adap);
> >> +	rt_mutex_unlock(&adap->bus_lock);
> >>  	dev_info(dev, "%s: Instantiated device %s at 0x%02hx\n", "new_device",
> >>  		 info.type, info.addr);
> >> 
> > 
> > I expected us to just use i2c_lock/unlock_adapter() everywhere for
> > simplicity. Now I have to agree that using the segment's mutex works
> > too, as the operation is both local to the mutex and unrelated to
> > the other use cases of i2c_lock/unlock_adapter(). But it becomes a
> > little tricky, so it should be all documented clearly (which I will
> > do, don't worry.)
> > 
> >> @@ -697,7 +750,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
> >> device_attribute *attr,
> >> 
> >>  	/* Make sure the device was added through sysfs */
> >>  	res = -ENOENT;
> >> -	i2c_lock_adapter(adap);
> >> +	rt_mutex_lock(&adap->bus_lock);
> >>  	list_for_each_entry_safe(client, next, &adap->userspace_clients,
> >>  				 detected) {
> >>  		if (client->addr == addr) {
> >> @@ -710,7 +763,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
> >> device_attribute *attr,
> >>  			break;
> >>  		}
> >>  	}
> >> -	i2c_unlock_adapter(adap);
> >> +	rt_mutex_unlock(&adap->bus_lock);
> >> 
> >>  	if (res < 0)
> >>  		dev_err(dev, "%s: Can't find device in list\n",
> 
> In i2c_sysfs_delete_device you need a local lock, otherwise you'll get
> a deadlock on removing sub-clients/tree. This in turn brings the local
> lock to i2c_sysfs_new_device().

This is only relevant if the device instantiated / removed from
user-space is an I2C mux chip, right?

Please remember that i2c_lock_adapter() and rt_mutex_lock() might do
exactly the same, if applied to the root segment of an I2C tree. So if
i2c_lock_adapter() would deadlock, I fear that a simple rt_mutex_lock()
might deadlock too. So in the end we might have to introduce another
mutex dedicated to protecting the adapter->userspace_clients list.
Maybe we should have done this from the beginning...

> Thank you for your review.
> ToDo after release: Inventing mux-adapter-name definition in mux-client
> code instead of mux-code. You were right in your last review, this is
> terribly necessary.

OK.

-- 
Jean Delvare
