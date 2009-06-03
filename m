From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Wed, 3 Jun 2009 10:15:33 +0200
Message-ID: <20090603101533.599d41db@hyperion.delvare>
References: <4A2566E8.7080404@mocean-labs.com>
	<20090602224822.GE18453@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090602224822.GE18453-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Richard Rojfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2 Jun 2009 23:48:22 +0100, Ben Dooks wrote:
> On Tue, Jun 02, 2009 at 07:52:40PM +0200, Richard R????jfors wrote:
> > There is sometimes a need for the ocores driver to add devices to the bus when installed.
> 
> please wrap to 72 characters per line. 
>  
> > i2c_register_board_info can not always be used, because the I2C devices are not known at an early state,
> > they could for instance be connected on a I2C bus on a PCI device which has the Open Cores IP.
> 
> Maybe i2c_register_board_info() needs to check if the bus is extant
> or not. Anyone else have any feedback on this suggestion?

I don't understand the question ^^ Please clarify.

> > i2c_new_device can not be used in all cases either since the resulting bus nummer might be unknown.
> > 
> > The solution is the pass a list of I2C devices in the platform data to the Open Cores driver. Is
> > useful for MFD drivers for instance.
> 
> Possibly, but most systems I see know what devices they have before
> instantiation so can hard-fix the bus numbering when supplying the MFD
> drivers with their data.

I don't like the idea much either, nor the implementation.

Firstly, I don't understand why this would be needed. I can understand
that in some cases you don't know the I2C bus number in advance, but
then some code must still instantiate the I2C bus, and the same code
should be able to call i2c_new_device() directly to instantiate the
devices on that bus. Richard, did you try to just do this? If it
doesn't work, please explain why.

Secondly, if (and only if) this is really needed, then I'd rather
implement the mechanism as part of i2c-core (basically extending
i2c_register_board_info) than in individual bus drivers.

-- 
Jean Delvare
