From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Date: Tue, 27 Nov 2018 17:16:04 +0100
Message-ID: <70577604-73cb-f08f-86f8-705029bec56c@redhat.com>
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
 <20181127153728.47866-6-andriy.shevchenko@linux.intel.com>
 <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 27-11-18 17:14, Hans de Goede wrote:
> Hi,
> 
> On 27-11-18 16:37, Andy Shevchenko wrote:
>> The caller would like to know the reason why the i2c_acpi_new_device() fails.
>> For example, if adapter is not available, it might be in the future and we
>> would like to re-probe the clients again. But at the same time we would like to
>> bail out if the error seems unrecoverable, such as invalid argument supplied.
>> To achieve this, return error pointer in some cases.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/i2c/i2c-core-acpi.c                  | 21 ++++++++++++++------
>>   drivers/platform/x86/i2c-multi-instantiate.c |  2 +-
>>   drivers/platform/x86/intel_cht_int33fe.c     |  6 +++---
>>   3 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>> index 32affd3fa8bd..7e872ceaa14f 100644
>> --- a/drivers/i2c/i2c-core-acpi.c
>> +++ b/drivers/i2c/i2c-core-acpi.c
>> @@ -386,20 +386,22 @@ struct notifier_block i2c_acpi_notifier = {
>>    *
>>    * Also see i2c_new_device, which this function calls to create the i2c-client.
>>    *
>> - * Returns a pointer to the new i2c-client, or NULL if the adapter is not found.
>> + * Returns a pointer to the new i2c-client, or error pointer in case of failure.
>> + * Specifically, -ENODEV is returned if the adapter is not found.
>>    */
>>   struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
>>                          struct i2c_board_info *info)
>>   {
>>       struct i2c_acpi_lookup lookup;
>>       struct i2c_adapter *adapter;
>> +    struct i2c_client *client;
>>       struct acpi_device *adev;
>>       LIST_HEAD(resource_list);
>>       int ret;
>>       adev = ACPI_COMPANION(dev);
>>       if (!adev)
>> -        return NULL;
>> +        return ERR_PTR(-EINVAL);
>>       memset(&lookup, 0, sizeof(lookup));
>>       lookup.info = info;
>> @@ -408,16 +410,23 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
>>       ret = acpi_dev_get_resources(adev, &resource_list,
>>                        i2c_acpi_fill_info, &lookup);
>> +    if (ret < 0)
>> +        return ERR_PTR(ret);
>> +
>>       acpi_dev_free_resource_list(&resource_list);
>> -    if (ret < 0 || !info->addr)
>> -        return NULL;
>> +    if (!info->addr)
>> +        return ERR_PTR(-EADDRNOTAVAIL);
>>       adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
>>       if (!adapter)
>> -        return NULL;
>> +        return ERR_PTR(-ENODEV);
> 
> Why not simply return -EPROBE_DEFER here (and simplify the callers a lot).
> 
> This is the only case where we really want to defer.
> 
> 
>> +
>> +    client = i2c_new_device(adapter, info);
>> +    if (!client)
>> +        return ERR_PTR(-ENODEV);
> 
> If you look at i2c_new_device, it can fail because it is
> out of memory, the i2c slave address is invalid, or
> their already is an i2c slave with the same address,
> iow if this were to return an ERR_PTR itself, this
> would return -ENOMEM, -EINVAL or -EBUSY and never
> -EPROBE_DEFER.
> 
> Note keeping the -ENODEV here is fine, what I'm trying
> to say is that in this case the caller of i2c_acpi_new_device
> really should not return PROBE_DEFER, so directly returning
> EPROBE_DEFER above, rather then let the caller guess is better.
> 
> And e.g. this:
> 
>                  multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>                  if (IS_ERR(multi->clients[i]))
>                          ret = PTR_ERR(multi->clients[i]);
>                  else if (!multi->clients[i])
>                          ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>                  else
>                          ret = 0;
>                  if (ret) {
>                          dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>                          goto error;
>                  }
> 
> Can be simplified to:
> 
>                  multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>                  if (IS_ERR(multi->clients[i])) {
>                          ret = PTR_ERR(multi->clients[i]);
>                          dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>                          goto error;
>                  }

Correction, that should be:

                 multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
                 if (IS_ERR(multi->clients[i])) {
                         ret = PTR_ERR(multi->clients[i]);
                         if (ret != -EPROBE_DEFER)
                                 dev_err(dev, "Error creating i2c-client, idx %d\n", i);
                         goto error;
                 }

We don't want to log an error when deferring.

Regards,

Hans



> 
> This will also allow you to split out the patches cleaning up the callers
> without having a bisect problem (the NULL case will now simply never happen).
> 
> Regards,
> 
> Hans
> 
> 
>> -    return i2c_new_device(adapter, info);
>> +    return client;
>>   }
>>   EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>> index 0e3a36f3ef64..18928e4ede7f 100644
>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>> @@ -72,7 +72,7 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>>               board_info.irq = ret;
>>           }
>>           multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>> -        if (!multi->clients[i])
>> +        if (PTR_ERR(multi->clients[i]) == -ENODEV)
>>               ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>>           else if (IS_ERR(multi->clients[i]))
>>               ret = PTR_ERR(multi->clients[i]);
> 
> 
>> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
>> index 3ba139d3bd03..b8cab17ec596 100644
>> --- a/drivers/platform/x86/intel_cht_int33fe.c
>> +++ b/drivers/platform/x86/intel_cht_int33fe.c
>> @@ -168,7 +168,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>>           board_info.dev_name = "max17047";
>>           board_info.properties = max17047_props;
>>           data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
>> -        if (!data->max17047)
>> +        if (PTR_ERR(data->max17047) == -ENODEV)
>>               ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>>           else if (IS_ERR(data->max17047))
>>               ret = PTR_ERR(data->max17047);
>> @@ -200,7 +200,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>>       board_info.irq = fusb302_irq;
>>       data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
>> -    if (!data->fusb302)
>> +    if (PTR_ERR(data->fusb302) == -ENODEV)
>>           ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
>>       else if (IS_ERR(data->fusb302))
>>           ret = PTR_ERR(data->fusb302);
>> @@ -214,7 +214,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>>       strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>>       data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
>> -    if (!data->pi3usb30532)
>> +    if (PTR_ERR(data->pi3usb30532) == -ENODEV)
>>           ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
>>       else if (IS_ERR(data->pi3usb30532))
>>           ret = PTR_ERR(data->pi3usb30532);
>>
