From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Thu, 31 Mar 2011 16:49:21 +0200
Message-ID: <201103311649.21737.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <20110331141650.GB2704@sortiz-mobl> <99B09243E1A5DA4898CDD8B7001114481085F0FE5A@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481085F0FE5A-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, Sebastian.Chlad-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 31 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >My idea of an initial NFC subsystem architecture was actually 
> >the following
> >one:
> >- A core NFC layer against which NFC drivers would register.
> >- A netlink socket for handling the HCI commands. That would 
> >put a big part of the NFC HCI layer in kernel land and could 
> >potentially simplify the existing NFC stacks.
> 
> Shouldn't be better to add a new AF_NFC sock family and then
> register new LLCP and HCI protocols?

That depends on what the HCI protocol really looks like, e.g.
is it's related to the LLCP data at all or not.

Another option might be to control the HCI over setsockopts,
but the netlink socket sounds more flexible for this.

	Arnd
