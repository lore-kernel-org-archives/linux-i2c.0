From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Fri, 17 Dec 2010 19:23:32 +0100
Message-ID: <20101217192332.72706c00@endymion.delvare>
References: <4D0B9C35.5000802@uib.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D0B9C35.5000802-i5CWTa81U/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Joan,

On Fri, 17 Dec 2010 18:21:57 +0100, Joan Pau Beltran wrote:
> We are also working with an Advantech PCM3362 board in an underwater 
> vehicle, and want to use the GPIO port to monitor the battery charge (a 
> battery board is connected to the GPIO port and sets a pin to 1 when 
> voltage goes below 20V).
> 
> We need to use Ubuntu, currently 10.04 with kernel 
> linux-image-2.6-32-26-generic.
> 
> As Giampolo says, out of the box there aren't any chips under 
> /sys/class/gpio (only import/export files).
> After checking that i2c-gpio and pca953x are shipped with the kernel but 
> no loaded by default, I tried to modprobe them and they load 
> successfully, but the chip does not appear in /sys/class/gpio.
> i2cdetect does not list any bus.

When you load the i2c-gpio driver, it looks for support devices. So
your platform initialization code must instantiate a platform device
with name "i2c-gpio" and proper platform data (GPIO pin descriptions).
There are several examples under arch/blackfin and arch/arm you can
look at.

If done properly, after loading i2c-dev, i2cdetect should see your I2C
bus. Until you manage to get there, there is no point in using driver
pca953x, it simply can't work.

> The battery board is not connected to the GPIO now. Actually nothing is 
> connected to it. I suppose that the chip should be detected even if 
> there is nothing attached to it. But just to be sure, do I need to 
> connect it to some device to get the chip appear under /sys/class/gpio?
> 
> Giampolo (ore anyone on the list), did you success using the GPIO port 
> on that board? In that case, could you point me what steps have you 
> done? It's the first time I use a GPIO port and I read the Documentation 
> and both examples pointed out by Jean but still can not figure out why 
> the chip is not recognized under /sys/class/gpio or how to access it.
> 
> Thanks Jean for pointing out about the address alignment difference in 
> Linux. For sure I won't even thought about it reading the Advantech manual.

-- 
Jean Delvare
