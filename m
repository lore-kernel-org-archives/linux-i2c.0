From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Thu, 31 Mar 2011 16:16:51 +0200
Message-ID: <20110331141650.GB2704@sortiz-mobl>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110325142648.GC3879@sortiz-mobl>
 <99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
 <201103291305.02293.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201103291305.02293.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 29, 2011 at 01:05:02PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> > >Yes, NFC seems to be a good fit for a new socket family. 
> > >Especially if we ever want to have a proper NFC p2p support 
> > >from the kernel.
> > >Sending HCI commands should be done through a dedicated 
> > >netlink socket too.
> > >
> > >I am currently strting to work on such solution, and I hope to 
> > >be able to come up with a basic prototype for it in a few weeks.
> > 
> > What about common drivers interface in this case.
> > Should we go for common /dev/nfcX interface as well?
> 
> I fear there can only be one. A good implementation of a socket
> interface would mean that there is no need for a character device.
My idea of an initial NFC subsystem architecture was actually the following
one:
- A core NFC layer against which NFC drivers would register.
- A netlink socket for handling the HCI commands. That would put a big part of
the NFC HCI layer in kernel land and could potentially simplify the existing
NFC stacks.
- A socket family for the LLCP abstraction, a.k.a. NFC peer to peer mode.

We can start working on the first 2 items and leave the last one as a future
enhancement, since what NFC is currently mostly used for is tag
reading/writing and smartcard emulation.

Basically, we'd replace the current character device option with a netlink
one, allowing for a single kernel entry point for multiple applications
willing to do NFC.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
