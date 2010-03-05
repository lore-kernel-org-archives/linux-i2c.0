From: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri, 05 Mar 2010 18:39:04 +0800
Message-ID: <4B90DF48.50005@windriver.com>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>	<20100305071130.GB21925@pengutronix.de>	<4B90B341.9000601@windriver.com>	<20100305074155.GD21925@pengutronix.de>	<4B90B888.6060005@windriver.com> <20100305095040.6ab4612c@hyperion.delvare> <4B90D85E.6040308@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B90D85E.6040308-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi guys,

Thanks for you guys kind advice. I think I find the cause. I coded a=20
wrong eeprom type, "at24" can't work here, it should be "24c64". It=20
works with AT24 eeprom driver, but I'm not sure if this is the right ty=
pe.

So, a possible correct to the patch is that:

+{
+    I2C_BOARD_INFO("24c64",=C2=B70x50),
+},

Regards,
Yang

Michael Lawnick =E5=86=99=E9=81=93:
> Jean Delvare said the following:
>  =20
>> Hi Yang, Wolfram,
>>
>> On Fri, 05 Mar 2010 15:53:44 +0800, Yang Shi wrote:
>>    =20
>>> Wolfram Sang =E5=86=99=E9=81=93:
>>>      =20
>>>>>> Is the use of 'eeprom' instead of 'at24' intentional?
>>>>>>  =20
>>>>>>      =20
>>>>>>            =20
>>>>> Unfortunately, at24 driver can't work on this board, I must use l=
egacy
>>>>> eeprom.
>>>>>    =20
>>>>>          =20
>>>> Well, you are of course free to choose here :)
>>>>
>>>> I'd just be interested if there is a software limitation which pre=
vents you from
>>>> using AT24. Because, it _should_ work with all kind of eeproms the=
 legacy driver
>>>> deals with. Otherwise it is probably a bug which needs to be fixed=
=2E
>>>>  =20
>>>>        =20
>>> Thanks to point out this. Let me take a look at this.
>>>      =20
>> One limitation of the at24 driver is that it needs the underlying
>> controller to support either raw I2C access or at least I2C block
>> transactions. Konstantin Lazarev complained about that one month ago
>> already.
>>
>> I am currently working on improving the at24 driver so that it falls
>> back to byte transactions when block transactions are not available.=
 I
>> might also add word transaction support (as the eeprom driver has) a=
s
>> it is often the best performance/compatibility trade-off. I'll post =
the
>> patch when I'm done.
>>
>> I'm not yet sure what will happen to the legacy eeprom driver in the
>> long run, but I would prefer new designs to not rely on it.
>>
>>    =20
>
> If I don't get all wrong, my 2 Cents:
> i2c-octeon will/should be based on raw i2c from kernel version .34 on=
=2E
> (my patch :-) ) So it should support all transfer modes that i2c can.
> Currently it is limited to 8 bytes per transaction.
>
> If I misunderstood something, please ignore the noise.
>
>  =20
