From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V11] I2C driver for IMX
Date: Mon, 11 Aug 2008 10:00:57 +0200
Message-ID: <20080811100057.357f16a2@hyperion.delvare>
References: <g66mel$v6s$1@ger.gmane.org>
	<20080808115116.59d84d90@hyperion.delvare>
	<20080808100109.GA11503@trinity.fluff.org>
	<489FE7D8.6070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <489FE7D8.6070406-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Darius,

On Mon, 11 Aug 2008 10:18:48 +0300, Darius wrote:
> Ben Dooks wrote:
> > On Fri, Aug 08, 2008 at 11:51:16AM +0200, Jean Delvare wrote:
> >> On Wed, 23 Jul 2008 10:20:12 +0300, Darius wrote:
> >>> Description:
> >>>
> >>> Implementation of I2C Adapter/Algorithm Driver
> >>> for I2C Bus integrated in Freescale's i.MXL and i.MX1 processors
> >>>
> >>> Changes from V10 version:
> >>>
> >>> - adapter class changed to I2C_CLASS_ALL
> >> Not a smart move if you ask me. All embedded platforms are moving away
> >> from I2C probing and now use I2C device description at the platform
> >> level. I expect I2C_CLASS_ALL to be discarded in 2.6.28. Almost all
> >> hwmon and rtc drivers have been converted to the new I2C device driver
> >> matching scheme at this point, and the few remaining ones will
> >> definitely be converted for 2.6.28, hopefully with all the other legacy
> >> I2C drivers in the kernel tree.
> 
> Why I should leave i2c class hwmon? i.MX I2C driver is common I2C driver,
> suitable for almost every kind of I2C clients, not only hwmon.
> For example digital camera and so on.

You shouldn't need any class at all, not even hwmon. Instead, you would
use new-style I2C drivers for all your I2C devices.

Please remember that the i2c_adapter class describes the type of I2C
devices which should be _probed_ for on the bus, not the type of I2C
devices that can be present on the bus. If you know in advance which
devices are present on the bus, you don't need to do any probing and
thus leaving the class empty is OK.

> (...)
> To merge this driver into kernel, we have to merge our and Pengutronix
> patches for ARCH_MXC first, because it depends on these patches.
> This I2C driver is not only for MX1 processors but for all i.MX family
> from now. Therefore it needs platform data and header file from arch dir.
> It does not compile before our ARCH_MXC patches are applied.

Your driver depends on ARCH_IMX at this point so it doesn't matter what
the MXC architecture does. I guess you will want to update the
dependency later when the MXC architecture is ready for your driver.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
