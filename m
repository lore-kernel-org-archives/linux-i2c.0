From: Romeo Enrico <romeo-xL9mfXOxRcg@public.gmane.org>
Subject: Omap3 : I2c Driver I2C_M_RECV_LEN support
Date: Wed, 17 Feb 2010 11:55:28 +0100
Message-ID: <4B7BCB20.4080008@korg.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,
In Order to implement the communication between an Omap3530 configured 
as master and a custom device configured as slave, I need to be able to 
configure the size of readings dynamically according to the first byte 
sent by the slave.
Checking kernel I found that in include/linux/i2c.h is declared the 
I2C_M_RECV_LEN flag for the "struct i2c_msg" which should be what I'm 
looking for... But I have not found an implementation of this feature in 
the Omap I2c driver.

Can anyone confirm that the I2C_M_RECV_LEN is not actually supported by 
the Omap I2c driver ?

Best Regards
Enrico
