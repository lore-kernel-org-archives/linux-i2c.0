From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 13/22] i2c: core: Probe i2c master devices on demand
Date: Sun, 9 Aug 2015 15:37:36 +0200
Message-ID: <CAAObsKBUxtdT7gsO9mh__E5kFamp9yPUAetxJJ=ftV4Bu_b2HA@mail.gmail.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-14-git-send-email-tomeu.vizoso@collabora.com> <20150809123430.GB1521@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150809123430.GB1521@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 9 August 2015 at 14:34, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Tue, Jul 28, 2015 at 03:19:44PM +0200, Tomeu Vizoso wrote:
>> When looking up an i2c master through its firmware node, probe it if it
>> hasn't already.
>>
>> The goal is to reduce deferred probes to a minimum, as it makes it very
>> cumbersome to find out why a device failed to probe, and can introduce
>> very big delays in when a critical device is probed.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>
> What is the status of this series?

See here for a summary:

http://lkml.kernel.org/g/1438870315-18689-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org

> The boot time reduction sounds great.

Note that this should not reduce total boot time substantially, as the
time wasted due to superfluous probe deferrals is really small when
compared to the time spent in delays due to hardware constraints. If
you want to reduce total boot time, async probing may be helpful in
some scenarios.

Regards,

Tomeu

>> ---
>>
>> Changes in v2: None
>>
>>  drivers/i2c/i2c-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index e6d4935161e4..5520b413e3db 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -1353,6 +1353,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
>>  {
>>       struct device *dev;
>>
>> +     fwnode_ensure_device(&node->fwnode);
>
> TBH, the function name doesn't tell me a lot. It ensures what?
>
>> +
>>       dev = bus_find_device(&i2c_bus_type, NULL, node,
>>                                        of_dev_node_match);
>>       if (!dev)
>> --
>> 2.4.3
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
