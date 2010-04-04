From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Sun, 4 Apr 2010 13:00:18 +0200
Message-ID: <t2zf69abfc31004040400wc3330285pe5d4602d31e0a52b@mail.gmail.com>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
	 <20100403162939.GA2190@pengutronix.de>
	 <20100403202329.3bdb407c@hyperion.delvare>
	 <20100404032929.GA12800@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100404032929.GA12800-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 4, 2010 at 5:29 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wr=
ote:
>> > > I'm using PCA9564 attached to a ks8695 SoC. During my efforts to=
 get
>> > > 2.6.33/34 running on my system I noticed sporadic problems with =
RTC:
>> >
>> > [...]
>> >
>> > > static struct i2c_pca9564_pf_platform_data =C2=A0__initdata pca_=
data =3D{
>> > > =C2=A0 =C2=A0 =C2=A0 .gpio =3D -1,
>> > > =C2=A0 =C2=A0 =C2=A0 .i2c_clock_speed =3D 59000,
>> > > =C2=A0 =C2=A0 =C2=A0 .timeout =3D 1,
>> > > };
>> >
>> > Commit 8e99ada8deaa9033600cd2c7d0a9366b0e99ab68 changed the timeou=
t settings to
>> > jiffies. So, one jiffy as timeout will not work. Try 'HZ' here.
>>
>> So this means the bug isn't in the mainline kernel tree and I can
>> ignore it?
>
> A confirmation from Yegor would be nice, but his logs let me believe =
that
> this is really the cause.
>
>> As a side note, arch/blackfin/mach-bf561/boards/acvilon.c sets timeo=
ut
>> to 10000, so the actual timeout depends on the value of HZ, which is
>> probably not desirable. Not to mention that a timeout of over one
>> minute (worst case) doesn't seem too smart ;)
>
> There is also an i2c-gpio-user using non-HZ value. Will prepare patch=
es.

Thank for your solution. I'll try it on Tuesday and confirm ASAP.

Happy Easter!

Best regards,
Yegor
