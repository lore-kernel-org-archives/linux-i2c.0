From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Tue, 19 Jan 2010 07:10:19 -0800
Message-ID: <6cb013311001190710q186405c7m1193af79e18a09e3@mail.gmail.com>
References: <6cb013311001060647s3bce5e63mbae1a10036a14ae1@mail.gmail.com>
	<1263056154-20085-1-git-send-email-darkstar6262@gmail.com>
	<20100118124855.GB8036@sortiz.org> <20100118153624.GA13811@sortiz.org>
	<6cb013311001181323q79aba15dif165ff41d79734a7@mail.gmail.com>
	<20100119110916.GB554@sortiz.org> <20100119124812.345fe447@hyperion.delvare>
	<20100119120947.GD554@sortiz.org> <20100119131402.7e465fdb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100119131402.7e465fdb-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 19, 2010 at 4:14 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Tue, 19 Jan 2010 13:09:48 +0100, Samuel Ortiz wrote:
>> Hi Jean,
>>
>> On Tue, Jan 19, 2010 at 12:48:12PM +0100, Jean Delvare wrote:
>> > Hi Samuel,
>> >
>> > On Tue, 19 Jan 2010 12:09:17 +0100, Samuel Ortiz wrote:
>> > > 2) Kconfig: we need to depend on I2C=3Dy, to avoid the problemat=
ic case of
>> > > having I2C_CORE=3Dm and HTC_I2CPLD=3Dy
>> >
>> > ??
>> >
>> > There is no config option named I2C_CORE. The main option for I2C =
is,
>> > well, I2C,
>> Sorry, I meant I2C, not I2C_CORE.
>>
>>
>> > and if you depend on I2C, then you can't be built into the
>> > kernel if I2C is built as a module.
>> I have:
>>
>> drivers/mfd/Kconfig:
>> config HTC_I2CPLD
>> =C2=A0 =C2=A0 =C2=A0 bool "HTC I2C PLD chip support"
>> =C2=A0 =C2=A0 =C2=A0 depends on I2C
>>
>> Then make menuconfig allows me to build a .config with
>>
>> CONFIG_I2C=3Dm and CONFIG_HTC_I2CPLD=3Dy
>>
>> and that obviously fails to build. If I'm a bool depending on I2C, i=
t has to
>> be a built-in I2C.
>
> Ah, my bad, I totally missed that HTC_I2CPLD was a bool. Please just
> ignore me, sorry for the noise. You are correct, it should depend on
> I2C=3Dy.
>

All these changes sound fine to me, thanks for doing that!  Sorry for
the compile mess, I'll keep all this in mind for later work.

- Cory
