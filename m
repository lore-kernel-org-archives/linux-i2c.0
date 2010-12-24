From: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Fri, 24 Dec 2010 17:15:49 +0100
Message-ID: <4D14C735.8@uib.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thank you very much Jean and Giampolo.

After reading again the kernel GPIO Documentation, I have some doubts 
that I would like to resolve and any word about them would be 
apreciated. Please excuse me if the following questions seem too obvious 
or are wrong formulated. I am very new to I2C and GPIO and can not get 
much more information from the results of my searches.

 From Jean's words and the following citation in the GPIO Documentation

> 523    Board Support
> 524    -------------
> 525    For external GPIO controllers -- such as I2C or SPI expanders, 
> ASICs, multi
> 526    function devices, FPGAs or CPLDs -- most often board-specific 
> code handles
> 527    registering controller devices and ensures that their drivers 
> know what GPIO
> 528    numbers to use with gpiochip_add().  Their numbers often start 
> right after
> 529    platform-specific GPIOs.
> 530
> 531    For example, board setup code could create structures 
> identifying the range
> 532    of GPIOs that chip will expose, and passes them to each GPIO 
> expander chip
> 533    using platform_data.  Then the chip driver's probe() routine 
> could pass that
> 534    data to gpiochip_add().


This platform-specific code is what Jean refers to, and must be compiled 
into the kernel.
If this is right, do we need to recompile the whole kernel with the new 
code for your board, or we can compile only the code for a particular 
board and load it as a module? And then, how can we access to the GPIO 
pins from a userspace program?

In several pages I have read three different modules are mentioned, 
namely pca953x, i2c-dev and i2c-gpio. Could anybody clarify what is the 
exact function of each of these modules, please?

Does the pca953x just use the previous platform code and the general 
GPIO support kernel facilities to expose the GPIO chip in the user space 
under /sys/class/gpio ?

Does the i2c-dev module give an alternative way to access to a generic 
i2c device via i2cget? If this is true, how can we access the GPIO pins 
from a program in that case?

What does the i2c-gpio module do?

Thanks everyone in advance.
