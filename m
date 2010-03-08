From: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Mon, 08 Mar 2010 12:43:47 +0800
Message-ID: <4B948083.6000703@windriver.com>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>	<20100305071130.GB21925@pengutronix.de>	<4B90B341.9000601@windriver.com>	<20100305074155.GD21925@pengutronix.de>	<4B90B888.6060005@windriver.com>	<20100305095040.6ab4612c@hyperion.delvare>	<4B90D85E.6040308@gmx.de>	<4B90DF48.50005@windriver.com>	<20100305115213.4b504710@hyperion.delvare>	<4B90E83A.5020106@gmx.de> <20100305124200.6f6eccfc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100305124200.6f6eccfc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare =E5=86=99=E9=81=93:
> Hi Michael,
>
> On Fri, 05 Mar 2010 12:17:14 +0100, Michael Lawnick wrote:
>  =20
>> Jean Delvare said the following:
>>    =20
>>> Well, what EEPROM type do you have exactly? 24c64 is for 64 kbit (8
>>> kByte) EEPROMs using 16-bit addressing. You must use the correct ty=
pe,
>>> otherwise the at24 driver will misbehave. I am a little surprised
>>> because originally you went for "eeprom" which is not compatible wi=
th
>>> "24c64" (8-bit vs. 16-bit addressing).
>>>      =20
>> Furthermore this brings up another issue:
>> 0x50 typically is SPD-eeprom (DDR initialisation). Corrupting the
>> contents might make your board unbootable - and using a 16bit driver
>> instead of an 8-bit one can corrupt your contents already on
>> (positioned) reading!
>>    =20
>
> This is totally correct, but better said loud to the list and the
> original poster than only privately to me ;)
>  =20

Thanks a lot to point out this.

I double checked the manual, the eeprom is SPD of the DIMMs.

I will rework my patch, then send V2 soon.

Regards,
Yang
