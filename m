From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] MFD: Add U300 AB3100 core support v3
Date: Wed, 20 May 2009 10:36:22 +0200
Message-ID: <63386a3d0905200136i64bde4acw8944443a005f5d30@mail.gmail.com>
References: <63386a3d0905190736q574d0379hb529aaa105aa36f3@mail.gmail.com>
	 <20090519230601.GF23114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090519230601.GF23114-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks Ben, v4 due soon..

2009/5/20 Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:

>> +#define AB3100_DEVICE(devname, devid, regstart, regend)              \
>> +static struct resource ab3100_##devname##_resource[] = {     \
>> +     {                                                       \
>> +             .start  = regstart,                             \
>> +             .end    = regend,                               \
>> +             .flags  = IORESOURCE_IO,                        \
>> +     }                                                       \
>
> is IORESOURCE_IO a good idea here, we may need to add some form of
> flag to say 'generic data' and for the driver core to not try and
> register it with any of the ioport or iomem structures.

I'll remove it for the time being, it's not used currently anyway.

Yell if you want me to create a patch to include/linux/platform_devices.h
for this too...

>> +     {
>> +             .id = 0xc8,
>> +             .name = "P2B/R2B"
>> +     },
>
> doing }, { would makes these shorter still.

Yeah CodingStyle actually say so if I read it closely, I'll fix.

Yours,
Linus Walleij
