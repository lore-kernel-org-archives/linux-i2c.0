From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 15 Mar 2011 15:16:34 +0100
Message-ID: <20110315141633.GA29505@sortiz-mobl>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103101452.54862.arnd@arndb.de>
 <loom.20110315T104753-187@post.gmane.org>
 <99B09243E1A5DA4898CDD8B70011144810830AA4BD@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <99B09243E1A5DA4898CDD8B70011144810830AA4BD-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Waldemar,

On Tue, Mar 15, 2011 at 02:59:09PM +0200, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> Hi Samuel,
> 
> >The few currently available NFC stacks are all implementing 
> >the NFC HCI layer in
> >userspace, on top of a a more or less big HAL. By at least 
> >moving the HCI layer
> >down to the kernel, and having userspace talk to it through 
> >netlink, we could
> >eventually get rid of those HALs.
> 
> Is HCI already standarised? I can't find the spec anywhere.
ETSI has a final spec for it, TS 102 622 (latest version is 10.2.0). I know
the NFC forum is trying to come up with a competing standard: NCI. As far as I
know they haven't released any spec for it yet.

Cheers,
Samuel.

P.S.: All ETSI specs are freely available.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
