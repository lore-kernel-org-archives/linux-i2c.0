From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help: Watchdog-driver over smbus (i2c)
Date: Tue, 1 Dec 2009 10:31:20 +0100
Message-ID: <20091201103120.6ba0f7e0@hyperion.delvare>
References: <4B14395F.4070608@anduras.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B14395F.4070608-3bOZC6EutKuELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hallo Sven,

On Mon, 30 Nov 2009 22:30:07 +0100, Sven Anders wrote:
> I'm trying to code a watchdog driver for the Winbond w83793g chip. I
> already coded a watchdog for another Winbond chip before, but for
> this I need to access it over the system managment bus (or more
> specific the i2c, client address 2E).
> 
> I already coded the detection and initialization routines, but now I
> need some help, because I do not know how to use the i2c framework
> together with the watchdog framework.
> All other drivers I found are using the sysfs framework. This functions
> use the to_i2c_client() function to get a pointer to the i2c client.
> 
> I tried to store the i2c client pointer to a global variable, to use
> it later in the watchdog functions.
>
> But when I try to use the "i2c_smbus_read_byte_data()" or
> "i2c_smbus_write_byte_data()" functions, I will get a kernel OOPS
> (without any hw-sensors driver loaded!).
> 
> What is the best method to get the watchdog framework (i.e. the open,
> close, write, read and ioctl functions) to work with the i2c framework?

The fact that the device is accessed over I2C/SMBus doesn't change
anything to the watchdog interface. It is only an implementation detail
for the way the data registers are accessed.

> Moreover the w83793g hardware sensors driver may already
> accessing the same chip. What is the normal way to deal with this?

Do not write a separate driver for the watchdog functionality. Instead,
add the functionality to the existing hwmon/w83793.c driver. Otherwise
both features will be mutually exclusive.

An example of how this can be done is in hwmon/fschmd.c [1] if you want
to take a look. This is an I2C/SMBus device driver as well, so your code
should be very similar in the end.

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/fschmd.c

Hope this helps,
-- 
Jean Delvare
