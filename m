From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: i2c-mxs woes
Date: Fri, 19 Apr 2013 14:07:13 +0200
Message-ID: <51713371.6030805@free-electrons.com>
References: <51712C8B.7070302@free-electrons.com> <1366372407.4146.3.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366372407.4146.3.camel-WzVe3FnzCwFR6QfukMTsflXZhhPuCNm+@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Lucas,

On 19/04/2013 13:53, Lucas Stach wrote:
> Hi Alexandre,
>
> Am Freitag, den 19.04.2013, 13:37 +0200 schrieb Alexandre Belloni:
>> Hi,
>>
>> I'm having some issues with the i2c-mxs driver in 3.9. Marek already
>> pointed me to the patches from Lucas and that greatly improved the
>> situation.
>>
>> For the context, my board has three nau7802 adcs, connected to a gpio
>> i2c-muxer, connected to i2c1.
>>
>> Here is what I observe:
>>
>> On 3.9:
>>
>> # time cat /sys/bus/iio/devices/iio:device1/in_voltage0_raw 
>> 2620
>> real	0m 7.08s
>> user	0m 0.00s
>> sys	0m 0.02s
>> # time cat /sys/bus/iio/devices/iio:device1/in_voltage1_raw 
>> 2623
>> real	0m 6.07s
>> user	0m 0.01s
>> sys	0m 0.01s
>> # 
>>
> Is this with or without my patches? Before introduction of the error
> handling in PIO code there were a lot of situations where the controller
> would signal an error, but the driver would go on as usual, so the next
> transaction wouldn't succeed and stop for a whole second until the
> timeout hits and resets the controller.

This is with v2 of your patches. I applied "i2c-mxs remove races in PIO
code" and "i2c-mxs do error checking and handling in PIO mode"

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
