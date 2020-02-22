From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [regression] nct6775 does not load in 5.4 and 5.5, bisected to
 b84398d6d7f90080
Date: Sat, 22 Feb 2020 07:41:18 -0800
Message-ID: <1bdbac08-86f8-2a57-2b0d-8cd2beb2a1c0@roeck-us.net>
References: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33382 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBVPlV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 22 Feb 2020 10:41:21 -0500
In-Reply-To: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Martin Volf <martin.volf.42@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2/22/20 3:13 AM, Martin Volf wrote:
> Hello,
> 
> hardware monitoring sensors NCT6796D on my Asus PRIME Z390M-PLUS
> motherboard with Intel i7-9700 CPU don't work with 5.4 and newer linux
> kernels, the driver nct6775 does not load.
> 
> It is working OK in version 5.3. I have used almost all released stable
> versions from 5.3.8 to 5.3.16; I didn't try older kernels.
> 
> Even on new kernels the sensors-detect finds the sensors:
>          Found `Nuvoton NCT6796D Super IO Sensors' Success!
>              (address 0x290, driver `nct6775')
> but "modprobe nct6775" says:
>          ERROR: could not insert 'nct6775': No such device
> There is nothing interesting in dmesg.
> 

My wild guess would be that the i801 driver is a bit aggressive with
reserving memory spaces, but I don't immediately see what it does
differently in that regard after the offending patch. Does it work
if you unload the i2c_i801 driver first ?

You could also try to compare the output of /proc/ioports with
the old and the new kernel, and see if the IO address space used
by nct6775 in v5.3 is assigned to the i801 driver (or some other
driver, such as the watchdog driver) in v5.4.

If you are into hacking the kernel, you could also add some
debug messages into the nct6775 driver to find out where exactly
it fails. If that helps, maybe we can then add those messages into
into the driver source to help others if this is observed again.

Thanks,
Guenter
