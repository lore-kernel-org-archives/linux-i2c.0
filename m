From: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Rework the PIO mode operation
Date: Thu, 18 Jul 2013 21:12:15 +0200
Message-ID: <3767128.gOKkIqK4p5@linux-1fbo.site>
References: <201307150405.53110.marex@denx.de> <1UzQet-1Vf4pE0@fwd17.aul.t-online.de> <201307171904.00784.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307171904.00784.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Marek,

> 
> Thinking about this, did you correctly configure the EEPROM write sector
> size? I think it's 32 bytes for this device.
> 

The EEPROM is correctly configured, i.e. page size is set to 32.

I made a test by writing one byte (0x01) to the address 0x0100 of the EEPROM. 
The EEPROM's I2C bus address is 0x54.
The test has only one transfer with a message length of 3 bytes.

I figured out that the value written to the MXS_I2C_DATA register should be 
0x010001a8. But instead of that a value of 0x00000000 is written to the 
register.

I think that the reason for that can be found in the following code section:

if (i + 1 == msg->len) {
	/* This is the last transfer. */
	start |= flags;
	start &= ~MXS_I2C_CTRL0_RETAIN_CLOCK;
	xlen = (i + 2) % 4;
	data >>= (4 - xlen) * 8;
} else if ((i & 3) == 2) {
	/* Regular transfer. */
	xlen = 4;
} else {
	/* Just stuff data. */
	continue;
}

After the last byte is stuffed into the variable data (i = 2) xlen is 
calculated (with xlen = (i + 2) % 4) to zero. Thus the following shift 
operation (data >>= (4 - xlen) * 8) shifts all the bits out of data that 
already contains 0x010001a8.


Best regards
Torsten Fleischer
