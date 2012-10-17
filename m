From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2cset question
Date: Wed, 17 Oct 2012 14:43:03 +0200
Message-ID: <20121017144303.43612bc4@endymion.delvare>
References: <49E89342.1010807@gmail.com>
	<20090417174845.471d4d9d@hyperion.delvare>
	<loom.20121017T134619-899@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20121017T134619-899-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javi <occam25-mRCrAkd8dF0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Javi,

On Wed, 17 Oct 2012 12:07:40 +0000 (UTC), Javi wrote:
> I have the same problem than Chris.

Actually I suspect this is a different problem.

> I am working with an ALIX motherboard with 
> voyage linux distribution and I have connected a 24LC64 eeprom. When I try to 
> write the epprom with i2cset command it doesn't work.

Because the 24LC64 uses a two-byte addressing model, while SMBus uses a
one-byte addressing model. This means you can't use this type of EEPROM
with an SMBus controller [1]. You need a full-featured I2C controller.
You may be able to achieve that on your system by using the scx200_i2c
driver instead of scx200_acb driver, or by using an extra pair of GPIO
pins with i2c-gpio.

If this isn't an option for you then you'll have to use a different
EEPROM model. AFAIK the 24C16 is the largest one using single-byte
addressing (it uses all 8 I2C addresses 0x50-0x57, and 256 * 8 * 8 =
16K.)

Note that you can't use i2cdump, i2cget and i2cset with 2-byte
addressed EEPROMs. You'll have to try the dedicated tools under
eepromer in the i2c-tools package [2]. For 2-byte addressed EEPROMs you
want either eeprog or eepromer. I seem to recall eeprog implements the
tricks described below for 2-byte addressed EEPROMs over SMBus.

[1] Actually you can write to such an EEPROM by abusing SMBus write
    transactions. All you have to do is pass the second address byte as
    the first data byte of either an SMBus write word transaction or,
    if your SMBus controller supports it, an I2C block write
    transaction. Then shift all data bytes by one position. For reads,
    you could use an SMBus write byte transaction to set the address
    and then SMBus receive byte transactions in a loop to retrieve the
    data bytes one by one. However this is racy and slow.

[2] Note that the primary hosting site for i2c-tools is currently down,
    you can use my mirror if needed:
    http://khali.linux-fr.org/mirror/i2c-tools/

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
