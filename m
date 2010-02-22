From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Mon, 22 Feb 2010 22:58:05 +0100
Message-ID: <20100222225805.00432574@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128085904.4e202de1@hyperion.delvare>
	<af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	<20100128105340.41aecf64@hyperion.delvare>
	<af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	<20100219105841.2bd8b16c@hyperion.delvare>
	<af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01002220812n5a6060cejc00d1ebbd7b9424d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Mon, 22 Feb 2010 18:12:41 +0200, Felix Rubinstein wrote:
> Hi Jean/i2c guys,
> 
> I'm having hard time to send straight I2C transaction of arbitrary length.
> I use i2c_smbus_write_i2c_block_data(fd, buf[0], datac - 1, &buf[1]);
> from user-space to send the aforementioned transaction, but I get
> operation not permitted as a result.
> I tried to understand what's going on in the driver and found out that
> timeout occurs.

Unlikely. If a timeout occurred, the error message would say so.

What is the exact error message? Can we see your complete code?

Don't forget that you must be root to use i2c-dev.

> As a consequence, I'd like to get something clear to me:
> Since ICH9 supports 32-Byte Buffer (E32B) and according to the data
> sheet the DS bit of the HST_STS is meaningless when E32B is enabled
> and it's (E32B) enabled by the i801 driver.
> On the other hand, in i801_check_pre called (from
> i801_block_transaction_by_block) the macro STATUS_FLAGS verifies the
> DS bit (designated as SMBHSTSTS_BYTE_DONE in the code).
> Looking at the previous version of the driver, like in 2.5.25 there
> was a mask 0x1f but it has gone since.
> Is this behavior correct?

The change happened in this patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=cf898dc5e9dfd1487b28ca0176b68722f05d4d48

The new behavior is believed to be correct. I agree that
SMBHSTSTS_BYTE_DONE doesn't matter for block transactions, but checking
this bit can't hurt.

> And another question related. Have you/anyone tried to output I2C
> write transaction of arbitrary length, i.e. DATA0 is not sent on the
> bus, from ICH9?

I don't have any device on my ICH SMBus to which I can issue an I2C
block write, sorry. I did test block reads though, and successfully.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
