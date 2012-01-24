From: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Subject: Re: Accessing EEPROM from Linux driver
Date: Tue, 24 Jan 2012 10:54:19 +0100
Message-ID: <CADkCAut8iYA5Bk4oLczp1sGFhq-5EFKeN5bpQMpSYdhhjepCfQ@mail.gmail.com>
References: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Yegor:

On Tue, Jan 24, 2012 at 10:51 AM, Yegor Yefremov
<yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> What were the appropriate method of accessing
> EEPROM from a network driver? AFAIK no functions were exported from
> eeprom.c.

You probably want to read those values in userspace, and then stuff
them back into the ethernet device via ifconfig or similar when you
bring the interface up.  Then you can leave both drivers as-is.


b.g.
-- 
Bill Gatliff
bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org
