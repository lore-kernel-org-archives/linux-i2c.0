From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Accessing EEPROM from Linux driver
Date: Wed, 25 Jan 2012 12:19:06 +0100
Message-ID: <CAGm1_ks9Do5Wk=tNoqYZtnNm4KEo3OF4zWknDirS8+hW_T_0qA@mail.gmail.com>
References: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A@mail.gmail.com>
 <20120124100636.GB2609@pengutronix.de> <CAGm1_ksgrtyAmo73f-GCr_ZH=8i8LxbwFpMH81U2STQzmT9GYQ@mail.gmail.com>
 <CAGm1_kugwA-rWXmCNNcxRc4XZ5u-2N8Rwf+LBaoRrOgBWMTbDg@mail.gmail.com> <20120124111320.GD2609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120124111320.GD2609-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 24, 2012 at 12:13 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>> Wolfram, do you have any example how to access at24_macc_read()? My
>> kernel is 2.6.37. Theres is a statement to export this code to the
>> kernel via chip.setup(), which appears to be NULL. What headers do I
>> need in the network driver?
>
> I haven't used it myself, but using LXR [1] you can check current users
> of at24_platform_data and find users (davinci) using this feature.
>
> [1] http://lxr.linux.no/#linux+v3.2.1/include/linux/i2c/at24.h

Thanks. It's working now. I was lucky to have DaVinci based EMAC in
am3517, so I only had to adjust the code on the platform side. The
driver itself was left untouched. For USB based NIC and WLAN I'll need
to get my hands on their drivers :-(

I submitted a patch to eeprom's documentation. At this point I have a
question? Are those TODO items still valid? At least in regards of
write capability? In 2.6.37 kernel I can write to EEPROM through sysfs
entry. Unfortunately I can't test any 3.x kernel because PSP for
am3517 is still not finished.

Regards,
Yegor
