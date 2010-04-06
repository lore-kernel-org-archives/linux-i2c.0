From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Tue, 6 Apr 2010 10:04:40 +0200
Message-ID: <m2kf69abfc31004060104p74973e6dod90faa1332db6740@mail.gmail.com>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
	 <20100403162939.GA2190@pengutronix.de>
	 <20100403202329.3bdb407c@hyperion.delvare>
	 <20100404032929.GA12800@pengutronix.de>
	 <t2zf69abfc31004040400wc3330285pe5d4602d31e0a52b@mail.gmail.com>
	 <j2pf69abfc31004060048z1b9500e1g9e12fb5bd794dc4a@mail.gmail.com>
	 <20100406075208.GA5102@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100406075208.GA5102-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>> >>> > > I'm using PCA9564 attached to a ks8695 SoC. During my effort=
s to get
>> >>> > > 2.6.33/34 running on my system I noticed sporadic problems w=
ith RTC:
>> >>> >
>> >>> > [...]
>> >>> >
>> >>> > > static struct i2c_pca9564_pf_platform_data =C2=A0__initdata =
pca_data =3D{
>> >>> > > =C2=A0 =C2=A0 =C2=A0 .gpio =3D -1,
>> >>> > > =C2=A0 =C2=A0 =C2=A0 .i2c_clock_speed =3D 59000,
>> >>> > > =C2=A0 =C2=A0 =C2=A0 .timeout =3D 1,
>> >>> > > };
>> >>> >
>> >>> > Commit 8e99ada8deaa9033600cd2c7d0a9366b0e99ab68 changed the ti=
meout settings to
>> >>> > jiffies. So, one jiffy as timeout will not work. Try 'HZ' here=
=2E
>> >>>
>> >>> So this means the bug isn't in the mainline kernel tree and I ca=
n
>> >>> ignore it?
>> >>
>> >> A confirmation from Yegor would be nice, but his logs let me beli=
eve that
>> >> this is really the cause.
>> >>
>> >>> As a side note, arch/blackfin/mach-bf561/boards/acvilon.c sets t=
imeout
>> >>> to 10000, so the actual timeout depends on the value of HZ, whic=
h is
>> >>> probably not desirable. Not to mention that a timeout of over on=
e
>> >>> minute (worst case) doesn't seem too smart ;)
>> >>
>> >> There is also an i2c-gpio-user using non-HZ value. Will prepare p=
atches.
>> >
>> > Thank for your solution. I'll try it on Tuesday and confirm ASAP.
>>
>> Wolfram, do you mean so:
>>
>> static struct i2c_pca9564_pf_platform_data =C2=A0__initdata pca_data=
 =3D{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio =3D -1,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.i2c_clock_speed =3D 59000,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.timeout =3D HZ,
>> };
>>
>> I've tried this, but with the same result. The bus is still not idle=
=2E
>
> That's bad news :(( Did you notice a difference in behaviour? There s=
hould be a
> 1 second delay now before the message arises...

Yes, I can confirm this delay. But apart from these delay I can't see
any difference in behavior.

Regards,
Yegor
