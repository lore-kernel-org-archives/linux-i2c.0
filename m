From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: I2C class bitmask
Date: Sat, 23 May 2015 09:50:35 -0700
Message-ID: <5560AFDB.30307@freescale.com>
References: <555E4913.9070805@freescale.com> <20150523162737.GA4981@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150523162737.GA4981-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 05/23/2015 09:27 AM, Guenter Roeck wrote:
> On Thu, May 21, 2015 at 02:07:31PM -0700, York Sun wrote:
>> Lee,
>>
>> Is there any convention regarding I2C class bitmask? I see only three are
>> defined for 3.12.19 and four for 4.0
>>
>> I2C_CLASS_HWMON, I2C_CLASS_DDC, I2C_CLASS_SPD, I2C_CLASS_DEPRECATED
>>
>> I am working on a clock chip driver (SI5338) and trying to detect them (multiple
>> chips in i2c mux). It would be a lot easier to have its own class, like
>> I2C_CLASS_CLOCK. It is trivial to add a line to i2c.h file. Just checking if
>> this is a bad idea.
>>
> 
> A class is supposed to indicate if a specific chip class is likely to be seen
> on an i2c adapter, and that it may be necessary to auto-detect it (an example
> are I2C_CLASS_HWMON type devices on PCs). The tendency, though, is to drop
> existing markers for I2C_CLASS_xxx from adapter drivers as much as possible
> because it slows down the boot process (see upstream commit 0c176170089c3).
> 
> Auto-detection (with the _detect function) is not a preferred means to
> instantiate a device. It takes time, and it is more or less unreliable.
> For some chips, a read on its i2c register space can result in a chip reset,
> or it can cause it to lose its programming. Worst case it can turn a system
> into a brick.
> 
> Preferred instantiations are listed in Documentation/i2c/instantiating-devices.
> Instantiation with devicetree, ACPI, or through i2c_register_board_info()
> would probably be the best available methods to instantiate a clock chip.
> 
> Given that, first question is why you would want to have the chip auto-detected
> in the first place. Is there any reason to believe that explicit instantiation
> would not work in your system ?  What are those reasons ?
> 
> On top of that, the SI5338 does not have a clean way to detect the chip.
> It does not have a chip ID register, and it is multi-banked. Given the
> similarities of the various Silicon Labs clock chips, it may not even be
> possible to reliably distinguish it from other SI chips. So even if you
> had a good reason to auto-detect the chip, it would be _very_ unreliable.
> This seems to be quite undesirable and risky for a clock chip.
> Are you really sure that you want and need that ?
> 

Guenter,

Thanks for replying.

No, I don't have to use autodetect. I was curious why there weren't more
classes. I failed to notice which method is preferred in the mentioned document.
I used to declare the devices by the bus number but met some issue when they are
behind a mux. I temporarily used auto detect before I figure out how to describe
the mux with i2c_board_info.

Knowing auto-detection is not preferred, I will remove it from the proposed driver.

Thanks again.

York
