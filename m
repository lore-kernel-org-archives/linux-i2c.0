From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: i2c-designware-platdrv: Allow a dynamic adap. nr
 without an ACPI fwnode
Date: Tue, 12 Mar 2019 16:47:48 +0200
Message-ID: <c519b0ea-670d-defe-5870-c6258c19ff74@linux.intel.com>
References: <20190311112216.31391-1-hdegoede@redhat.com>
 <20190311112216.31391-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311112216.31391-2-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 3/11/19 1:22 PM, Hans de Goede wrote:
> Before this commit the i2c-designware-platdrv assumes that if the pdev
> has an apci-companion it should use a dynamic adapter-nr and otherwise
> it will use pdev->id as adapter-nr.
> 
> On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
> some of the LPSS i2c-adapters are enumerated through PCI and do not have
> an ACPI fwnode. These devices are handled as mfd devices so they end up
> using the i2c-designware-platdrv driver.
> 
> This results in the i2c-adapter being registered with the mfd generated
> pdev->id as adapter-nr, which conflicts with existing adapters, triggering
> a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
> adapter registration to fail.
> 
I went thinking would we get a regression if we switch the 
i2c-designware-platdrv to dynamic numbering unconditionally?

Only drivers/mfd/intel-lpss.c and drivers/mfd/intel_quark_i2c_gpio.c 
register platform device "i2c_designware" and otherwise in the driver 
itself for known ACPI IDs and device tree bindings.

Things should be fine for ACPI cases if slave devices are also described 
in ACPI tables. As far as I've understood with device tree matching 
adapter number is irrelevant in slave device registration?

Andy: could you tell by commit 918fe70cf475 ("mfd: intel_quark_i2c_gpio: 
support devices behind i2c bus") are those devices described in ACPI or 
in some i2c_board_infos with referring to fixed adapter number either in 
or out of kernel tree code?

Then drivers/platform/chrome/chromeos_laptop.c is the only code 
searching for adapter named as "Synopsys DesignWare I2C adapter" without 
assuming any fixed adapter numbering.

What's unclear to me can there be device tree cases where i2c-designware 
probing comes with pdev->id not starting from zero or in different 
order? I.e. would it make difference do we use pdev->id or dynamic 
adapter numbering?

-- 
Jarkko
