From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Fri, 6 Jan 2017 17:12:58 +0000
Message-ID: <1d8b201c-142b-cf88-6965-55aeaaff4dfa@synopsys.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
 <CAL_JsqK1=R6M=vrW5aqmQtMHUGGws_Hb=VHb9RNcvesjfkCjRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqK1=R6M=vrW5aqmQtMHUGGws_Hb=VHb9RNcvesjfkCjRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, roliveir <Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06-Jan-17 16:35, Rob Herring wrote:
> On Thu, Jan 5, 2017 at 11:24 AM, Luis Oliveira
> <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> wrote:
>> This function has the purpose of mode detection by checking the
>> device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
>> Currently only checks using OF functions (ACPI slave not supported yet).
>>
>> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
>> ---
>> Due to the need of checking if the I2C slave address is our own (in
>> other words: if we are the I2C slave) I created a helper function
>> (proposed to me by @Andy) to enable that check.
>> Currently (because I am not able to test it using ACPI) it only
>> supports devicetree declarations.
>>
>>  drivers/i2c/i2c-core.c | 19 +++++++++++++++++++
>>  include/linux/i2c.h    |  1 +
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 3de95a29024c..48e705b23c59 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -3691,6 +3691,25 @@ int i2c_slave_unregister(struct i2c_client *client)
>>         return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(i2c_slave_unregister);
>> +
>> +int i2c_slave_mode_detect(struct device *dev)
> 
> This can be bool instead. Otherwise, looks good to me.
> 

Ok great, thank you.

>> +{
>> +       struct device_node *child;
>> +       u32 reg;
>> +
>> +       if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
>> +               for_each_child_of_node(dev->of_node, child) {
>> +                       of_property_read_u32(child, "reg", &reg);
>> +                       if (reg & I2C_OWN_SLAVE_ADDRESS)
>> +                               return 1;
>> +               }
>> +       } else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
>> +               dev_dbg(dev, "ACPI slave is not supported yet\n");
>> +       }
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_slave_mode_detect);
>> +
>>  #endif
>>
>>  MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index b2109c522dec..53cf99569af5 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -282,6 +282,7 @@ enum i2c_slave_event {
>>
>>  extern int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
>>  extern int i2c_slave_unregister(struct i2c_client *client);
>> +extern int i2c_slave_mode_detect(struct device *dev);
>>
>>  static inline int i2c_slave_event(struct i2c_client *client,
>>                                   enum i2c_slave_event event, u8 *val)
>> --
>> 2.11.0
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
