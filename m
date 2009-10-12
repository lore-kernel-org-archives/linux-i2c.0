From: Krishna Sunitha <krishna.sunitha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Looking for ICH SMBUS "Process call" support in i2c-i801 bus
	driver >
Date: Sun, 11 Oct 2009 18:28:49 -0700
Message-ID: <26610a5d0910111828j3933e87fhd1762c8160fc791d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> Not really. What the ICH SMBus can do (using the SMBus process call
> with the I2C_EN bit set) is write a two-byte address and read exactly
> two bytes back. For the AT24C64, this corresponds to a sequential
> random read of size exactly 2 bytes. While I admit it would be possible
> to read from the AT24C64 using this transaction, it would perform
> rather badly: 6 bytes on the wire for 2 bytes of data read. Given how
> large the AT24C64 is, I doubt you will enjoy it, especially with the
> poll-based implementation of i2c-i801: you would need over 8 seconds to
> read the full EEPROM.
>
> Additionally, implementing it would be technically difficult. What the
> ICH implements doesn't match any standard SMBus transaction, and I
> don't know of any other SMBus controller implementing this. I don't
> think we want to define a new functionality bit and helper function for
> a non-standard transaction type only implemented by one controller.
> Alternatively, we could let i2c-i801 claim that it supports raw I2C
> transactions, and only accept this exact type of transaction. But this
> would then require dedicated support in the at24 driver. That's not
> particularly appealing either.
>
> As a matter of fact, the at24 driver only accept EEPROM types up to
> 24C16 on SMBus controllers. For 24C32 and larger, it requires full I2C
> support. Connecting an AT24C64 to an Intel ICH SMBus controller is
> simply bad engineering. You'd rather use one or more AT24C16 instead,
> so you can use standard SMBus transactions and (one address byte) I2C
> block reads.

Thanks much for great input. Let me talk to HW team to see if AT24C16
would be good enough.

Thanks,
Krishna
