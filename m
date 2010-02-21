From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Omap3 : I2c Driver I2C_M_RECV_LEN support
Date: Sun, 21 Feb 2010 12:01:07 +0100
Message-ID: <20100221120107.6bc57138@hyperion.delvare>
References: <4B7BCB20.4080008@korg.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B7BCB20.4080008-xL9mfXOxRcg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romeo Enrico <romeo-xL9mfXOxRcg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Enrico,

On Wed, 17 Feb 2010 11:55:28 +0100, Romeo Enrico wrote:
> In Order to implement the communication between an Omap3530 configured 
> as master and a custom device configured as slave, I need to be able to 
> configure the size of readings dynamically according to the first byte 
> sent by the slave.
> Checking kernel I found that in include/linux/i2c.h is declared the 
> I2C_M_RECV_LEN flag for the "struct i2c_msg" which should be what I'm 
> looking for...

This is correct. This mechanism is used for the SMBus Block Read
transaction.

> But I have not found an implementation of this feature in 
> the Omap I2c driver.
> 
> Can anyone confirm that the I2C_M_RECV_LEN is not actually supported by 
> the Omap I2c driver ?

Looking at the source code of the i2c-omap driver in Linus' kernel, I
can confirm there is no support. You might want to check for updates in
the omap tree though, or even ask on an omap-specific list: someone
might have already implemented it but not pushed it to mainstream yet.

-- 
Jean Delvare
