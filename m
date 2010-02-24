From: Steve <steve.explores-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Do you always need a client driver to access a I2C device?
Date: Wed, 24 Feb 2010 19:11:00 +0000
Message-ID: <4B8579C4.7080502@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I am modifying an embedded kernel driver to use the Linux I2C sub-system 
rather than the RTOS I2C calls it previously used. The driver just needs 
to make a very small number of I2C read/writes to a device on the I2C 
bus at a fixed address and does not need to expose any methods to 
user-space via /dev or sysfs. An algorithm and adapter driver are 
provided for the SoC that controls the board, but there are no client 
drivers.

I have been reading the Documentation/i2d doc and looking at some of the 
existing drivers. I only need to read/write a few bytes to the device 
but from the doc, examples and i2c api it appeared I would need to write 
a client driver for the device to obtain the i2c_client ptr I needed to 
do that. Along with the appropriate board_info for the devices on the board.

However I noticed that the DTV demodulator drivers, e.g. 
drivers/media/dvb/frontends/au8522.c, appear to be doing it simply using 
a i2c_adapter ptr and i2c_transfer().

For my simple needs, access fixed embedded device, no need for user 
space access, is the i2c_adapter ptr a simple and "appropriate" way to 
go or am I missing something that makes it more complex than it seems? 
This assumes its straight forward to get the adapter ptr from the SoC 
adapter driver of course. Perhaps I should be doing a client driver 
instead after all?

I think I have spent too long looking through the sub-system 
infrastructure source and have ended up confusing myself somewhat. I 
just want to make sure I am on the correct path before continuing with 
my reading and investigating. The kernel version is 2.6.27.39.

Thanks

Steve
