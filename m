From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH V11] I2C driver for IMX
Date: Fri, 8 Aug 2008 11:01:10 +0100
Message-ID: <20080808100109.GA11503@trinity.fluff.org>
References: <g66mel$v6s$1@ger.gmane.org>
	<20080808115116.59d84d90@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080808115116.59d84d90-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 08, 2008 at 11:51:16AM +0200, Jean Delvare wrote:
> On Wed, 23 Jul 2008 10:20:12 +0300, Darius wrote:
> > Description:
> > 
> > Implementation of I2C Adapter/Algorithm Driver
> > for I2C Bus integrated in Freescale's i.MXL and i.MX1 processors
> > 
> > Changes from V10 version:
> > 
> > - adapter class changed to I2C_CLASS_ALL
> 
> Not a smart move if you ask me. All embedded platforms are moving away
> from I2C probing and now use I2C device description at the platform
> level. I expect I2C_CLASS_ALL to be discarded in 2.6.28. Almost all
> hwmon and rtc drivers have been converted to the new I2C device driver
> matching scheme at this point, and the few remaining ones will
> definitely be converted for 2.6.28, hopefully with all the other legacy
> I2C drivers in the kernel tree.
> 
> > - changes regarding new IMX Clock API
> > 
> > Signed-off-by: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> 
> Ben, this driver has been through many iterations already. Maybe it's
> time for you to pick it up?

Yes, I think it is pretty much ready. If a version without the changelog
is submitted I will look at queueing it for the next merge window.
 
> -- 
> Jean Delvare
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
