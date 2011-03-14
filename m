From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 14 Mar 2011 16:59:53 +0200
Message-ID: <99B09243E1A5DA4898CDD8B7001114481082FAE10A@EXMB04.eu.tieto.com>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103101452.54862.arnd@arndb.de>
 <99B09243E1A5DA4898CDD8B7001114481082EF2A65@EXMB04.eu.tieto.com>
 <201103101720.53782.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201103101720.53782.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

>Oh, I see you simply do
>
>       ret = i2c_master_send(client, info->buf, len);
>       usleep_range(1000, 10000);
>
>and assume that the buffer can always be written within a 
>milisecond, so you just slow down output enough to never have 
>to worry about it, right?
>
>A nicer solution would be to have an interrupt driven output 
>so you know when the i2c buffers have been flushed.

Well, I get the idea of interrupt driven output, but as I have little linux kernel experience I'm not sure how to implement this. 
Can you extend you thoughts or if you know piont me a driver which uses that concept?

I'm not sure who should rise an interrupt when data has been flushed. I2c core or the chip itself?
What's more, I guess the i2c_master_send  is a synchronous call and when it returnes we know it flushed data. Right? 

/Waldek
