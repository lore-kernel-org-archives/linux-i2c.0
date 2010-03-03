From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Wed, 3 Mar 2010 17:59:46 +0100
Message-ID: <20100303175946.1ea5387e@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128085904.4e202de1@hyperion.delvare>
	<af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	<20100128105340.41aecf64@hyperion.delvare>
	<af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	<20100219105841.2bd8b16c@hyperion.delvare>
	<af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	<20100222225805.00432574@hyperion.delvare>
	<af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	<af0693f01002240401g1aeaf840ld06a156a06be9dbf@mail.gmail.com>
	<20100302222203.1eb67c3a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100302222203.1eb67c3a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi again Felix,

On Tue, 2 Mar 2010 22:22:03 +0100, Jean Delvare wrote:
> Obviously, if disabling the block buffer makes the same transaction
> work, then it has to be a bug in the driver. And the good news is: I
> was able to reproduce the bug using your test program, on an ICH5
> running kernel 2.6.27.45. On the same system, I can get SMBus block
> reads to work with or without the block buffer, so block buffer support
> is not entirely broken (if it was, we'd certainly have noticed earlier.)
> 
> Now ideally we need to figure out whether SMBus block writes are
> affected as well. We already know that SMBus block reads are not, and
> I2C block writes are. As I2C block reads are excluded (the block buffer
> can not be used for them according to the datasheet, and the driver
> already does the right thing), checking whether SMBus block writes are
> affected will tell us whether all block writes are affected, or if I2C
> block writes only are affected. This should help us find out where and
> what the bug could be.

Further testing today shows that SMBus block writes work just fine with
the block buffer feature enabled. So, the only problem is with I2C
block writes. My last attempt locked the SMBus, but I was able to
recover by repeatedly writing to the HST_STS register, as may times as
the block length. That is, the device operates in byte-by-byte mode
regardless of the block buffer mode being set. This leads me to the
conclusion that the E32B flag is ignored for I2C block write
transactions, exactly as it is for I2C block read transactions in my
experience.

Digging up a mailing list post dating to when I added support for I2C
block read support [1], I found the following statement of mine which is
certainly relevant:

"Note that I could not get the I2C block read to work with the block
buffer enabled, so for now it is implemented with the block buffer
disabled, which means that the performance isn't that good. I couldn't
find anything in the ICH datasheets suggesting that the two features
are mutually exclusive, so maybe I did something wrong, or maybe the
hardware really can't do it and it should be documented."

This was about I2C block reads, not writes, but given that the
datasheet doesn't mention anything about a possible incompatibility
between I2C block transactions and the use of the block buffer anyway,
what seems to apply to I2C block reads in practice might reasonably
apply to I2C block writes as well. So, at this point, I am inclined to
simply disable the block buffer for I2C block writes as we already do
for I2C block reads. This should be a rather simple fix, I'll post a
patch later today or tomorrow.

That being said, I can't exclude that I missed something and block
buffer support could work with I2C block transactions with some more
work, maybe using a trick not mentioned in the datasheet. If someone
can get it to work, I would be very grateful, as the block buffer is a
great feature.

While working on this issue, I noticed that the piece of code which is
supposed to let the i2c-i801 driver recover in case of a transaction
timeout, did not always work. I will try to improve it to correctly
handle the bug you reported, before we fix that bug. Hopefully it will
help recovery from other cases as well in the future.

[1] http://marc.info/?l=linux-i2c&m=119780045620870&w=2

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
