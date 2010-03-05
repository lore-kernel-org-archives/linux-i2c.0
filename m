From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri, 5 Mar 2010 11:52:13 +0100
Message-ID: <20100305115213.4b504710@hyperion.delvare>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>
	<20100305071130.GB21925@pengutronix.de>
	<4B90B341.9000601@windriver.com>
	<20100305074155.GD21925@pengutronix.de>
	<4B90B888.6060005@windriver.com>
	<20100305095040.6ab4612c@hyperion.delvare>
	<4B90D85E.6040308@gmx.de>
	<4B90DF48.50005@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B90DF48.50005-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 05 Mar 2010 18:39:04 +0800, Yang Shi wrote:
> Hi guys,
>=20
> Thanks for you guys kind advice. I think I find the cause. I coded a=20
> wrong eeprom type, "at24" can't work here, it should be "24c64". It=20
> works with AT24 eeprom driver, but I'm not sure if this is the right =
type.

Actually, "at24" can work but you have to provide extra parameters
detailing the size, page size etc. of the EEPROM. All the "24cXX" names
are shortcuts with predefined sizes.

>=20
> So, a possible correct to the patch is that:
>=20
> +{
> +    I2C_BOARD_INFO("24c64",=C2=B70x50),
> +},

Well, what EEPROM type do you have exactly? 24c64 is for 64 kbit (8
kByte) EEPROMs using 16-bit addressing. You must use the correct type,
otherwise the at24 driver will misbehave. I am a little surprised
because originally you went for "eeprom" which is not compatible with
"24c64" (8-bit vs. 16-bit addressing).

Also note that you may want to provide specific page size if you have
tight control over what hardware is used and you intend to write to the
EEPROM on a regular basis. The driver defaults to safe but slow
settings.

OTOH, if you do _not_ want to write to the EEPROM, you want to provide
the AT24_FLAG_READONLY flag.

--=20
Jean Delvare
