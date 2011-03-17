From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Thu, 17 Mar 2011 15:38:07 +0200
Message-ID: <99B09243E1A5DA4898CDD8B70011144810830AB18B@EXMB04.eu.tieto.com>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103101720.53782.arnd@arndb.de>
 <99B09243E1A5DA4898CDD8B70011144810830AB119@EXMB04.eu.tieto.com>
 <201103171407.58164.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201103171407.58164.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Arnd, 

>An application can open the device, and then do a 
>pthread_create() or a fork(). In either case, you have two 
>concurrent threads that have access to the file pointer and 
>can read from it concurrently, which is inherently racy 
>regarding which of the processes gets the data.

In that case I would relay on the application to synchronise the access.

>This is not very different from opening the file descriptor in 
>multiple processes, which you prevent using your logic.

but in the case when two independent applications try to open my device I can't let the second to access. They obviously won't synch the access.

>You can of course argue that you try your best to prevent the 
>race. Traditionally, e.g. on serial ports and the like, we 
>don't do this but instead rely on user space synchronizing the 
>access. What you have to make sure of course is that multiple 
>threads calling read on the same file can never bring the 
>kernel driver into an invalid state.

I assume, if an application shares the file pointer deliberately it have to sync the access. In other cases, the driver needs to secure it.

Waldek--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
