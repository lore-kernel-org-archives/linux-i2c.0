From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Sat, 13 Jun 2009 10:39:34 +0100
Message-ID: <20090613093934.GE20446@fluff.org.uk>
References: <4A2566E8.7080404@mocean-labs.com> <20090613093830.GD20446@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090613093830.GD20446-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Richard R????jfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 13, 2009 at 10:38:30AM +0100, Ben Dooks wrote:
> On Tue, Jun 02, 2009 at 07:52:40PM +0200, Richard R????jfors wrote:
> > There is sometimes a need for the ocores driver to add devices to the bus when installed.
> > 
> > i2c_register_board_info can not always be used, because the I2C devices are not known at an early state,
> > they could for instance be connected on a I2C bus on a PCI device which has the Open Cores IP.
> > 
> > i2c_new_device can not be used in all cases either since the resulting bus nummer might be unknown.
> > 
> > The solution is the pass a list of I2C devices in the platform data to the Open Cores driver. Is
> > useful for MFD drivers for instance.
> 
> Hi, these two minor issues here I'd like to get at-least a reply
> if not a fix for:

sorry, just noticed a new patch. will go and merge that.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
