From: Jean Delvare <jdelvare@suse.de>
Subject: Re: SMBus not found
Date: Thu, 9 Feb 2017 09:49:11 +0100
Message-ID: <20170209094911.2b856969@endymion>
References: <CANE=DpU===GBGNY0+QJCKuw295kkYSEPN-oeaT7cG6DRcNdjiA@mail.gmail.com>
        <1486119208.4299.11.camel@suse.de>
        <CANE=DpWovf4BO31Dqzj72hN=8etRLwFbyrDMZMzqzFNFtRe2cg@mail.gmail.com>
        <CANE=DpWWeKNRGhCQciS4aqi9+FXLOmZJabZiuO8FbNq8YP65mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbdBIItY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 03:49:24 -0500
In-Reply-To: <CANE=DpWWeKNRGhCQciS4aqi9+FXLOmZJabZiuO8FbNq8YP65mw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hrvoje T <hrvooje@jankovci.net>
Cc: linux-i2c@vger.kernel.org

Hi Hrvoje,

On Sat, 4 Feb 2017 02:55:02 +0100, Hrvoje T wrote:
> My hardware is HP Probook 6470b laptop, kernel 4.8.0-37-generic,
> lm-sensors version 1:3.4.0-3. I did
> 
> # modprobe i2c-dev
> # i2cdetect -l
> 
> and got this:
> 
> i2c-3   i2c     i915 gmbus dpc       I2C adapter
> i2c-1   i2c     i915 gmbus vga       I2C adapter
> i2c-8   i2c     DPDDC-D              I2C adapter
> i2c-6   i2c     DPDDC-B              I2C adapter
> i2c-4   i2c     i915 gmbus dpb       I2C adapter
> i2c-2   i2c     i915 gmbus panel     I2C adapter
> i2c-0   i2c     i915 gmbus ssc       I2C adapter
> i2c-7   i2c     DPDDC-C              I2C adapter
> i2c-5   i2c     i915 gmbus dpd       I2C adapter

No SMBus here, all the I2C buses listed are from your graphics chip.

> I would like to find out CAS latency times of my RAM memory modules
> without opening the laptop. I guess those are on DIMM slots. dmidecode
> -t memory gives:
> 
> Handle 0x0008, DMI type 17, 34 bytes
> Memory Device
>        Array Handle: 0x0005
>        Error Information Handle: Not Provided
>        Total Width: 64 bits
>        Data Width: 64 bits
>        Size: 4096 MB
>        Form Factor: SODIMM
>        Set: None
>        Locator: Bottom-Slot 2(under)
>        Bank Locator: BANK 2
>        Type: DDR3
>        Type Detail: Synchronous
>        Speed: 1600 MHz
>        Manufacturer: Ramaxel
>        Serial Number: 44BBE80E
>        Asset Tag: 9876543210
>        Part Number: RMT3160ED58E9W1600
>        Rank: Unknown
>        Configured Clock Speed: Unknown

Looks good, but DMI doesn't provide detailed timing information, only
speed.

> and lspci:
> (...)
> 00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC
> Controller (rev 04)
> 00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
> 6-port SATA Controller [AHCI mode] (rev 04)

The SMBus should show up as device 00:1f.3 here, but it is missing. It
means it has been hidden by the BIOS. We have some quirks in the kernel
to unhide the SMBus on older Intel chipsets, up to ICH6, but nothing for
recent chipsets.

> I know I could find out latency times on the manufacturer's web page,
> but I would like to know is it possible via i2c? I'm noob in Linux and
> bad at english, sorry for my mistakes and thanks for your help in
> advance.

It would be possible if the BIOS did not hide the SMBus device. But not
on your laptop, at least not until someone adds another PCI quirk to
unhide this specific device after reading its datasheet.

You may try booting memtest86 on your laptop (many Linux distributions
include it on their installation media), it may be able to display the
timing information you are looking for.

Alternatively, temporarily put the memory module in question in another
laptop where the SMBus is not hidden, and capture a dump of the SPD
data.

-- 
Jean Delvare
SUSE L3 Support
