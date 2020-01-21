From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/6] ACPI: Add a convenience function to tell a device
 is in low power state
Date: Tue, 21 Jan 2020 17:07:23 +0100
Message-ID: <CAJZ5v0j8z3eiv6vG6sGeQM=f-BMoq_5OeARjm=LdO20gcOEybA@mail.gmail.com>
References: <20200121134157.20396-1-sakari.ailus@linux.intel.com> <20200121134157.20396-3-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200121134157.20396-3-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org, Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>, Hyungwoo Yang <hyungwoo.yang@intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, Tomasz Figa <tfiga@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 21, 2020 at 2:41 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Add a convenience function to tell whether a device is in low power state,
> primarily for use in drivers' probe or remove functions on busses where
> the custom is to power on the device for the duration of both.
>
> Returns false on non-ACPI systems.
>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/device_pm.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/acpi.h     |  5 +++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 5e4a8860a9c0c..d3174c6edf915 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1348,4 +1348,35 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>         return 1;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> +
> +/**
> + * acpi_dev_state_low_power - Check the current ACPI power state of a device.
> + * @dev: Physical device the ACPI power state of which to check
> + *
> + * On a system without ACPI, return false. On a system with ACPI, return true if
> + * the current ACPI power state of the device is not D0, or false otherwise.
> + *
> + * Note that the power state of a device is not well-defined after it has been
> + * passed to acpi_device_set_power() and before that function returns, so it is
> + * not valid to ask for the ACPI power state of the device in that time frame.
> + */
> +bool acpi_dev_state_low_power(struct device *dev)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +       int power_state;
> +       int ret;
> +
> +       if (!adev)
> +               return false;
> +
> +       ret = acpi_device_get_power(adev, &power_state);
> +       if (ret) {
> +               dev_dbg(dev, "Cannot obtain power state (%d)\n", ret);
> +               return false;
> +       }
> +
> +       return power_state != ACPI_STATE_D0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_state_low_power);
> +
>  #endif /* CONFIG_PM */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0f37a7d5fa774..aa666da311444 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -926,6 +926,7 @@ int acpi_dev_resume(struct device *dev);
>  int acpi_subsys_runtime_suspend(struct device *dev);
>  int acpi_subsys_runtime_resume(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
> +bool acpi_dev_state_low_power(struct device *dev);
>  #else
>  static inline int acpi_dev_runtime_suspend(struct device *dev) { return 0; }
>  static inline int acpi_dev_runtime_resume(struct device *dev) { return 0; }
> @@ -935,6 +936,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
>         return 0;
>  }
> +static inline bool acpi_dev_state_low_power(struct device *dev)
> +{
> +       return false;
> +}
>  #endif
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
> --
> 2.20.1
>
