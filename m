From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
Date: Wed, 8 Aug 2018 11:47:47 +0200
Message-ID: <69e355c2-89ea-16bc-3d52-4ef9d0eb953b@axentia.se>
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
 <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, John Garry <john.garry@huawei.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-08-08 11:08, Andy Shevchenko wrote:
> On Wed, Aug 8, 2018 at 11:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
>> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
>> i2c-device.
>>
>> But in some rare cases the manufacturer has decided to describe multiple
>> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>>
>> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
>> code to support this corner-case.
>>
>> This commit introduces a new i2c-multi-instantiate driver which fixes this
>> in a different way. This new driver can be built as a module which will
>> only loaded on affected systems.
>>
>> This driver will instantiate a new i2c-client per I2cSerialBus resource,
>> using the driver_data from the acpi_device_id it is binding to to tell it
>> which chip-type (and optional irq-resource) to use when instantiating.
>>
>> Note this driver depends on a platform device being instantiated for the
>> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
>> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> 
> Thanks for an update! My comments below.
> 
>> +struct i2c_inst_data {
>> +       const char *type;
>> +       int irq_idx;
>> +};
> 
>> +struct i2c_multi_inst_data {
> 
>> +       int no_clients;
> 
> Name a bit confusing. What about num_clients?
> 
>> +       struct i2c_client *clients[0];
>> +};
>> +
>> +static int i2c_multi_inst_probe(struct platform_device *pdev)
>> +{
>> +       struct i2c_multi_inst_data *multi;
>> +       const struct acpi_device_id *match;
>> +       const struct i2c_inst_data *inst_data;
>> +       struct i2c_board_info board_info = {};
>> +       struct device *dev = &pdev->dev;
>> +       struct acpi_device *adev;
>> +       char name[32];
>> +       int i, ret;
>> +
>> +       match = acpi_match_device(dev->driver->acpi_match_table, dev);
>> +       if (!match) {
>> +               dev_err(dev, "Error ACPI match data is missing\n");
>> +               return -ENODEV;
>> +       }
>> +       inst_data = (const struct i2c_inst_data *)match->driver_data;
>> +
>> +       adev = ACPI_COMPANION(dev);
>> +
> 
>> +       /* Count number of clients to instantiate */
>> +       for (i = 0; inst_data[i].type; i++) {}
>> +
>> +       multi = devm_kmalloc(dev,
>> +                       offsetof(struct i2c_multi_inst_data, clients[i]),
>> +                       GFP_KERNEL);
>> +       if (!multi)
>> +               return -ENOMEM;
> 
> Here I see the following:
>  - it's kinda unusual use of offsetof(), perhaps i*sizeof() + sizeof()
> would be more understandable
>  - there is no guard against i == 0

I don't see why a guard is needed? *Your* code below needs it, but that
issue is not a concern for the original code. It might however be a
good idea to fail the probe if there are no clients to instantiate, but
that's a different issue...

> 
> To solve both, it might be like
> 
> struct i2c_multi_inst_data {
>        int num_clients;
>        struct i2c_client *clients;
> };
> 
> ...
> multi = devm_kmalloc(sizeof(*multi), GFP_KERNEL);
> if (!multi)
>  return -ENOMEM;
> 
> multi->clients = devm_kcalloc(i, sizeof(*multi->clients), GFP_KERNEL);
> if (ZERO_PTR_OR_NULL(multi->clients))
>  return -ENOMEM;
> 
> But I would like to hear your (other's) opinion(s).

I think using two allocations is a waste in this case.

> 
>> +
>> +       multi->no_clients = i;
>> +
>> +       for (i = 0; i < multi->no_clients; i++) {
>> +               memset(&board_info, 0, sizeof(board_info));
>> +               strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
>> +               snprintf(name, sizeof(name), "%s-%s", match->id,
>> +                        inst_data[i].type);
>> +               board_info.dev_name = name;
>> +               board_info.irq = 0;
> 
>> +               if (inst_data[i].irq_idx != -1) {
> 
>> = 0 sounds more robust

But not as flexible/future-proof. Why should 0 be the only valid IRQ index?

Cheers,
Peter

>> +                       ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
>> +                       if (ret < 0) {
> 
>> +                               dev_err(dev, "Error requesting irq at index %d: %d\n",
>> +                                       inst_data[i].irq_idx, ret);
> 
> irq -> IRQ in the message.
> 
>> +                               goto error;
>> +                       }
>> +                       board_info.irq = ret;
>> +               }
>> +               multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>> +               if (!multi->clients[i]) {
>> +                       dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>> +                       ret = -ENODEV;
>> +                       goto error;
>> +               }
>> +       }
>> +
>> +       platform_set_drvdata(pdev, multi);
>> +       return 0;
>> +
>> +error:
> 
>> +       while (--i >= 0)
> 
> It can be simple
> 
> while (i--)
> 
>> +               i2c_unregister_device(multi->clients[i]);
>> +
>> +       return ret;
>> +}
>> +
>> +static int i2c_multi_inst_remove(struct platform_device *pdev)
>> +{
>> +       struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
>> +       int i;
>> +
>> +       for (i = 0; i < multi->no_clients; i++)
>> +               i2c_unregister_device(multi->clients[i]);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct i2c_inst_data bsg1160_data[]  = {
>> +       { "bmc150_accel", 0 },
>> +       { "bmc150_magn", -1 },
>> +       { "bmg160", -1 },
>> +       {}
>> +};
>> +
>> +/*
>> + * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>> + * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>> + */
>> +static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>> +       { "BSG1160", (unsigned long)bsg1160_data },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
>> +
>> +static struct platform_driver i2c_multi_inst_driver = {
>> +       .driver = {
>> +               .name = "I2C multi instantiate pseudo device driver",
> 
>> +               .acpi_match_table = ACPI_PTR(i2c_multi_inst_acpi_ids),
> 
> We don't need ACPI_PTR for the driver which depends on ACPI.
> In the general case we have an inconsistency with variable definition
> (might be unused).
> 
>> +       },
>> +       .probe = i2c_multi_inst_probe,
>> +       .remove = i2c_multi_inst_remove,
>> +};
>> +module_platform_driver(i2c_multi_inst_driver);
>> +
>> +MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
>> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.18.0
>>
> 
> 
> 
