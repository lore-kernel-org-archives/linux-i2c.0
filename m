From: "Fabien Marteau" <lepingouin.tux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SMBus quick command problem
Date: Fri, 9 Jan 2009 18:11:21 +0100
Message-ID: <ce62e9d00901090911r7454ae5fr61c69a22704ed86b@mail.gmail.com>
References: <ce62e9d00901080101ocfa0388g91698776eb9704cb@mail.gmail.com>
	 <20090109152752.29b3c5de@hyperion.delvare>
	 <ce62e9d00901090703y5af1ba4diedf37d30da5d158a@mail.gmail.com>
	 <20090109161222.4c75ffda@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090109161222.4c75ffda-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> I don't get where you're going with rewriting the driver. You'll end up
> with a larger driver doing exactly the same, without taking benefit of
> the SMBus emulation layer from i2c-core. If the hardware has a problem
> with Quick commands, rewriting the driver won't solve that. Better
> intercept that case in the current driver and return an error.

Hmm, maybe you are right. I'm a beginner in kernel hacking and I tried to
rewrite this driver mainly to learn linux-driver programming.

> So what problem are
> you trying to solve exactly?

Well, when I modprobe the original ocore driver, an i2c slave driver already
present under the kernel probe the bus with write-quick command. This command
block the controller :
http://dl.free.fr/qS2l40o9p
(yellow:SDA, green:SCL, pink: interrupt)

This problem is normal if I read the
datasheet(http://www.opencores.org/cvsweb.shtml/i2c/doc/i2c_specs.pdf), because
to send only one byte (address byte) the stop command must be send at the same
time that start command.

The driver is marked as SMBus emulation compatible :
static u32 ocores_func(struct i2c_adapter *adap)
{
	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
}

But apparently it does not support all SMBus commands, and I can't use
i2cdetect to scan the bus.

With my new version of the driver, really bigger than original, SMBus commands
are supported one by one and I can use i2cdetect to scan the bus:
static u32 ocores_func(struct i2c_adapter *adap)
{
	return  I2C_FUNC_SMBUS_BYTE_DATA|
		I2C_FUNC_SMBUS_WORD_DATA|
		I2C_FUNC_SMBUS_BYTE|
		I2C_FUNC_SMBUS_QUICK|
		I2C_FUNC_SMBUS_WRITE_I2C_BLOCK|
		I2C_FUNC_SMBUS_READ_I2C_BLOCK;
}

But maybe it's a bad idea to re-write the driver, I will investigate
to find another solution.

Fabien M
