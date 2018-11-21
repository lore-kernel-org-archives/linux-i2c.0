From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 09/15] platform/x86: i2c-multi-instantiate: Count
 I2cSerialBus() resources
Date: Wed, 21 Nov 2018 13:03:35 +0100
Message-ID: <0241e59f-f00b-f1be-9861-62d5da184b24@redhat.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-10-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120155924.10773-10-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 20-11-18 16:59, Andy Shevchenko wrote:
> Instead of relying on hard coded and thus expected number of I2C clients,
> count the real amount provided by firmware.
> 
> This allows to support non-fixed amount of the slaves.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/platform/x86/i2c-multi-instantiate.c | 34 ++++++++++++++++++--
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index 16a0eabe1e31..d17686e10d08 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -12,6 +12,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/types.h>
>   
>   struct i2c_inst_data {
>   	const char *type;
> @@ -23,6 +24,31 @@ struct i2c_multi_inst_data {
>   	struct i2c_client *clients[0];
>   };
>   
> +static int i2c_multi_inst_count(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_i2c_serialbus *sb;
> +	int *count = data;
> +
> +	if (i2c_acpi_get_i2c_resource(ares, &sb))
> +		*count = *count + 1;
> +
> +	return 1;
> +}
> +
> +static int i2c_multi_inst_count_resources(struct acpi_device *adev)
> +{
> +	LIST_HEAD(r);
> +	int count = 0;
> +	int ret;
> +
> +	ret = acpi_dev_get_resources(adev, &r, i2c_multi_inst_count, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_dev_free_resource_list(&r);
> +	return count;
> +}
> +
>   static int i2c_multi_inst_probe(struct platform_device *pdev)
>   {
>   	struct i2c_multi_inst_data *multi;
> @@ -44,15 +70,17 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>   	adev = ACPI_COMPANION(dev);
>   
>   	/* Count number of clients to instantiate */
> -	for (i = 0; inst_data[i].type; i++) {}
> +	ret = i2c_multi_inst_count_resources(adev);
> +	if (ret < 0)
> +		return ret;
>   
>   	multi = devm_kmalloc(dev,
> -			offsetof(struct i2c_multi_inst_data, clients[i]),
> +			offsetof(struct i2c_multi_inst_data, clients[ret]),
>   			GFP_KERNEL);
>   	if (!multi)
>   		return -ENOMEM;
>   
> -	multi->num_clients = i;
> +	multi->num_clients = ret;
>   
>   	for (i = 0; i < multi->num_clients; i++) {
>   		memset(&board_info, 0, sizeof(board_info));

Now you end up indexing inst_data with i without checking that inst_data
holds enough data. Not using all of inst_data in case there are less
I2cSerialBus resources then inst_data entries is fine. But you need to
deal with the case when there are more I2cSerialBus resources then inst_data
entries, either by erroring out or ignoring the extra I2cSerialBus resources.

Also it might be better to make the i2c_multi_inst_count_resources() function
a generic helper under drivers/acpi, so that it can be used in other places,
see my comments to the BOSC0200 patch.

Regards,

Hans
