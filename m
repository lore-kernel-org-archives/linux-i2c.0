From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Wed, 23 Nov 2011 11:28:47 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B40D349@wm021.weinmann.com>
References: <D99582E5322435468A77E74BB0039E7B1D1655BF4D@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
 <D99582E5322435468A77E74BB0039E7B1D1655BFBB@SRV02.hamburg.garz-fricke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D99582E5322435468A77E74BB0039E7B1D1655BFBB-6hi2BFpdtA3X4XV0xjfKZxOngtiEHj0sqGK+G5UkneY@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Carsten Behling' <carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Carsten Behling wrote on 2011-11-23:

>> this case is already catched in at91_do_twi_transfer():
> 
> Sorry, I did not found this code in your patch.
> (http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg06556.html):
> 
>> +       if (is_read) {
>> +               if (!dev->buf_len)

yes, this won't work for buf_len == 1. It is corrected in
https://lkml.org/lkml/2011/11/18/223 which I held back for some time
as it should have been just a feature extension. I was not aware it
also fixed the buf_len = 1 bug. Sorry for that...

(Explanation: in the first implementation I immediately decremented
buf_len, so buf_len == 1 could not occur. Later I removed that but
did not fully fold it into the base patch.)

Thanks,
Niko
