From: Liu Ying <liu.y.victor@gmail.com>
Subject: Re: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
Date: Wed, 23 Jan 2013 22:08:53 +0800
Message-ID: <CA+8Hj83n+pC+a6bYOOH1b61DTqSjpKsxyKDgDL2pCRKxTq4EXg@mail.gmail.com>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
	<CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
	<20130123125001.GG16264@pengutronix.de>
	<CA+8Hj80=Mk1gMSC9gcRT_XPFrEdRxifaB9FNMtkn3BkUkv9bGA@mail.gmail.com>
	<20130123134936.GH16264@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130123134936.GH16264@pengutronix.de>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liu Ying <Ying.Liu@freescale.com>, Arnd Bergmann <arnd@arndb.de>, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

2013/1/23 Wolfram Sang <w.sang@pengutronix.de>:
> Hi,
>
>> There are some difference between 24c512 and 24c512b about the system
>> reset procedure, according to the two devices' spec:
>> 24c512b:(a) Create a start bit condition, (b)clock 9 cycles, (c)
>> create another start bit followed by stop bit condition.
>> 24c512:(a) Clock up to 9 cycles, (b) look for SDA high in each cycle
>> while SCL is high and then, (c) create a start condition as SDA is
>> high.
>> Could this be a reason to add an entry for 24c512b?
>
> Since the entries in at24_ids[] are the same, no. If they would differ,
> that is a reason.

The names of the two entries are not the same, one is "24c512", the
other is "24c512b".
My original idea to add the new entry is to count on the name
difference to do different system reset operations.

>
>> Now, I think the correct vendor name should be "at" or "atmel".
>
> "atmel" would be better, but the MX28EVK doesn't even have an I2C eeprom
> by default IIRC? But that is unrelated to your patch.
The commit message of the patch which adds 24c32 support for MX28EVK
tells that "mx28evk has a free slot U50 that can be used to populate
an I2C EEPROM.".

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |



-- 
Best Regards,
Liu Ying
