From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Driver for pca9541 bus master selector
Date: Wed, 13 Oct 2010 15:45:36 +0000 (UTC)
Message-ID: <loom.20101013T173658-276@post.gmane.org>
References: <20100928143302.GA7593@ericsson.com> <20100928171607.395f7736@endymion.delvare> <20100928160746.GB7976@ericsson.com> <20100928184215.00f82717@endymion.delvare> <20100928171627.GA8415@ericsson.com> <20100929091928.16256bb7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare <khali@...> writes:
[...]
> 
> I don't quite see the point of such chips, BTW. I2C supports
> multi-master already, so two masters talking to the same slave
> sequentially is already supported.
> 
To follow up on this, turns out there are (at least) two good reasons for having
such a chip.

Firts, not all i2c masters support multi-master configuration.

The second reason is much more important. In a redundant system, one would not
want redundant masters to be on the same i2c bus. If one of the two fails and
blocks the bus, access to all slaves would be blocked. Not a good idea. Much
better to have two i2c busses, and select the current master on the slave side.

Turns out both reasons apply in my use case. Testing shows that master selection
works quite well with the driver I just submitted. I can persistently access all
slaves from both masters even under high contention (both masters trying to
access the same slave at the same time). If one of the masters fails while
having access to the connected slaves, the other simply takes over after
arbitration times out.

Guenter
