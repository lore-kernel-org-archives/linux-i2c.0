From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Tue, 19 Jan 2010 13:09:48 +0100
Message-ID: <20100119120947.GD554@sortiz.org>
References: <6cb013311001060647s3bce5e63mbae1a10036a14ae1@mail.gmail.com>
 <1263056154-20085-1-git-send-email-darkstar6262@gmail.com>
 <20100118124855.GB8036@sortiz.org>
 <20100118153624.GA13811@sortiz.org>
 <6cb013311001181323q79aba15dif165ff41d79734a7@mail.gmail.com>
 <20100119110916.GB554@sortiz.org>
 <20100119124812.345fe447@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100119124812.345fe447-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Tue, Jan 19, 2010 at 12:48:12PM +0100, Jean Delvare wrote:
> Hi Samuel,
> 
> On Tue, 19 Jan 2010 12:09:17 +0100, Samuel Ortiz wrote:
> > 2) Kconfig: we need to depend on I2C=y, to avoid the problematic case of
> > having I2C_CORE=m and HTC_I2CPLD=y
> 
> ??
> 
> There is no config option named I2C_CORE. The main option for I2C is,
> well, I2C,
Sorry, I meant I2C, not I2C_CORE.


> and if you depend on I2C, then you can't be built into the
> kernel if I2C is built as a module. 
I have:

drivers/mfd/Kconfig:
config HTC_I2CPLD
	bool "HTC I2C PLD chip support"
	depends on I2C

Then make menuconfig allows me to build a .config with

CONFIG_I2C=m and CONFIG_HTC_I2CPLD=y

and that obviously fails to build. If I'm a bool depending on I2C, it has to
be a built-in I2C.

Cheers,
Samuel.


> What exact problem are you trying to solve?
> 
> -- 
> Jean Delvare

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
