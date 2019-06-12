From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Wed, 12 Jun 2019 17:11:51 +0200
Message-ID: <CAO-hwJLz1TE5RcBJwVCxa9vWzNk9-mX=4quaWtrXv33kegqRrA@mail.gmail.com>
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com> <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, mika.westerberg@linux.intel.com, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jim Broadus <jbroadus@gmail.com>, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 11, 2019 at 2:31 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> In preparation for more refactoring make i2c_acpi_get_irq available
> outside i2c-core-acpi.c.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

So, my bisect fails here: when I recompile the vmlinuz image, it fails
after loading the initrd. There is no boot up message, so not sure,
but the problem with the non working touchpad is either this one or
the next one.

Cheers,
Benjamin

>
> Changes since v3:
>  - Move the change to use the helper function from i2c-core-base into its own patch.
>
> Thanks,
> Charles
>
>  drivers/i2c/i2c-core-acpi.c | 15 +++++++++++++--
>  drivers/i2c/i2c-core.h      |  7 +++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 7d4d66ba752d4..35966cc337dde 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -144,8 +144,17 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
>         return 1; /* No need to add resource to the list */
>  }
>
> -static int i2c_acpi_get_irq(struct acpi_device *adev)
> +/**
> + * i2c_acpi_get_irq - get device IRQ number from ACPI
> + * @client: Pointer to the I2C client device
> + *
> + * Find the IRQ number used by a specific client device.
> + *
> + * Return: The IRQ number or an error code.
> + */
> +int i2c_acpi_get_irq(struct i2c_client *client)
>  {
> +       struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);
>         struct list_head resource_list;
>         int irq = -ENOENT;
>         int ret;
> @@ -162,6 +171,8 @@ static int i2c_acpi_get_irq(struct acpi_device *adev)
>         return irq;
>  }
>
> +static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev);
> +
>  static int i2c_acpi_get_info(struct acpi_device *adev,
>                              struct i2c_board_info *info,
>                              struct i2c_adapter *adapter,
> @@ -198,7 +209,7 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
>                 *adapter_handle = lookup.adapter_handle;
>
>         /* Then fill IRQ number if any */
> -       ret = i2c_acpi_get_irq(adev);
> +       ret = i2c_acpi_get_irq(i2c_acpi_find_client_by_adev(adev));
>         if (ret > 0)
>                 info->irq = ret;
>
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 2a3b28bf826b1..517d98be68d25 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -63,6 +63,8 @@ const struct acpi_device_id *
>  i2c_acpi_match_device(const struct acpi_device_id *matches,
>                       struct i2c_client *client);
>  void i2c_acpi_register_devices(struct i2c_adapter *adap);
> +
> +int i2c_acpi_get_irq(struct i2c_client *client);
>  #else /* CONFIG_ACPI */
>  static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
>  static inline const struct acpi_device_id *
> @@ -71,6 +73,11 @@ i2c_acpi_match_device(const struct acpi_device_id *matches,
>  {
>         return NULL;
>  }
> +
> +static inline int i2c_acpi_get_irq(struct i2c_client *client)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_ACPI */
>  extern struct notifier_block i2c_acpi_notifier;
>
> --
> 2.11.0
>
