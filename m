From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri, 05 Mar 2010 13:15:24 +0100
Message-ID: <4B90F5DC.90600@gmx.de>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>	<20100305071130.GB21925@pengutronix.de>	<4B90B341.9000601@windriver.com>	<20100305074155.GD21925@pengutronix.de>	<4B90B888.6060005@windriver.com>	<20100305095040.6ab4612c@hyperion.delvare>	<4B90D85E.6040308@gmx.de>	<4B90DF48.50005@windriver.com>	<20100305115213.4b504710@hyperion.delvare>	<4B90E83A.5020106@gmx.de> <20100305124200.6f6eccfc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100305124200.6f6eccfc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> Hi Michael,
> 
> On Fri, 05 Mar 2010 12:17:14 +0100, Michael Lawnick wrote:
>> Jean Delvare said the following:
>> > Well, what EEPROM type do you have exactly? 24c64 is for 64 kbit (8
>> > kByte) EEPROMs using 16-bit addressing. You must use the correct type,
>> > otherwise the at24 driver will misbehave. I am a little surprised
>> > because originally you went for "eeprom" which is not compatible with
>> > "24c64" (8-bit vs. 16-bit addressing).
>>
>> Furthermore this brings up another issue:
>> 0x50 typically is SPD-eeprom (DDR initialisation). Corrupting the
>> contents might make your board unbootable - and using a 16bit driver
>> instead of an 8-bit one can corrupt your contents already on
>> (positioned) reading!
> 
> This is totally correct, but better said loud to the list and the
> original poster than only privately to me ;)
> 
sh.., :-(
