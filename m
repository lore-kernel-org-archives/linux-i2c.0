From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: relax ban on I2C_M_RECV_LEN
Date: Tue, 21 Feb 2012 09:19:27 +0100
Message-ID: <20120221091927.46c0f972@endymion.delvare>
References: <4F2DA645.3080604@interlog.com>
	<20120220162939.5ce96d52@endymion.delvare>
	<4F43133F.5040906@interlog.com>
	<20120221083126.3bda01f3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120221083126.3bda01f3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 21 Feb 2012 08:31:26 +0100, Jean Delvare wrote:
> On Mon, 20 Feb 2012 22:45:03 -0500, Douglas Gilbert wrote:
> > My illegitimate use case is:
> > Sonmicro 13.56 MHz RFID Mifare Module:
> > http://www.sonmicro.com/en/downloads/Mifare/ds_SM130.pdf
> > http://www.sonmicro.com/en/downloads/Mifare/AN601.pdf
> > 
> > I can make it work by requesting the maximum number of bytes it
> > will ever respond with on all reads.
> 
> I have read these two documents quickly and I don't see any use case
> for I2C_M_RECV_LEN. The two block reads I see (5.6 READ BLOCK and 5.7
> READ VALUE BLOCK in ds_SM130.pdf) have predefined response lengths of
> 18 and 6 bytes respectively. Nowhere I see a read command that would
> reply a block length as the first byte.
> 
> Please point me to the page and section of these documents where you
> think I2C_M_RECV_LEN is needed.

Err, sorry, I see it now. Must have been blind this morning.

Unfortunately the length doesn't include the checksum byte, so in
practice you always read or write one more byte than the length byte
says. This wouldn't be an issue if the checksum was compatible with
SMBus PEC, as you would then be able to use the SMBus emulation layer,
but it is not. It's really a pity to be so close to SMBus yes be
incompatible with it. Shame on the manufacturer.

Still, everything isn't lost. Your largest command is 18 byte long,
this fits in the SMBus limit (32 bytes) so underlying bus drivers will
be happy, if you provide the buffer size they expect
(I2C_SMBUS_BLOCK_MAX + 2.) If you were using a kernel driver instead of
going through i2c-dev, I think it would work just fine without changing
anything to the existing code. You would just allocate a 34-byte buffer
and pass len = 2 and flags |= I2C_M_RECV_LEN, and everything would work
fine.

Which brings me to a question: why are you writing your driver in
user-space instead of kernel-space as everybody else is doing?

I am also curious which i2c bus driver your system is using?

For i2c-dev I have an idea but it's not exactly clean and I'm not sure
if it'll work. Unfortunately I have no device supporting I2C_M_RECV_LEN
at hand so testing is quite difficult.

-- 
Jean Delvare
