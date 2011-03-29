From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 29 Mar 2011 11:00:59 +0300
Message-ID: <99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103181319.54191.arnd@arndb.de> <20110325142648.GC3879@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110325142648.GC3879@sortiz-mobl>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>Yes, NFC seems to be a good fit for a new socket family. 
>Especially if we ever want to have a proper NFC p2p support 
>from the kernel.
>Sending HCI commands should be done through a dedicated 
>netlink socket too.
>
>I am currently strting to work on such solution, and I hope to 
>be able to come up with a basic prototype for it in a few weeks.

What about common drivers interface in this case.  Should we go for common /dev/nfcX interface as well?

Waldek--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
