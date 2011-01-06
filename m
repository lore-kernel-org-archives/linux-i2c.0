From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Thu, 6 Jan 2011 17:19:47 +0100
Message-ID: <20110106171947.39eccebf@endymion.delvare>
References: <4D14C735.8@uib.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D14C735.8-i5CWTa81U/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Joan Pau,

On Fri, 24 Dec 2010 17:15:49 +0100, Joan Pau Beltran wrote:
> Thank you very much Jean and Giampolo.
> 
> After reading again the kernel GPIO Documentation, I have some doubts 
> that I would like to resolve and any word about them would be 
> apreciated. Please excuse me if the following questions seem too obvious 
> or are wrong formulated. I am very new to I2C and GPIO and can not get 
> much more information from the results of my searches.
> 
>  From Jean's words and the following citation in the GPIO Documentation
> 
> > 523    Board Support
> > 524    -------------
> > 525    For external GPIO controllers -- such as I2C or SPI expanders, ASICs, multi
> > 526    function devices, FPGAs or CPLDs -- most often board-specific code handles
> > 527    registering controller devices and ensures that their drivers know what GPIO
> > 528    numbers to use with gpiochip_add().  Their numbers often start right after
> > 529    platform-specific GPIOs.
> > 530
> > 531    For example, board setup code could create structures identifying the range
> > 532    of GPIOs that chip will expose, and passes them to each GPIO expander chip
> > 533    using platform_data.  Then the chip driver's probe() routine could pass that
> > 534    data to gpiochip_add().
> 
> 
> This platform-specific code is what Jean refers to, and must be compiled 
> into the kernel.
> If this is right, do we need to recompile the whole kernel with the new 
> code for your board, or we can compile only the code for a particular 
> board and load it as a module? And then, how can we access to the GPIO 
> pins from a userspace program?

Yes, you typically have to rebuild your kernel with specific platform
code for your new system, even though it would certainly be possible to
hack up an external kernel module instantiating the required I2C device.

In your specific case, it may be enough to add some custom code to the
i2c-i801. If you look at the end of function i801_probe, you'll see
such code already for a few systems. You can add your own system there.

I am not too familiar with the gpio subsystem, but my understanding is
that you can ask for your chip to expose its pins to user-space through
sysfs. It might even be the default.

> In several pages I have read three different modules are mentioned, 
> namely pca953x, i2c-dev and i2c-gpio. Could anybody clarify what is the 
> exact function of each of these modules, please?

i2c-gpio is used when you have an I2C bus hanging off 2 GPIO pins,
which are used to bit-bang the SDA and SCL lines of the bus. From your
previous system description, I don't think you need this, as your I2C
bus is handled by the i2c-i801 driver already.

pca953x is a device driver for I2C-based GPIO chips. If you have a
compatible I/O expander connected to your I2C bus, this is the driver
you want.

i2c-dev is a generic driver granting user-space access to I2C buses on
your system. It can be used to deal with I2C devices which don't have a
kernel driver yet, or for which you don't want to write or use a kernel
driver. But the most frequent use is for debugging, using i2c-tools
(i2cdump etc.)

> Does the pca953x just use the previous platform code and the general 
> GPIO support kernel facilities to expose the GPIO chip in the user space 
> under /sys/class/gpio ?

Yes, exactly.

> Does the i2c-dev module give an alternative way to access to a generic 
> i2c device via i2cget? If this is true, how can we access the GPIO pins 
> from a program in that case?

Yes, this is true, but as I said in my other reply already, i2cget
gives raw access to the registers, so you have a lot of work left to
make sense of the values. Basically, using i2c-dev to access a PCA953x
chip means you recode the pca953x driver in user-space. Honestly, I
don't get the point. Well, yes, of course, it saves you the step of
properly declaring the I2C device in the kernel, but the cost seems
very high.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
