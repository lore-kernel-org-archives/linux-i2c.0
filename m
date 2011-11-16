From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Wed, 16 Nov 2011 19:09:54 +0100
Message-ID: <20111116190954.67c846fc@endymion.delvare>
References: <1321338462-6138-1-git-send-email-guenter.roeck@ericsson.com>
	<CAOZdJXUPO5PyMkAw-2EPvy_qSUuqsgUA7Gr8mKUX7HyShoXk3g@mail.gmail.com>
	<E6AF40B3BFC8A9428EACB47497F0F4B62DC687@039-SN1MPN1-002.039d.mgd.msft.net>
	<ECEE0D23-8F53-402C-A97F-4DB0F0E9C79B@freescale.com>
	<1321464509.7847.41.camel@oslab-l1>
	<1321464968.2309.384.camel@groeck-laptop>
	<1321466135.7847.55.camel@oslab-l1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321466135.7847.55.camel@oslab-l1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 16 Nov 2011 09:55:35 -0800, York Sun wrote:
> On Wed, 2011-11-16 at 09:36 -0800, Guenter Roeck wrote:
> > York,
> > 
> > The calling code expects the data length in data[0], and the actual data
> > in data[1] .. data[<byte_count>]. The initial value for length is 1; the
> > byte count is added to it, so <byte count + 1> bytes are placed into the
> > buffer.
> > 
> > Thanks,
> > Guenter
> 
> Thanks for explanation. I am more confused by the length += byte now.
> For I2C bus, if you need length of byte, just keep reading until you get
> all of them. Of course you need to deal with the ACK. For SMBus, it is
> similar but you shouldn't read more after the byte count which is in the
> first data.

You shouldn't read less either. The slave tells how much bytes it wants
to send, and the master must honor that.

> If you want to read length of data but the block size is
> bigger than length, you should call block read at first place. If the
> block size is smaller than length, why increase the length? Does your
> SMBus controller only support fixed block size and not support single
> byte read? If it does, I would do
> 
> Block, Block, Block, byte, byte... until length of data

Your thinking is too focused on I2C block reads (or even block read of
data over the network or on disk). SMBus block read is something
completely different. It's not about reading 200 bytes of data and
receiving it in 16-byte chunks (I2C block read works that way, on
EEPROMs in particular.) There is no "data length" and "block size" to
compare to each other. It's about reading the value of _one_ register
and this value happens to be multi-byte. There is typically _no_
register pointer increment (automatic or not) involved as can happen
with EEPROMs. If an SMBus block read from register N returns 10 bytes,
you're not going to read the next 10 bytes from register N+10. There
are no "next 10 bytes" to read, and register N+10 is something
completely unrelated.

And for this reason, it is not possible to mix SMBus block reads with
byte reads, as can be done with I2C block reads.

Also note that there is a limit of 32 bytes for SMBus block transfers,
per SMBus specification. All slaves and masters must comply with it.

I hope I managed to clarify the case this time...

-- 
Jean Delvare
