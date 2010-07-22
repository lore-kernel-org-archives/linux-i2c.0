From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch v3] i2c: Multiplexed I2C bus core support
Date: Thu, 22 Jul 2010 15:08:18 +0200
Message-ID: <4C4842C2.8020302@gmx.de>
References: <4C36E6E2.1070307@gmx.de>	<20100719172548.2d88ed73@hyperion.delvare>	<4C4545C7.4070508@gmx.de> <20100720105351.58541932@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100720105351.58541932-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> On Tue, 20 Jul 2010 08:44:23 +0200, Michael Lawnick wrote:
>> Jean Delvare said the following:
>> >> @@ -697,7 +750,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
>> >> device_attribute *attr,
>> >>
>> >>  	/* Make sure the device was added through sysfs */
>> >>  	res = -ENOENT;
>> >> -	i2c_lock_adapter(adap);
>> >> +	rt_mutex_lock(&adap->bus_lock);
>> >>  	list_for_each_entry_safe(client, next, &adap->userspace_clients,
>> >>  				 detected) {
>> >>  		if (client->addr == addr) {
>> >> @@ -710,7 +763,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
>> >> device_attribute *attr,
>> >>  			break;
>> >>  		}
>> >>  	}
>> >> -	i2c_unlock_adapter(adap);
>> >> +	rt_mutex_unlock(&adap->bus_lock);
>> >>
>> >>  	if (res < 0)
>> >>  		dev_err(dev, "%s: Can't find device in list\n",
>>
>> In i2c_sysfs_delete_device you need a local lock, otherwise you'll get
>> a deadlock on removing sub-clients/tree. This in turn brings the local
>> lock to i2c_sysfs_new_device().
>
> This is only relevant if the device instantiated / removed from
> user-space is an I2C mux chip, right?
>
> Please remember that i2c_lock_adapter() and rt_mutex_lock() might do
> exactly the same, if applied to the root segment of an I2C tree. So if
> i2c_lock_adapter() would deadlock, I fear that a simple rt_mutex_lock()
> might deadlock too. So in the end we might have to introduce another
> mutex dedicated to protecting the adapter->userspace_clients list.
> Maybe we should have done this from the beginning...
>

Nearly missed this. Have not yet looked into your ftp link, so don't
know whether it is still relevant, but anyway:
The difference above is that rt_mutex_lock locks the (mux-)adapter only
while i2c_lock_adapter locks the root-adapter. So if a parent mux is
unloaded there is no conflict with children.

-- 
Michael Lawnick
