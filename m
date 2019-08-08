From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v5 0/3] Enable ACPI-defined peripherals on i2c-piix4 SMBus
Date: Thu, 8 Aug 2019 11:17:53 +0200
Message-ID: <b013c33b-da11-ce5e-08d4-0b24a8575109@metux.net>
References: <20190802145109.38dd4045@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802145109.38dd4045@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org, platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>, Guenter Roeck <linux@roeck-us.net>, Will Wagner <willw@carallon.com>
List-Id: linux-i2c@vger.kernel.org

On 02.08.19 14:51, Jean Delvare wrote:

Hi,

> These patches fix a couple of issues with the i2c-piix4 driver on
> AMD Family 16h Model 30h SoCs and add ACPI-based enumeration to the
> i2c-piix4 driver.

Can you tell a little bit more about what devices are behind the smbus ?
I recall the G-412 SoCs (such as on apu2+ boards) have an Hudson inside
and fall into this category. (I'll have to check when back in office),
so (as the apu2 platform driver maintainer) I'm very interested in this.

Does the probing need some special BIOS support (or do the necessary
table entries already come from aegesa) ?

I have to admit, I'm still confused by the AMD documentation - haven't
found a clear documentation on what peripherals exactly are in the
G-412 SoC, just puzzled together that the FCH seems to be an Hudson,
probably v2. There also seems to be some relation between smbus and
gpio, but the gpio's are directly memory-mapped - no idea whether they
just share the same base address register or the gpios are really behind
smbus and some hw logic directy maps them into mmio space ...
Do you happen to have some more information on that ?

By the way: I'm considering collecting some hw documentation in the
kernel tree (maybe Documentation/hardware/...) - do you folks think
that's a good idea ?

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
