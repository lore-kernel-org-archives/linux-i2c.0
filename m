From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 14 Mar 2011 17:45:08 +0200
Message-ID: <99B09243E1A5DA4898CDD8B7001114481082FAE15A@EXMB04.eu.tieto.com>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103101720.53782.arnd@arndb.de>
 <99B09243E1A5DA4898CDD8B7001114481082FAE10A@EXMB04.eu.tieto.com>
 <201103141634.10865.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201103141634.10865.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>Most serial drivers do this, see drivers/tty/serial for a 
>number of examples, or drivers/serial on older kernels.

Thanks, will check it.

>That would depend on your hardware. The only important part is 
>that you make sure you can send out data at any time. If 
>i2c_master_send() causes accesses to your buffer after 
>returning, there has to be an i2c method of making sure that 
>it has completed.
>
>If the usleep_range is trying to synchronize between the NFC 
>and the I2C chip, you must wait for a notication from the NFC 
>hardware that it's done.

No, it's simply there as I have been faceing i2c write error while I do two consecutive writes.
The second fails now and then. That's seems to be a chip issue. I will try to investigate this issue.

>> What's more, I guess the i2c_master_send  is a synchronous call and 
>> when it returnes we know it flushed data. Right?
>
>If i2c_master_send is synchronous, you might not need the 
>usleep_range() at all. Removing that call would be entirely reasonable.

Will see how to approach that.

/Waldek--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
