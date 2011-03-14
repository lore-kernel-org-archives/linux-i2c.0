From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 14 Mar 2011 18:15:15 +0200
Message-ID: <99B09243E1A5DA4898CDD8B7001114481082FAE168@EXMB04.eu.tieto.com>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103141634.10865.arnd@arndb.de>
 <99B09243E1A5DA4898CDD8B7001114481082FAE15A@EXMB04.eu.tieto.com>
 <201103141700.26457.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201103141700.26457.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>> No, it's simply there as I have been faceing i2c write error while I 
>> do two consecutive writes.
>> The second fails now and then. That's seems to be a chip issue.
>> I will try to investigate this issue.
>
>Ok. It sounds like a bug in the i2c driver, you should also 
>take a look there. Maybe it has never had to deal with this 
>much write data at once.

It's been confirmed now that this is how chip is supposed to work and the driver should not care about this scenario. Upper layers (onfc stack) handle this.
Thus, will simply remove urange_sleep and that's it.

/Waldek
