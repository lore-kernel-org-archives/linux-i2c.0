From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Fri, 6 Apr 2012 18:25:34 +0200
Message-ID: <20120406182534.68d7f53d@endymion.delvare>
References: <20120315180835.2e669111@endymion.delvare>
	<20120331081927.2438ea9e@endymion.delvare>
	<4F7CD11C.2090801@interlog.com>
	<20120405092422.453edecf@endymion.delvare>
	<4F7E3267.9040306@interlog.com>
	<20120406083751.46fd23c5@endymion.delvare>
	<4F7F16D3.6080307@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F7F16D3.6080307-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 06 Apr 2012 12:16:19 -0400, Douglas Gilbert wrote:
> Yes again, the modified i2c-at91.c driver that I am using does not
> have support for I2C_M_RECV_LEN.

Did you try my patch?

> However stepping back from the minor I2C_M_RECV_LEN issue and looking
> directly at the i2c-at91 driver itself. My patch to this broken
> driver is included below and applies clean against lk 3.2.8
> (but I note that it needs work to apply against lk 3.3). My patch
> works for the AT91SAM9G20 and I have positive feedback from
> the users of board-foxg20 based on that MCU.

I picked this patch from your website already, and forward ported it,
my own patch was on top of yours.

> However I see that Nikolaus Voss has submitted a replacement driver
> for the i2c-at91 that works for the G45 which has two TWI units.
> Is that driver going into the mainline? Surely it is much better
> than the broken i2c-at91 driver that has been sitting broken for
> way too long. Atmel are bringing out new MCUs in that family which
> have 3 TWI units (e.g. AT91SAM9G25). Apart from the limitations
> about repeated starts surely Atmel have fixed the problems referred
> to in existing mainline i2c-at91.c driver from circa 2006.
> 
> My vote would be to add Nikolaus Voss's driver ASAP.

I'm not into embedded devices, so this isn't my call.

-- 
Jean Delvare
