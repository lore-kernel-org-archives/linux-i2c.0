From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: Re: [PATCH] i2c: Fallback to of_node of parent
Date: Sat, 16 Nov 2013 17:11:10 +0100
Message-ID: <CABDT8WzUoPmPzDnjD3w+Oj=jUVcMf91+toWDS+hK6CrXLveCFg@mail.gmail.com>
References: <528791EF.9060505@koalo.de>
	<20131116160601.GA8723@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131116160601.GA8723@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ok, I will try to find all relevant lines.
Where is the best place to document this?

Greetings,
Florian

2013/11/16 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
>
>> +     if (!dev->of_node && dev->parent)
>> +             dev->of_node = dev->parent->of_node;
>> +
>
> That is not enough. Current drivers could then have the assignment
> removed and even more important, this behaviour should be documented.
>
> Regards,
>
>    Wolfram
>
