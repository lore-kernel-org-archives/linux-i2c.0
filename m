From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Fri, 12 Mar 2010 14:19:01 +0100
Message-ID: <20100312141901.04299a55@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128105340.41aecf64@hyperion.delvare>
	<af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	<20100219105841.2bd8b16c@hyperion.delvare>
	<af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	<20100222225805.00432574@hyperion.delvare>
	<af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	<20100228120817.275ef279@hyperion.delvare>
	<af0693f01002280545n622b1c41v1f8c104e57fb51b6@mail.gmail.com>
	<20100228211949.3297a0ff@hyperion.delvare>
	<af0693f01003020453m7ca6891bjca4833c7fa45f44d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01003020453m7ca6891bjca4833c7fa45f44d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Tue, 2 Mar 2010 14:53:41 +0200, Felix Rubinstein wrote:
> One more thing which popped up recently.
> If I work with E32B disabled, I paid attention that msleep(1) in
> i801_block_transaction_byte_by_byte makes the write transaction too
> long in the scope, i.e. bytes frequency is too long and they are too
> far apart which makes them harder to be read. I think they should be
> closer together, like this one.
> 
>                 /* We will always wait for a fraction of a second! */
>                 timeout = 0;
>                 do {
> -                       msleep(1);
> +                      udelay(100);
>                         status = inb_p(SMBHSTSTS);
>                 }
>                 while ((!(status & SMBHSTSTS_BYTE_DONE))
>                           && (timeout++ < MAX_TIMEOUT));
> 
> or something like this.Even if it will timeout for a few times,
> MAX_TIMEOUT will take care of the rest. In my case it hasn't even
> once. All this, of course, not just for scope :)

This is an interesting point. During simple transactions, or block
transactions under E32B, we don't really care about the delay, because
the controller takes care of the transaction on its own, and the only
thing the delay affects is how long the user waits for the answer. For
block transactions without E32B, it's different because the bus is
really waiting for us to trigger the sending or receiving of the next
data byte, so if we wait too long, we keep the bus busy for a long
time, which is bad both for multi-master buses, and when talking to a
slave which stops data processing while an I2C transaction is in
progress. I presume that some masters or slaves would even consider
that a transaction is stuck if it waits too long without sending
data. The SMBus specification defines the hardware timeout as 25 ms.

The SMBus specification defines Tlow:mext as the maximum delay between
data bytes on the wire, with value 10 ms. While msleep(1) at HZ=1000
should be fine in this respect (it will sleep 2 ms max), and even at
HS=250 (it will sleep 8 ms max), it is not OK at HZ=100, as msleep(1)
may sleep up to 20 ms. Fortunately this is still below the hardware
timeout of 25 ms. msleep(0) may be better, but I'm not sure if it is
semantically acceptable (only one driver is using it so far). So maybe
we should indeed not sleep at this point. That being said, your naive
patch is hardly acceptable as is, as it may lead us to busy-wait for
100 * 100 us = 10 ms. It also shortens the timeout from 200 ms (at
HZ=1000) to 10 ms, which I think is too short.

If you have observed the ICH9 SMBus on the scope, can you tell me at
which frequency it is operating? If udelay(100) was always sufficient,
this suggests a bus frequency of at least 90 kHz, which is much faster
than I expected...

-- 
Jean Delvare
