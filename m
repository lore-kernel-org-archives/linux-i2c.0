From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Registering I2C devices on X86
Date: Wed, 02 Jun 2010 12:12:00 +0200
Message-ID: <4C062E70.3090409@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I have a general question regarding the best way of registering I2C devices on a X86 system.

On ARM I would have done it in the board config, pretty straight forward.

On this X86 system the I2C bus is a PCI device, and different I2C devices might be tied into the bus 
depending on which board the device is populated on.

So my idea is to create a "mapping" driver. It opens the I2C adapter, creates platform data for each 
I2C device and add them by calling i2c_new_device. I don't find any better way since platform data 
must be created and also translation from GPIO pins to interrupt numbers.

Any ideas or suggestions?

Thanks in advance
--Richard
