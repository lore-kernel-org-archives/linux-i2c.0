From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 25 Mar 2011 15:26:49 +0100
Message-ID: <20110325142648.GC3879@sortiz-mobl>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103181319.54191.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201103181319.54191.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, hthebaud@insidefr.com, matti.j.aaltonen@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 18, 2011 at 01:19:53PM +0100, Arnd Bergmann wrote:
> On Friday 18 March 2011, Waldemar Rymarkiewicz wrote:
> > Add new driver for MicroRead NFC chip connected to i2c bus.
> > 
> > See Documentation/nfc/nfc-microread.txt.
> 
> As I said in my first review and Alan also pointed out now, the
> most important change will be to add a common NFC core layer,
> before adding more hardware drivers.
> 
> Also, regarding the user interface, we need to be really sure
> that this is the best way of talking to NFC devices. The interface
> you have today is a simple character device read/write kind,
> which may be the best thing if the protocol stack on top is
> really simple and there is never the need to have multiple
> applications talking to different endpoints on the wireless
> interface, and if there are no protocol headers being
> send over the character device interface.
> 
> Otherwise, a better interface is probably to add a new network
> socket family and abstract the protocol layers in the kernel.

Yes, NFC seems to be a good fit for a new socket family. Especially if we ever
want to have a proper NFC p2p support from the kernel.
Sending HCI commands should be done through a dedicated netlink socket too.

I am currently strting to work on such solution, and I hope to be able to come
up with a basic prototype for it in a few weeks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
