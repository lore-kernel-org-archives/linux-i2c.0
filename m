From: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri, 05 Mar 2010 15:31:13 +0800
Message-ID: <4B90B341.9000601@windriver.com>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com> <20100305071130.GB21925@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100305071130.GB21925-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang =D0=B4=B5=C0:
>> +	{
>> +		I2C_BOARD_INFO("eeprom", 0x50),
>> +	},
>>    =20
>
> Is the use of 'eeprom' instead of 'at24' intentional?
>  =20

Unfortunately, at24 driver can't work on this board, I must use legacy
eeprom.

My config:

#CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=3Dy

Regards,
Yang

> Regards
>
>  =20
