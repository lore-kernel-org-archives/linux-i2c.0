From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 29 Mar 2011 13:05:02 +0200
Message-ID: <201103291305.02293.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <20110325142648.GC3879@sortiz-mobl> <99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481085E2375D-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 29 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >Yes, NFC seems to be a good fit for a new socket family. 
> >Especially if we ever want to have a proper NFC p2p support 
> >from the kernel.
> >Sending HCI commands should be done through a dedicated 
> >netlink socket too.
> >
> >I am currently strting to work on such solution, and I hope to 
> >be able to come up with a basic prototype for it in a few weeks.
> 
> What about common drivers interface in this case.
> Should we go for common /dev/nfcX interface as well?

I fear there can only be one. A good implementation of a socket
interface would mean that there is no need for a character device.

The difference between the two is where you keep the common
NFC logic:

If you have a character device, it will be like a serial port
connecting to a modem. Any higher-level protocols live in the
user space and are limited to a single application then, which
is required to have appropriate priviledges to open the device.

In contrast, a socket implementation puts the protocol
stack into the kernel, which requires much more kernel code
but almost no user space library code, aside from perhaps
a small shim layer. It makes it possible to have multiple
applications and/or users concurrently use NFC to make connections
to separate endpoints. Since sockets have no implicit permission
handling, the kernel code then needs to implement a way to enforce
policy.

I still don't understand enough about NFC to judge which of
the two is better suited for the problem, but my feeling is
that a socket based implementation would be better if you expect
a lot of people to use it, while the main advantage of the
character device is its simplicity, so that would be preferred
if you only expect a very small set of possible applications
for this.

	Arnd
