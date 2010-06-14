From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: Registering I2C devices on X86
Date: Mon, 14 Jun 2010 08:26:47 +0100
Message-ID: <20100614072647.GN32401@fluff.org.uk>
References: <4C062E70.3090409@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C062E70.3090409-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard R?jfors <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 02, 2010 at 12:12:00PM +0200, Richard R?jfors wrote:
> Hi,
> 
> I have a general question regarding the best way of registering I2C devices on a X86 system.
> 
> On ARM I would have done it in the board config, pretty straight forward.
> 
> On this X86 system the I2C bus is a PCI device, and different I2C
> devices might be tied into the bus depending on which board the
> device is populated on.

Hmm, if it is a PCI device, then surely you should know the PCI ID
you are binding too?
 
> So my idea is to create a "mapping" driver. It opens the I2C
> adapter, creates platform data for each I2C device and add them by
> calling i2c_new_device. I don't find any better way since platform
> data must be created and also translation from GPIO pins to
> interrupt numbers.

That might be a way, however there's not really a good way to add
interrupts dynamically.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
