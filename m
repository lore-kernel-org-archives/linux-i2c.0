From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 00/15] i2c-multi-instantiate: Adapt for INT3515 and
 alike
Date: Wed, 28 Nov 2018 15:12:26 +0200
Message-ID: <20181128131226.GC32679@kuha.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 28, 2018 at 01:45:20PM +0200, Andy Shevchenko wrote:
> Currently i2c-multi-instantiate driver does not support the case
> of INT3515 USB PD device, where:
> 
> - Interrupt() is used instead of GpioInt()
> - All slaves may be the same from IP point of view
> - There can be variadic amount of slaves
> 
> This series is addressing all above.
> 
> Note, series has been smoke tested (Heikki would do BAT or more)
> on Intel Coffee Lake system.
> 
> The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
> In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.
> 
> Testing and comments are warmly welcome.

Looks good to me. The series, FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> In v5:
> - unmess with patches 3 and 4 (there were squashed by my mistake)
> - other than above no code change from v4
> 
> In v4:
> - directly return -EPROBE_DEFER from i2c_acpi_new_device()
> - due to above split error handling simplification to separate patches
> 
> In v3:
> - revisit error codes returned by i2c_acpi_new_device() (Hans, Mika)
> - add documentation to exported i2c_acpi_get_i2c_resource() (Mika)
> - drop Hans' Rb tag in patch 5 due to changes
> - append Mika's Ab tag to patch 6
> 
> In v2:
> - drop patches to copy fwnode and to handle BOSC0200 device
> - append check for amount of devices listed in the driver's mapping
> - add Rb tag given by Hans
> 
> Andy Shevchenko (15):
>   platform/x86: intel_cht_int33fe: Remove duplicate NULL check
>   platform/x86: intel_cht_int33fe: Accept errors of
>     i2c_acpi_new_device()
>   platform/x86: i2c-multi-instantiate: Accept errors of
>     i2c_acpi_new_device()
>   platform/x86: i2c-multi-instantiate: Defer probe when no adapter found
>   i2c: acpi: Return error pointers from i2c_acpi_new_device()
>   platform/x86: intel_cht_int33fe: Get rid of obsolete conditional
>   platform/x86: i2c-multi-instantiate: Get rid of obsolete conditional
>   i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
>   i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
>   platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
>   platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
>   platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
>   platform/x86: i2c-multi-instantiate: Allow to have same slaves
>   ACPI / scan: Create platform device for INT3515 ACPI nodes
>   iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
> 
>  drivers/acpi/scan.c                          |  1 +
>  drivers/i2c/i2c-core-acpi.c                  | 64 +++++++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
>  drivers/platform/x86/i2c-multi-instantiate.c | 97 ++++++++++++++++----
>  drivers/platform/x86/intel_cht_int33fe.c     | 20 ++--
>  drivers/usb/typec/tps6598x.c                 |  8 +-
>  include/linux/acpi.h                         | 11 +++
>  7 files changed, 157 insertions(+), 60 deletions(-)
> 
> --
> 2.19.2

-- 
heikki
