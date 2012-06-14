From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: stu300: use clk_prepare/unprepare
Date: Thu, 14 Jun 2012 09:17:19 +0200
Message-ID: <CACRpkdaH24CkXY1DF+JQjjqmVnOpGhCv4Xn+nxdowaLCg3E4Mg@mail.gmail.com>
References: <1339522410-570-1-git-send-email-linus.walleij@stericsson.com>
	<CAM=Q2ct+-URf8VT569Re2GTOFsVQLLspV6EyEj0GAt9qvn67Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2ct+-URf8VT569Re2GTOFsVQLLspV6EyEj0GAt9qvn67Hg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 13, 2012 at 8:22 AM, Shubhrajyoti Datta
<omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
>>
>> Make sure we prepare/unprepare the clock for the ST U300
>> I2C driver as is required by the clk API especially if you
>> use common clock.
>
> Not a comment rather a doubt.
>
> The transfer is still using enable and disable?
> Can you help me understand the difference.

Do you mean you want me to explain the difference
between enable/disable and prepare/unprepare?

>> =A0drivers/i2c/busses/i2c-stu300.c | =A0 =A04 +++-
>> =A01 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2=
c-stu300.c
>> index 4d44af1..79b7851 100644
>> --- a/drivers/i2c/busses/i2c-stu300.c
>> +++ b/drivers/i2c/busses/i2c-stu300.c
>> @@ -924,7 +924,7 @@ stu300_probe(struct platform_device *pdev)
>>
>> =A0 =A0 =A0 =A0dev->speed =3D scl_frequency;
>>
>> - =A0 =A0 =A0 clk_enable(dev->clk);
>> + =A0 =A0 =A0 clk_prepare_enable(dev->clk);
>> =A0 =A0 =A0 =A0ret =3D stu300_init_hw(dev);
>> =A0 =A0 =A0 =A0clk_disable(dev->clk);
>>
>> @@ -960,6 +960,7 @@ stu300_probe(struct platform_device *pdev)
>>
>> =A0err_add_adapter:
>> =A0err_init_hw:
>> + =A0 =A0 =A0 clk_unprepare(dev->clk);
>
> So this also fixes an earlier lack of disable also?

No, there was no lack of disable earlier. If you look just a few lines
up in the patch there is a disable immediately after the
stu300_init_hw() call.

Yours,
Linus Walleij
