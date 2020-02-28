From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [RFC PATCH 7/7] i2c: core: hand over reserved devices when
 requesting ancillary addresses
Date: Fri, 28 Feb 2020 13:11:53 +0100
Message-ID: <dc831357-8545-6f6e-71a2-bef282e0bd94@lucaceresoli.net>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
 <20200220172403.26062-8-wsa+renesas@sang-engineering.com>
 <CAMuHMdV-dfjukuSKiFg4vb4Ntn+XWU0XwHPxyoaWs1vtQVg4cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV-dfjukuSKiFg4vb4Ntn+XWU0XwHPxyoaWs1vtQVg4cw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-i3c@lists.infradead.org, Kieran Bingham <kieran@ksquared.org.uk>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>, Jacopo Mondi <jacopo@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vladimir Zapolskiy <vz@mleia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 21/02/20 11:13, Geert Uytterhoeven wrote:
> Hi Wolfram,
> 
> On Thu, Feb 20, 2020 at 6:26 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
>> With i2c_new_ancillary_address, we can check if the intended driver is
>> requesting a reserved address. Update the function to do these checks.
>> If the check passes, the "reserved" device will become a regular "dummy"
>> device.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/i2c/i2c-core-base.c
>> +++ b/drivers/i2c/i2c-core-base.c
>> @@ -975,6 +975,8 @@ struct i2c_client *i2c_new_ancillary_device(struct i2c_client *client,
>>                                                 u16 default_addr)
>>  {
>>         struct device_node *np = client->dev.of_node;
>> +       struct device *reserved_dev, *adapter_dev = &client->adapter->dev;
>> +       struct i2c_client *reserved_client;
>>         u32 addr = default_addr;
>>         int i;
>>
>> @@ -984,7 +986,21 @@ struct i2c_client *i2c_new_ancillary_device(struct i2c_client *client,
>>                         of_property_read_u32_index(np, "reg", i, &addr);
>>         }
>>
>> -       dev_dbg(&client->adapter->dev, "Address for %s : 0x%x\n", name, addr);
>> +       dev_info(adapter_dev, "Address for %s : 0x%x\n", name, addr);
>> +
>> +       /* No need to scan muxes, siblings must sit on the same adapter */
>> +       reserved_dev = device_find_child(adapter_dev, &addr, __i2c_check_addr_busy);
>> +       reserved_client = i2c_verify_client(reserved_dev);
>> +
>> +       if (reserved_client) {
>> +               if (reserved_client->dev.of_node != np ||
>> +                   strcmp(reserved_client->name, I2C_RESERVED_DRV_NAME) != 0)
>> +                       return ERR_PTR(-EBUSY);
> 
> Missing put_device(reserved_dev).
> 
>> +
>> +               strlcpy(reserved_client->name, I2C_DUMMY_DRV_NAME, sizeof(client->name));

Any strong reason for not giving the device a more informative name?
Reading "dummy" in several /sys/bus/i2c/devices/?-????/name files is not
helping. Using the 'name' string that is passed to
i2c_new_ancillary_device() would be way better, perhaps prefixed by
dev->name. But this opens the question of why not doing it in
i2c_new_dummy_device() as well, which currently receives no "name"
parameter.

Of course this is not strictly related to this patch and can be done in
a later step.

About the patch itself, except for the issues pointed out by Geert the
approach looks generally good to me.

-- 
Luca
