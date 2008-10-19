From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add the of_find_i2c_device_by_node function
Date: Sun, 19 Oct 2008 17:50:15 -0400
Message-ID: <9e4733910810191450t36cbe120y106d18f71cb3163b@mail.gmail.com>
References: <20081019140040.32281.65209.stgit@terra>
	<20081019212034.GA8224@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081019212034.GA8224-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 19, 2008 at 5:20 PM, Anton Vorontsov
<avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org> wrote:
> Hi Jon,
>
> On Sun, Oct 19, 2008 at 10:00:40AM -0400, Jon Smirl wrote:
>> Add the of_find_i2c_device_by_node function. This allows you to follow
>> a reference in the device tree to an i2c device node and then locate
>> the linux device instantiated by the device tree. Example use, an i2s
>> codec controlled by i2c. Depends on patch exporting i2c root bus symbol.
>>
>> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Few comments are below.
>
>> ---
>>  drivers/of/of_i2c.c |   28 ++++++++++++++++++++++++----
>>  1 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
>> index 6a98dc8..ba7b394 100644
>> --- a/drivers/of/of_i2c.c
>> +++ b/drivers/of/of_i2c.c
>> @@ -19,7 +19,7 @@
>>  void of_register_i2c_devices(struct i2c_adapter *adap,
>>                            struct device_node *adap_node)
>>  {
>> -     void *result;
>> +     struct i2c_client *i2c_dev;
>>       struct device_node *node;
>>
>>       for_each_child_of_node(adap_node, node) {
>> @@ -41,18 +41,38 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>>
>>               info.addr = *addr;
>>
>> -             request_module(info.type);
>> +             request_module("%s", info.type);
>
> Patch description doesn't mention this change.

Patches for this have been posted before by other people and they
aren't making it in.

This is the original mail....
http://lkml.org/lkml/2008/6/13/290
http://lkml.org/lkml/2008/6/12/8
I can't find the ones patching i2c.


>
>>
>> -             result = i2c_new_device(adap, &info);
>> -             if (result == NULL) {
>> +             i2c_dev = i2c_new_device(adap, &info);
>> +             if (i2c_dev == NULL) {
>>                       printk(KERN_ERR
>>                              "of-i2c: Failed to load driver for %s\n",
>>                              info.type);
>>                       irq_dispose_mapping(info.irq);
>>                       continue;
>>               }
>> +
>> +             i2c_dev->dev.archdata.of_node = of_node_get(node);
>
> Would break sparc build. Plus setting this after i2c_new_device() isn't
> right... Recently I sent few patches to deal with the archdata, could
> you please rebase your patch against these three patches?
>
> http://lkml.org/lkml/2008/10/16/250
> http://lkml.org/lkml/2008/10/16/251
> http://lkml.org/lkml/2008/10/16/252
>
>>       }
>>  }
>>  EXPORT_SYMBOL(of_register_i2c_devices);
>>
>> +static int of_dev_node_match(struct device *dev, void *data)
>> +{
>> +        return dev->archdata.of_node == data;
>> +}
>> +
>> +struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
>
> This should be documented. Especially the fact that every time you
> call this function, you must call device_put() when you're done with
> the returned i2c_client.
>
>> +{
>> +     struct device *dev;
>> +
>> +     dev = bus_find_device(&i2c_bus_type, NULL, node,
>> +                                      of_dev_node_match);
>> +     if (!dev)
>> +             return NULL;
>> +
>> +     return to_i2c_client(dev);
>> +}
>> +EXPORT_SYMBOL(of_find_i2c_device_by_node);
>> +
>>  MODULE_LICENSE("GPL");
>> diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
>> index bd2a870..17d5897 100644
>> --- a/include/linux/of_i2c.h
>> +++ b/include/linux/of_i2c.h
>> @@ -16,5 +16,7 @@
>>
>>  void of_register_i2c_devices(struct i2c_adapter *adap,
>>                            struct device_node *adap_node);
>> +struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
>> +
>>
>>  #endif /* __LINUX_OF_I2C_H */
>
> Thanks,
>
> --
> Anton Vorontsov
> email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> irc://irc.freenode.net/bd2
>



-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
