From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: enable High-speed mode for pcidrv
Date: Thu, 15 Oct 2015 11:32:33 +0300
Message-ID: <561F64A1.8030805@linux.intel.com>
References: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>	<1444380426-17953-2-git-send-email-wangxfdu@gmail.com>	<1444383067.8361.517.camel@linux.intel.com>	<CACDNBm3wkxAXbgQ4Z15uBFKUrsy9ngYKx3dGY20eV4RbSoJ5mg@mail.gmail.com>	<1444638708.8361.564.camel@linux.intel.com> <CACDNBm38bC+tP2S3WgUJJVRUppYF3=aUXvRtWfqfpM=BHapN9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACDNBm38bC+tP2S3WgUJJVRUppYF3=aUXvRtWfqfpM=BHapN9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiang Wang <wangxfdu@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: xiang.a.wang@intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 10/15/2015 08:46 AM, Xiang Wang wrote:
> 1. "bus speed mode" is a bit different from other parameters. Actually
> it can be determined by the speed setting of "i2c devices" in ACPI
> (I2CSerialBus). E.g. If i2c device uses 3MHz, we use High-speed mode
> for this i2c bus.
> 2. If we hardcode speed setting in pci driver, we lose the
> flexibility. A high-speed device may be connected to this i2c bus on
> this board, but may be connected to another i2c bus on another board
> design.
>
> In this patch, we enumerate the i2c device in ACPI table to determine
> the frequency setting. Then we set corresponding speed mode for this
> i2c controller. The ACPI stuff is common for pci and plat driver. If
> board design changes, we only change BIOS.
>
> In conclusion, we have 2 solutions to set the i2c controller speed
> mode (pci driver):
> 1) use hardcode value in pci driver
> 2) use frequency setting of "i2c device" in ACPI table (more flexible,
> but looks a bit strange)
>
> Do you have any preference/suggestions for above solutions? Thanks

I don't think we can hard code especially the high-speed mode because 
most typically buses are populated with slower devices.

Things are a bit more clear when ACPI provides timing parameters for the 
bus (for standard and fast speed modes at the moment in 
i2c-designware-platdrv.c: dw_i2c_acpi_configure()) but still I think the 
ACPI namespace walk may be needed against potential BIOS 
misconfigurations. For instance if it provides timing parameters for all 
speeds but there are devices with lower speed on the same bus.

I'd take these timing parameters as configuration data for bus features 
but actual speed (speed bits in IC_CON register) is defined separately. 
To me it looks only way to achieve that is to pick slowest device from 
I2cSerialBus resource descriptors.

-- 
Jarkko
