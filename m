From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch v3] i2c: Multiplexed I2C bus core support
Date: Tue, 20 Jul 2010 08:44:23 +0200
Message-ID: <4C4545C7.4070508@gmx.de>
References: <4C36E6E2.1070307@gmx.de> <20100719172548.2d88ed73@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100719172548.2d88ed73-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> Hi Michael,
> 
>>  drivers/i2c/i2c-mux.c       |  165
>> > +++++++++++++++++++++++++++++++++++++++++++
> As you can see, your e-mail client wrapped long lines again. I had to
> manually fix the patch so that I could apply it...
> 
I'm really sorry about that :-(
I've tested it by sending to an alternative address and it worked.
No idea where this wrap comes from.
...
>> @@ -656,9 +709,9 @@ i2c_sysfs_new_device(struct device *dev, struct
>> device_attribute *attr,
>>  		return -EINVAL;
>> 
>>  	/* Keep track of the added device */
>> -	i2c_lock_adapter(adap);
>> +	rt_mutex_lock(&adap->bus_lock);
>>  	list_add_tail(&client->detected, &adap->userspace_clients);
>> -	i2c_unlock_adapter(adap);
>> +	rt_mutex_unlock(&adap->bus_lock);
>>  	dev_info(dev, "%s: Instantiated device %s at 0x%02hx\n", "new_device",
>>  		 info.type, info.addr);
>> 
> 
> I expected us to just use i2c_lock/unlock_adapter() everywhere for
> simplicity. Now I have to agree that using the segment's mutex works
> too, as the operation is both local to the mutex and unrelated to
> the other use cases of i2c_lock/unlock_adapter(). But it becomes a
> little tricky, so it should be all documented clearly (which I will
> do, don't worry.)
> 
>> @@ -697,7 +750,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
>> device_attribute *attr,
>> 
>>  	/* Make sure the device was added through sysfs */
>>  	res = -ENOENT;
>> -	i2c_lock_adapter(adap);
>> +	rt_mutex_lock(&adap->bus_lock);
>>  	list_for_each_entry_safe(client, next, &adap->userspace_clients,
>>  				 detected) {
>>  		if (client->addr == addr) {
>> @@ -710,7 +763,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
>> device_attribute *attr,
>>  			break;
>>  		}
>>  	}
>> -	i2c_unlock_adapter(adap);
>> +	rt_mutex_unlock(&adap->bus_lock);
>> 
>>  	if (res < 0)
>>  		dev_err(dev, "%s: Can't find device in list\n",

In i2c_sysfs_delete_device you need a local lock, otherwise you'll get
a deadlock on removing sub-clients/tree. This in turn brings the local
lock to i2c_sysfs_new_device().

Thank you for your review.
ToDo after release: Inventing mux-adapter-name definition in mux-client
code instead of mux-code. You were right in your last review, this is
terribly necessary.

-- 
KR
Michael Lawnick
