From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Tue, 28 Feb 2017 13:47:14 +0100
Message-ID: <20170228124714.GA1014@kroah.com>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
 <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
 <20170220182214.izi46a7lbzck7q4r@ninjato>
 <23773cd4-a9a4-5323-4cc2-71d1d617b232@i2se.com>
 <20170221201403.GA1481@katana>
 <20170222072058.GA9650@kroah.com>
 <77c2af87-6f0e-4de0-18e9-0aa798f282d0@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <77c2af87-6f0e-4de0-18e9-0aa798f282d0-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 28, 2017 at 01:42:42PM +0100, Stefan Wahren wrote:
> Hi Greg,
> 
> Am 22.02.2017 um 08:20 schrieb Greg Kroah-Hartman:
> > On Tue, Feb 21, 2017 at 09:14:03PM +0100, Wolfram Sang wrote:
> > > > > On Thu, Feb 16, 2017 at 09:20:45PM +0000, Stefan Wahren wrote:
> > > > > > Since commit e2474541032d ("bcm2835: Fix hang for writing messages
> > > > > > larger than 16 bytes") the interrupt handler is prone to a possible
> > > > > > NULL pointer dereference. This could happen if an interrupt fires
> > > > > > before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
> > > > > > on the RPi 3. Even this is an unexpected behavior the driver must
> > > > > > handle that with an error instead of a crash.
> > > > > > 
> > > > > > CC: Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
> > > > > > CC: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> > > > > > Reported-by: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > > Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than 16 bytes")
> > > > > > Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> > > > > Applied to for-next, thanks (will be in 4.11)!
> > > > > 
> > > > since this patch is too late for 4.10, should i resent with CC to stable in
> > > > order to get it into the next 4.10 release?
> > > It has the Fixes: tag, that will do.
> > But it moves it much lower on my "this needs to get into stable now!"
> > priority list.  I'll try to remember this one when it goes by...
> > 
> > thanks,
> > 
> > greg k-h
> 
> should i resend, since i didn't send you the initial patch?

Sure!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
