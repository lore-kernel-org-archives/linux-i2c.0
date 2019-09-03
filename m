From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [RFC,v2 3/6] media: dt-bindings: add DS90UB954-Q1 video
 deserializer
Date: Tue, 3 Sep 2019 11:09:55 +0200
Message-ID: <63d99d6d-ecdd-7dd8-0dcb-126bfd89b258@lucaceresoli.net>
References: <20190723203723.11730-1-luca@lucaceresoli.net>
 <20190723203723.11730-4-luca@lucaceresoli.net> <20190902204841.GB7253@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190902204841.GB7253@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Vladimir Zapolskiy <vz@mleia.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 02/09/19 22:48, Wolfram Sang wrote:
> 
>> + - i2c-alias-pool: list of I2C addresses that are known to be available on the
>> +                   "local" (SoC-to-deser) I2C bus; they will be picked at
>> +		   runtime and used as aliases to reach remove I2C chips
> 
> After some internal discussion, I have been kinda convinced that it may
> be better to assume all non-described addresses are free to use and
> enter the pool.
> 
> The problem with the binding above is that you may run out of aliases
> depending on how many aliases one to-be-attached module needs or how
> many modules will be attached.

Not if you define enough addresses in the pool. E.g. the DS90UB954
hardware can have 8 aliases per port, so if you have (n_ports * 8)
addresses in the pool the problem is solved.

> And another add-on module with
> non-repogrammable devices may occupy addresses from the defined pool
> above.

You mean a new device on the local (SoC-to-ATR) bus? Well, it could as
well occupy a non-described address that the ATR has already picked as
an alias.

> I am not perfectly happy with the assumption that all undescribed
> addresses are automatically free. That also might need DTS updates to
> describe all clients properly. But this change only needs to be done
> once, and it will improve the description of the hardware.

Right, but I still suspect some users won't do their homework and
discover address conflicts at runtime, maybe months later, in a painful
way. Also a chip might be undocumented on a given board, so they could
do their homework and still have problems.

Despite my comments, I'm not strongly against your proposal. To me it
doesn't seem to solve any problem, while it does introduce some degree
of risk. Could you elaborate more on but what benefit it introduces?

Thanks,
-- 
Luca
