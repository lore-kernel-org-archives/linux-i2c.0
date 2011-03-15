From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 15 Mar 2011 10:01:18 +0000 (UTC)
Message-ID: <loom.20110315T104753-187@post.gmane.org>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103101452.54862.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@...> writes:

> 
> On Thursday 10 March 2011, Waldemar Rymarkiewicz wrote:
> > Add new driver for MicroRead NFC chip connected to i2c bus.
> > 
> > See Documentation/nfc/nfc-microread.txt.
> 
> The imlpementation looks fairly clean, no objections on that.
> 
> However, this is the second NFC driver (at least), and that means
> it's time to come up with a generic way of talking to NFC devices
> from user space. We cannot allow every NFC controller to have
> another set of arbitrary ioctl numbers.
I definitely agree we need to come up with some sort of NFC subsystem.
Ideally though, it should be more than ioctls over character devices. NFC is not
that far from Bluetooth or IrDA and having an NFC socket family would be quite
nice. Especially for the p2p parts of the spec. And instead of passing commands
through ioctls, we might want to look at a netlink based interface.
The few currently available NFC stacks are all implementing the NFC HCI layer in
userspace, on top of a a more or less big HAL. By at least moving the HCI layer
down to the kernel, and having userspace talk to it through netlink, we could
eventually get rid of those HALs.

Cheers,
Samuel.
