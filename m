From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v5 0/3] Enable ACPI-defined peripherals on i2c-piix4 SMBus
Date: Fri, 9 Aug 2019 17:53:08 +0200
Message-ID: <01de7b0c-7579-048b-312c-122dddc23c64@metux.net>
References: <20190802145109.38dd4045@endymion>
 <b013c33b-da11-ce5e-08d4-0b24a8575109@metux.net>
 <20190809103340.2ef24523@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809103340.2ef24523@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org, platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>, Guenter Roeck <linux@roeck-us.net>, Will Wagner <willw@carallon.com>
List-Id: linux-i2c@vger.kernel.org

On 09.08.19 10:33, Jean Delvare wrote:

Hi,

> Unfortunately not. I only picked up from where Andrew Cooks left, due
> to me being way too slow to review his patches. 

@Andrew: can you tell us more about this ?

> I was able to test the first 2 patches which fix bugs, but
> not the 3rd one which deals with ACPI devices. There does not seem to
> be any such device on the 2 test machines I have remotely access to.

Did you already test on apu2/apu3 ?
If not, maybe you could prepare a queue that I could test.

>> Does the probing need some special BIOS support (or do the necessary
>> table entries already come from aegesa) ?
> 
> I assume that ACPI devices are declared in one of the ACPI tables, so
> it comes from the "BIOS", yes, whatever form it takes these days.

hmm, so we'll yet have to find out whether these entries are actually
present on actual machines in the field and potentially stick w/
board specific platform drivers.

I had hoped I could do all the probing of things like gpio, etc, from
firmware (grmpf, w/ oftree all of that would be pretty trivial :o),
but I doubt that it will work. Even w/ fairly recent gpio support in
ACPI (IIRC my apu's dont have this yet), we're still lacking the
actual assignment of the gpios (LEDs, Keys, ...).

> I remember noticing long ago that SMBus ports were using GPIO pins, so
> these pins could be used for SMBus or for any other purpose. 

You mean via bit banging ? Or smbus and gpio shared behind a pinmux ?

That might explain the strange holes in the register set (actually,
never tried using anything undocumented as gpio).

Did you find some documents you could send over ?

> I could
> not find any way to figure out from the registers if a given pin pair
> was used for SMBus or not, which is pretty bad because it means we are
> blindly instantiating ALL possible SMBus ports even if some of the pins
> are used for a completely different purpose. 

Do you know the addresses of the smbus port registers ?

These are the gpio registers I've found out - relative to fch base
(0xFED80000) plus gpio offset (0x1500):

/*
  * gpio register index definitions
  */
#define AMD_FCH_GPIO_REG_GPIO49         0x40
#define AMD_FCH_GPIO_REG_GPIO50         0x41
#define AMD_FCH_GPIO_REG_GPIO51         0x42
#define AMD_FCH_GPIO_REG_GPIO59_DEVSLP0 0x43
#define AMD_FCH_GPIO_REG_GPIO57         0x44
#define AMD_FCH_GPIO_REG_GPIO58         0x45
#define AMD_FCH_GPIO_REG_GPIO59_DEVSLP1 0x46
#define AMD_FCH_GPIO_REG_GPIO64         0x47
#define AMD_FCH_GPIO_REG_GPIO68         0x48
#define AMD_FCH_GPIO_REG_GPIO66_SPKR    0x5B
#define AMD_FCH_GPIO_REG_GPIO71         0x4D
#define AMD_FCH_GPIO_REG_GPIO32_GE1     0x59
#define AMD_FCH_GPIO_REG_GPIO33_GE2     0x5A
#define AMT_FCH_GPIO_REG_GEVT22         0x09

(see: include/linux/platform_data/gpio/gpio-amd-fch.h)

>> By the way: I'm considering collecting some hw documentation in the
>> kernel tree (maybe Documentation/hardware/...) - do you folks think
>> that's a good idea ?
> 
> No. Only documentation specifically related to the Linux kernel should
> live in the kernel tree. OS-neutral documentation must go somewhere
> else.

hmm, but dts is also kinda documentation, isn't it ? ;-)

Well, I'll probably start a separate project for that.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
