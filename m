From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C Combined Transactions in Linux
Date: Sun, 11 Sep 2011 14:59:05 +0200
Message-ID: <20110911145905.65659433@endymion.delvare>
References: <CAFfjFp1KAmr2w=0Nwt1FtvYSNb7CJ59AHJtXmnnpat-PdyvHzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFfjFp1KAmr2w=0Nwt1FtvYSNb7CJ59AHJtXmnnpat-PdyvHzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henri Kjellberg <henrikjellberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Henri,

On Sat, 10 Sep 2011 14:45:37 -0500, Henri Kjellberg wrote:
> Greetings Friends,
> I am looking for a way to perform combined transactions over I2C in
> Linux. The structure of the message I need to send is as follows. The
> slave responds in the brackets.
> 
> START
> Slave Address, Write
> [ACK]
> Data
> [ACK]
> Data
> [ACK]
> ...
> FEND

Without a [ACK] or [NACK] here, your transaction is not valid I2C. Is
it really not there, or did you omit to mention it?

> START

Plain Start cannot happen in the middle of a transaction. Did you mean
Repeated Start?

> Slave Address, Write
> [Data]
> ACK
> [Data]
> ACK
> ...
> [FEND]
> ACK
> STOP
> 
> Here, FEND is a special end of message byte defined in a manner
> similar to the SLIP encapsulation. It does not appear that I can use

I have no idea what "SLIP encapsulation" is. Can you just explain what
FEND is without external references? Is it simply a special byte value
which means the end of the message?

> the i2c_smbus_block_process_call because it requires the first data
> byte to be the message length. Is there any way to send these sorts of
> combined transaction in Linux without using the smbus interface?

The above doesn't look like any standard SMBus transaction, as you
found out, so there is no way to achieve it with i2c_smbus_*(). If it
can be done, that would be with i2c_transfer() (in the kernel) or
ioctl(I2C_RDWR) (from user-space).

But even that may not be doable with the current infrastructure, if
FEND can happen at any point of the transaction and thus the initial
length of the transaction is unknown.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
