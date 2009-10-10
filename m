From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Looking for ICH SMBUS "Process call" support in i2c-i801 bus
 driver
Date: Sat, 10 Oct 2009 09:09:51 +0200
Message-ID: <20091010090951.1fd0e1a0@hyperion.delvare>
References: <COL117-W70326CE4BD5366E7F94C688CC0@phx.gbl>
	<COL117-W52FEEADBC012C39EE0485188CB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <COL117-W52FEEADBC012C39EE0485188CB0-MsuGFMq8XAE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krishna Kothapalli <krishna_sunitha-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Krishna,

On Fri, 9 Oct 2009 19:54:11 -0400, Krishna Kothapalli wrote:
> 
>  <20091009083519.2659a79a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
> Content-Type: text/plain; charset="iso-8859-1"
> Content-Transfer-Encoding: quoted-printable
> MIME-Version: 1.0
> 
> 
> Hi Jean=2C

Your reply is badly formatted. Please check your e-mail client and/or
e-mail server.

> Thanks much for your response.=20
> 
> 1) Thanks for correcting: ADM1066 as you mentioned does not require process=
>  call.
> 
> 2) From eeprom AT24C64 sheets: It support  Sequential Random Read. After th=
> e micro controller receives a data word=2C it responds with an acknowledge.=
>  As long as the EEPROM receives an acknowledge=2C it will continue to incre=
> ment the data word address and serially clock out sequential data words... =
> The sequential read operation is terminated when the micro controller does =
> not respond with a zero but does generate a following stop condition".
> 
> The above seems to map to SMBUS Process Call Cycle with I2C_EN=3D1b.

Not really. What the ICH SMBus can do (using the SMBus process call
with the I2C_EN bit set) is write a two-byte address and read exactly
two bytes back. For the AT24C64, this corresponds to a sequential
random read of size exactly 2 bytes. While I admit it would be possible
to read from the AT24C64 using this transaction, it would perform
rather badly: 6 bytes on the wire for 2 bytes of data read. Given how
large the AT24C64 is, I doubt you will enjoy it, especially with the
poll-based implementation of i2c-i801: you would need over 8 seconds to
read the full EEPROM.

Additionally, implementing it would be technically difficult. What the
ICH implements doesn't match any standard SMBus transaction, and I
don't know of any other SMBus controller implementing this. I don't
think we want to define a new functionality bit and helper function for
a non-standard transaction type only implemented by one controller.
Alternatively, we could let i2c-i801 claim that it supports raw I2C
transactions, and only accept this exact type of transaction. But this
would then require dedicated support in the at24 driver. That's not
particularly appealing either.

As a matter of fact, the at24 driver only accept EEPROM types up to
24C16 on SMBus controllers. For 24C32 and larger, it requires full I2C
support. Connecting an AT24C64 to an Intel ICH SMBus controller is
simply bad engineering. You'd rather use one or more AT24C16 instead,
so you can use standard SMBus transactions and (one address byte) I2C
block reads.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
