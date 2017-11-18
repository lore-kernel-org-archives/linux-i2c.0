From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Support of DDR4 EEPROMs
Date: Sat, 18 Nov 2017 19:05:47 +0100
Message-ID: <20171118190547.08537081@endymion>
References: <20171110101416.14410124@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54611 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424388AbdKRSFu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 18 Nov 2017 13:05:50 -0500
In-Reply-To: <20171110101416.14410124@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, 10 Nov 2017 10:14:16 +0100, Jean Delvare wrote:
> My topic for SUSE Hackweek 16 is to add support for DDR4 memory modules
> to decode-dimms:
> https://hackweek.suse.com/16/projects/add-support-for-ddr4-to-decode-dimms

I have successfully completed my project.

SUMMARY
-------

There were two distinct problems to be solved:

* The register definitions of DDR4 SPD is different from previous
  SDRAM generations, so decode-dimms needed to be extended to know
  about them.

* The EEPROMs which hold the SPD data on DDR4 memory modules are no
  longer standard AT24C02-compatible EEPROMs. They are 512-byte
  EEPROMs which use only 1 I2C address for data access. You need to
  switch between the lower page and the upper page of data by sending
  commands on the SMBus.

RESULTS
-------

Support for DDR4 SDRAM modules was added to decode-dimms as 6 patches:

decode-dimms-DDR4-01-manufacturer.patch
decode-dimms: Add preliminary DDR4 support

decode-dimms-DDR4-02-size-and-timings.patch
decode-dimms: Decode size and timings of DDR4

decode-dimms-DDR4-03-extra-information.patch
decode-dimms: Decode misc parameters of DDR4

decode-dimms-DDR4-04-type-specific.patch
decode-dimms: Decode physical characteristics of DDR4

decode-dimms-DDR4-05-add-ee1004-driver.patch
decode-dimms: Documentation update for DDR4

decode-dimms-DDR4-06-check-block-1-CRC.patch
decode-dimms: Verify the CRC of DDR4 data block 1

I will post these patches on this list tomorrow.

The kernel-side support was implemented with a dedicated driver
named ee1004. I'll wrap it into a proper patch tomorrow and post it
here.

TESTING
-------

If you want to test the results of this hackweek project, you first
have to download and build the standalone ee1004 driver:

http://users.suse.com/~jdelvare/hackweek/0x10/ee1004/

Once it is built, load it:

# insmod ee1004.ko

There is no auto-detection of the DDR4 SPD EEPROMs yet, so you then have
to instantiate the ee1004 devices manually. Only try this on a system
which you are sure does have DDR4 SDRAM memory.

First you must find out the i2c bus number of your motherboard's SMBus,
using i2cdetect (i2cdetect is part of the i2c-tools package.) Example:

# modprobe i2c-dev
# i2cdetect -l | grep smbus
i2c-4	smbus     	SMBus I801 adapter at f040      	SMBus adapter

So the SMBus is i2c-4. Then you must find the I2C addresses of the
SPD EEPROMs:

# i2cdetect -y 4 0x50 0x57
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                                                 
10:                                                 
20:                                                 
30:                                                 
40:                                                 
50: -- 51 -- 53 -- -- -- --                         
60:                                                 
70:                                                 

So there are 2 DDR4 SPD EEPROMs, one at I2C address 0x51 and one at
I2C address 0x53. To instantiate the devices, do:

# echo ee1004 0x51 > /sys/bus/i2c/devices/i2c-4/new_device 
# echo ee1004 0x53 > /sys/bus/i2c/devices/i2c-4/new_device 

After this, script decode-dimms will find the SPD EEPROMs and decode
their contents:

http://users.suse.com/~jdelvare/hackweek/0x10/decode-dimms-DDR4

Thanks,
-- 
Jean Delvare
SUSE L3 Support
