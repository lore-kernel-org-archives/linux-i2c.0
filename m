From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: enable High-speed mode for pcidrv
Date: Thu, 15 Oct 2015 12:40:23 +0300
Message-ID: <1444902023.8361.629.camel@linux.intel.com>
References: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>
	 <1444380426-17953-2-git-send-email-wangxfdu@gmail.com>
	 <1444383067.8361.517.camel@linux.intel.com>
	 <CACDNBm3wkxAXbgQ4Z15uBFKUrsy9ngYKx3dGY20eV4RbSoJ5mg@mail.gmail.com>
	 <1444638708.8361.564.camel@linux.intel.com>
	 <CACDNBm38bC+tP2S3WgUJJVRUppYF3=aUXvRtWfqfpM=BHapN9A@mail.gmail.com>
	 <561F64A1.8030805@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40940 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbbJOJk3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 15 Oct 2015 05:40:29 -0400
In-Reply-To: <561F64A1.8030805@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Xiang Wang <wangxfdu@gmail.com>
Cc: xiang.a.wang@intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2015-10-15 at 11:32 +0300, Jarkko Nikula wrote:
> On 10/15/2015 08:46 AM, Xiang Wang wrote:
> > 
> > In conclusion, we have 2 solutions to set the i2c controller speed
> > mode (pci driver):
> > 1) use hardcode value in pci driver
> > 2) use frequency setting of "i2c device" in ACPI table (more 
> > flexible,
> > but looks a bit strange)
> > 
> > Do you have any preference/suggestions for above solutions? Thanks
> 
> I don't think we can hard code especially the high-speed mode because 
> 
> most typically buses are populated with slower devices.
> 
> Things are a bit more clear when ACPI provides timing parameters for 
> the 
> bus (for standard and fast speed modes at the moment in 
> i2c-designware-platdrv.c: dw_i2c_acpi_configure()) but still I think 
> the 
> ACPI namespace walk may be needed against potential BIOS 
> misconfigurations. For instance if it provides timing parameters for 
> all 
> speeds but there are devices with lower speed on the same bus.
> 
> I'd take these timing parameters as configuration data for bus 
> features 
> but actual speed (speed bits in IC_CON register) is defined 
> separately. 
> To me it looks only way to achieve that is to pick slowest device 
> from 
> I2cSerialBus resource descriptors.

Should it (ACPI walk) be done in PCI case as well? If so, then it needs
to be done up to i2c-core. There you may adjust the bus speed whenever
slave device is enumerated.

For PCI case you have still to have hardcoded values and it should be
maximum supported by the bus I think. When you have implemented above
algorithm you may do this safely. Am I missing something?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
