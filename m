From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 00/15] i2c-multi-instantiate: Adapt for INT3515 and
 alike
Date: Wed, 21 Nov 2018 12:27:48 +0100
Message-ID: <24f96a15-6b57-c19d-b77d-fdc6c11fddc9@redhat.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 20-11-18 16:59, Andy Shevchenko wrote:
> Currently i2c-multi-instantiate driver does not support the case
> of INT3515 USB PD device, where:
> 
> - Interrupt() is used instead of GpioInt()
> - All slaves may be the same from IP point of view
> - There can be variadic amount of slaves
> 
> This series is addressing all above.
> 
> Notes:
> - series has been smoke tested (Heikki would do BAT or more) on Coffee Lake system
> - patch for BOSC0200 might be considered as RFC since the modalias potential issue

Yeah the BOSC0200 patch cannot go upstream as is, that will break the
orientation quirks in hwdb on:

[hans@shalem systemd]$ grep BOSC0200 hwdb/60-sensor.hwdb | wc -l
17
[hans@shalem systemd]$

At least 17 different models laptops / 2-in-1s

> The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
> In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.

Patches 1-5, 7-13 and 15 are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I will send separate replies to:

[PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
[PATCH v1 14/15] ACPI / scan: Create platform device for BOSC0200 ACPI nodes

Which are both a NACK from me (in their current state) because they both will
cause regressions.

Regards,

Hans






> 
> Testing and comments are warmly welcome.
> 
> Andy Shevchenko (15):
>    platform/x86: intel_cht_int33fe: Remove duplicate NULL check
>    platform/x86: intel_cht_int33fe: Accept errors of
>      i2c_acpi_new_device()
>    platform/x86: i2c-multi-instantiate: Accept errors of
>      i2c_acpi_new_device()
>    platform/x86: i2c-mutli-instantiate: Defer probe when no adapter found
>    i2c: acpi: Return error pointers from i2c_acpi_new_device()
>    i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
>    i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
>    i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
>    platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
>    platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
>    platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
>    platform/x86: i2c-multi-instantiate: Allow to have same slaves
>    ACPI / scan: Create platform device for INT3515 ACPI nodes
>    ACPI / scan: Create platform device for BOSC0200 ACPI nodes
>    iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
> 
>   drivers/acpi/scan.c                          |  2 +
>   drivers/i2c/i2c-core-acpi.c                  | 43 +++++----
>   drivers/iio/accel/bmc150-accel-i2c.c         |  1 -
>   drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
>   drivers/platform/x86/i2c-multi-instantiate.c | 99 ++++++++++++++++----
>   drivers/platform/x86/intel_cht_int33fe.c     | 34 +++++--
>   drivers/usb/typec/tps6598x.c                 |  8 +-
>   include/linux/acpi.h                         | 11 +++
>   8 files changed, 158 insertions(+), 56 deletions(-)
> 
