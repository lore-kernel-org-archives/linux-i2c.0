From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 06/10] mfd: Add core driver for AD242x A2B transceivers
Date: Wed, 18 Dec 2019 12:20:58 +0100
Message-ID: <e288a6e1-a967-d7cd-72fc-d190819953e3@lucaceresoli.net>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-8-daniel@zonque.org> <20191217133952.GJ18955@dell>
 <ce6e0b19-ec40-c17b-cee6-05eca52d5df3@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ce6e0b19-ec40-c17b-cee6-05eca52d5df3@zonque.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, lars@metafoo.de, pascal.huerst@gmail.com
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On 17/12/19 20:24, Daniel Mack wrote:
>>> +++ b/drivers/mfd/ad242x-bus.c
>>> @@ -0,0 +1,42 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/init.h>
>>> +#include <linux/mfd/ad242x.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +
>>> +static int ad242x_bus_i2c_probe(struct i2c_client *i2c,
>>> +                const struct i2c_device_id *id)
>>> +{
>>> +    dev_set_drvdata(&i2c->dev, i2c);
>>> +    i2c_set_clientdata(i2c, &i2c->dev);
>>
>> Please explain to me what you think is happening here.
>>
>>> +    return 0;
>>> +}
>>
>> What does this driver do?  Seems kinda pointless?
> 
> As explained in the commit log, these devices expose two addresses on
> the i2c bus, and each of which exists for a distinct purpose. The
> primary one is used to access registers on the master node itself, the
> second one is proxying traffic to remote nodes.
> 
> Now, the question is how to support that, and the approach chosen here
> is to have a dummy driver sitting on the 2nd address, and to reach out
> to it via a DT phandle from the master node. I don't like that much
> either, but I'm not aware of a cleaner way to bind two addresses with
> one driver. If there is any, I'd be happy to change that.

Have a look at i2c_new_dummy_device(), perhaps it is what you need here.

-- 
Luca
