From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Thu, 10 Mar 2011 16:45:56 +0200
Message-ID: <99B09243E1A5DA4898CDD8B7001114481082EF2A65@EXMB04.eu.tieto.com>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103101452.54862.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201103101452.54862.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, ext-jari.vanhala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd, 

>However, this is the second NFC driver (at least), and that 
>means it's time to come up with a generic way of talking to 
>NFC devices from user space. We cannot allow every NFC 
>controller to have another set of arbitrary ioctl numbers.

>What I suggest you do is to work with the maintainers of the existing
>pn544 driver (Matti and Jari) to create an NFC core library 
>that takes care of the character device interface and that can 
>be shared between the two drivers. Instead of each driver 
>registering a misc device, make it call a 
>nfc_device_register() function that is implemented in a common module.

I've been already thinking about that and it's seems like next obvious step.

>Not your problem directly, but I think we need to find a way 
>to encode gpio pins in resources like we do for interrupts.
>
>> +	int (*request_hardware) (struct i2c_client *client);
>> +	void (*release_hardware) (void);
>
>Why do you need these in platform data? Can't you just request 
>the i2c device at the time when you create the platform_device?

I do gpio/irq stuff there but you are right it doesn't make sense. I can do it when create platform_device as well.
Will remove this. 

>mdev, rx_waitq and mutex would go into the common module.
>I would expect that you also need a tx_waitq. What happens 
>when the buffer is full?

Do you mean info->buff ?


>> +static inline int microread_is_busy(struct microread_info *info) {
>> +	return (info->state == MICROREAD_STATE_BUSY); }
>> +
>> +static int microread_open(struct inode *inode, struct file *file) {
>> +	struct microread_info *info = container_of(file->private_data,
>> +					struct microread_info, mdev);
>> +	struct i2c_client *client = info->i2c_dev;
>> +	int ret = 0;
>> +
>> +	dev_vdbg(&client->dev, "%s: info: %p", __func__, info);
>> +
>> +	mutex_lock(&info->mutex);
>> +
>> +	if (microread_is_busy(info)) {
>> +		dev_err(&client->dev, "%s: info %p: device is 
>busy.", __func__,
>> +				info);
>> +		ret = -EBUSY;
>> +		goto done;
>> +	}
>> +
>> +	info->state = MICROREAD_STATE_BUSY;
>> +done:
>> +	mutex_unlock(&info->mutex);
>> +	return ret;
>> +}
>
>Note that the microread_is_busy() logic does not protect you 
>from having multiple concurrent readers, because multiple 
>threads may share a single file descriptor.

It's just used to ensure that only one reader can open the device. It's called only in open callback.
The mutex actually secures concurrent read operations. 


>Some of your identifiers are not 'static'. Please make sure 
>that only symbols that are used across files are in the global 
>namespace.

Sure, I missed that. 
Must be fixed.
