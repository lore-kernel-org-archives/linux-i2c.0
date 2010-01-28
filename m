From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Thu, 28 Jan 2010 10:53:40 +0100
Message-ID: <20100128105340.41aecf64@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128085904.4e202de1@hyperion.delvare>
	<af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01001280132l4002af0fgf3137fa27ce8555e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Thu, 28 Jan 2010 11:32:28 +0200, Felix Rubinstein wrote:
> Please explain to me how do you interpret "I2C Block Write"?
> To my understanding it's I2C, not SMBus, transaction on the bus,
> meaning (from Documentation/i2c/i2c-protocol)
> S Addr Wr [A] Data [A] Data [A] ... [A] Data [A] P

No, the above isn't what people commonly call "I2C block write". What
people commonly call "I2C block write", and which would probably be
more appropriately called "1-byte addressing I2C block write" is (as
documented in Documentation/i2c/i2c-protocol):

S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P

That being said, please note that the difference is only theoretical:
nothing differentiates command bytes from data bytes on the wire.

> on the other hand SMBus transaction looks like this:
> S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] P
> 
> The diff is obvious, no Count (not to say Comm) bytes in I2C
> transaction (well, it's clear, ICH9 is SMBus, not I2C bus). But what
> does "I2C Block Write" then means?

See "I2C block write" as functionally equivalent to "SMBus block write"
but for non-SMBus devices such as I2C EEPROMs. The goal is the same
(write a series of bytes to the device at a given sub-address) but the
on-the-wire format is different (size goes on the wire for SMBus, not
for I2C.)

While "I2C block write" isn't part of the SMBus specification, we have
implemented it in a similar way, simply because many SMBus controllers
implement that transaction type.

> > I have no idea what you mean with "I2C's multi-block". Please be
> > specific.
>
> S Addr Wr [A] Data [A] Data [A] ... [A] Data [A] P

OK, that's a straight I2C write of arbitrary length.

> Does  i2c-i801.c  support the following kind of transactions?
> S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
> (note, no count byte on the bus, taken from Documentation/i2c/smbus-protocol)

Yes, it does. Use i2c_smbus_write_i2c_block_data(). And if you don't
need the command byte, you can abuse it by passing the first data byte
as the command.

> looking at i801_block_transaction_by_block:
> 
>         if (read_write == I2C_SMBUS_WRITE) {
>                 len = data->block[0];
>                 outb_p(len, SMBHSTDAT0);
>                 for (i = 0; i < len; i++)
>                         outb_p(data->block[i+1], SMBBLKDAT);
>         }
> 
> Meaning len is put on the bus.

No, the above piece of code doesn't imply this. The length is written
to one register of the SMBus controller. It doesn't imply in any way
that the controller will push that value on the wire. In the case of
I2C block transactions, it does not.

BTW, the ICH9 datasheet is public, so you can easily check what exactly
the controller does for each transaction type.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
