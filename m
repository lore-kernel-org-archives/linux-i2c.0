From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Thu, 17 Mar 2011 14:07:57 +0100
Message-ID: <201103171407.58164.arnd@arndb.de>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103101720.53782.arnd@arndb.de> <99B09243E1A5DA4898CDD8B70011144810830AB119@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B70011144810830AB119-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 17 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >> >Note that the microread_is_busy() logic does not protect you from 
> >> >having multiple concurrent readers, because multiple threads may 
> >> >share a single file descriptor.
> >> 
> >> It's just used to ensure that only one reader can open the device.
> >> It's called only in open callback.
> >> The mutex actually secures concurrent read operations. 
> >
> >So if having multiple readers is safe (though possibly not 
> >meaningful), I guess you don't really need the 
> >microread_is_busy() logic.
> >
> >I suppose it doesn't hurt either, it just seems a bit 
> >pointless when it does the right thing most of the time, but 
> >not always.
> >
> 
> Could you give me an example when the microread_is_busy() logic does
> not do what it's intended to do. I don't really get your point here. 
> 

An application can open the device, and then do a pthread_create()
or a fork(). In either case, you have two concurrent threads that
have access to the file pointer and can read from it concurrently,
which is inherently racy regarding which of the processes gets the
data.

This is not very different from opening the file descriptor in
multiple processes, which you prevent using your logic.

You can of course argue that you try your best to prevent the
race. Traditionally, e.g. on serial ports and the like, we
don't do this but instead rely on user space synchronizing the
access. What you have to make sure of course is that multiple
threads calling read on the same file can never bring the
kernel driver into an invalid state.

	Arnd
