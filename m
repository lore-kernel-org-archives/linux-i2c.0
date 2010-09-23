From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C: various updates to the Nomadik I2C controller
Date: Thu, 23 Sep 2010 09:05:53 +0200
Message-ID: <AANLkTinAikrAeVT=xBeAHeqrHNz-D9g8_EOg=qB0NYs5@mail.gmail.com>
References: <1284035372-27994-1-git-send-email-linus.walleij@stericsson.com>
	<20100922002917.GK7494@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100922002917.GK7494-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2010/9/22 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> On Thu, Sep 09, 2010 at 02:29:32PM +0200, Linus Walleij wrote:

>> This applies a few fixes and improvements to the Nomadik I2C
>> controller:

> I would prefer to see these as seperate patches, so that people can
> see what is going on and you can test each seperately when looking
> for bugs. If possible, can these be splut up?

OK! Just sent a 4-patch split set.

>> +/* delay for i2c transfers */
>> +#define I2C_DELAY =A0 =A0 =A0 =A0 =A0 =A0150
>
> it would be helpful to say what the delay is for.

I've tried to be a bit more elaborate...

Thanks Ben!

Yours,
Linus Walleij
