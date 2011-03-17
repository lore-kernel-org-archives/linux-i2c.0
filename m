From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Thu, 17 Mar 2011 14:54:42 +0100
Message-ID: <201103171454.42838.arnd@arndb.de>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103171407.58164.arnd@arndb.de> <99B09243E1A5DA4898CDD8B70011144810830AB18B@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B70011144810830AB18B-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 17 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >This is not very different from opening the file descriptor in 
> >multiple processes, which you prevent using your logic.
> 
> but in the case when two independent applications try to open 
> my device I can't let the second to access. They obviously won't
> synch the access.

My point was that you don't need to worry.
 
> >You can of course argue that you try your best to prevent the 
> >race. Traditionally, e.g. on serial ports and the like, we 
> >don't do this but instead rely on user space synchronizing the 
> >access. What you have to make sure of course is that multiple 
> >threads calling read on the same file can never bring the 
> >kernel driver into an invalid state.
> 
> I assume, if an application shares the file pointer deliberately
> it have to sync the access. In other cases, the driver needs to
> secure it.

As I said, it's not important if you do it and it certainly doesn't
cause harm to prevent multiple open. It's just that generally
we don't care too much about this problem.

	Arnd
