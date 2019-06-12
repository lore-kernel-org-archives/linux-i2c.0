From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Wed, 12 Jun 2019 18:27:18 +0300
Message-ID: <20190612152718.GC2640@lahna.fi.intel.com>
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 11, 2019 at 01:30:58PM +0100, Charles Keepax wrote:
> In preparation for more refactoring make i2c_acpi_get_irq available
> outside i2c-core-acpi.c.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
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
>  	return 1; /* No need to add resource to the list */
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
> +	struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);

Is this adev checked for being NULL somewhere below before it is being
dereferenced?

It could explain the issue Benjamin is seeing.

>  	struct list_head resource_list;
>  	int irq = -ENOENT;
>  	int ret;
