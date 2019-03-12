From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] i2c: i2c-designware-platdrv: Allow a dynamic adap. nr
 without an ACPI fwnode
Date: Tue, 12 Mar 2019 15:49:39 +0100
Message-ID: <4437cb77-ae48-bcc9-56cc-e81e9da011a8@redhat.com>
References: <20190311112216.31391-1-hdegoede@redhat.com>
 <20190311112216.31391-2-hdegoede@redhat.com>
 <20190311125207.GR9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311125207.GR9224@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 11-03-19 13:52, Andy Shevchenko wrote:
> On Mon, Mar 11, 2019 at 12:22:15PM +0100, Hans de Goede wrote:
>> Before this commit the i2c-designware-platdrv assumes that if the pdev
>> has an apci-companion it should use a dynamic adapter-nr and otherwise
>> it will use pdev->id as adapter-nr.
>>
>> On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
>> some of the LPSS i2c-adapters are enumerated through PCI and do not have
>> an ACPI fwnode. These devices are handled as mfd devices so they end up
>> using the i2c-designware-platdrv driver.
>>
>> This results in the i2c-adapter being registered with the mfd generated
>> pdev->id as adapter-nr, which conflicts with existing adapters, triggering
>> a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
>> adapter registration to fail.
>>
>> This commit adds support for setting a "linux,use-dynamic-adapter-nr"
>> device property on the device to make i2c-designware-platdrv use dynamic
>> adapter-nrs on devices without an ACPI fwnode, together with changes to
>> drivers/mfd/intel-lpss-pci.c to set this, this fixes the WARN.
>>
> 
>> Before this commit the setting of the adapter.nr was somewhat convoluted,
>> in the acpi_companion case it was set from dw_i2c_acpi_configure, in the
>> non acpi_companion case it was set from dw_i2c_set_fifo_size() based on
>> tx_fifo_depth not being set yet. This commit also cleans this up.
> 
> Can we split this to two patches, i.e. one is almost the same as this one,
> except the second one adds a new property check to the conditional?

Ok, I've split the patch for v2 of the series.

> If you agree to do so, you may add mine Rb tag to the first one out of three.
> 
>> Note the "linux,use-dynamic-adapter-nr" is meant for kernel internal use
>> only, therefor it is NOT documented under Documents/devicetree/bindings.
> 
> To the second and third ones, can we rather check if the device has fwnode
> either ACPI or swnode? AFAIU now we have swnode assigned during MFD device
> registration and can easily distinguish this w/o any additional properties.

Detecting a swnode is non trivial, it may be either the primary or secondary
fwnode depending if the device already had a node before calling
device_add_properties.

More importantly deciding this based on the presence of a swnode feels like
its "wrong".

But I've come up with a better solution. I've analyzed all ways a designware_i2c
compatible platform-device can be instantiated and all cases except for:

drivers/mfd/intel_quark_i2c_gpio.c
drivers/mfd/intel-lpss-pci.c

Are always using dynamic adapter numbers already. The Quark X1000 has only
1 i2c controller, so there using dynamic adapter numbers will not make a
difference.

And the intel-lpss-pci.c case is the one which we actually want to fix,
devices using this code have many i2c busses so using a fixed bus number
leads to the bus-number conflicts this patch is trying to fix.

So we can simply always use dynamic adapter numbers, see the commit message
of the second patch in v2 of this series for the full analysis.

Regards,

Hans
