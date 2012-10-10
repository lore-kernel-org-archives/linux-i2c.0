From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nomadik: adopt pinctrl support
Date: Wed, 10 Oct 2012 10:03:41 +0200
Message-ID: <CACRpkdYOGZ1=3wahfxwJBGHW2LjTeYyHzK=OCZ9WMgnKX_pxCw@mail.gmail.com>
References: <1348837151-20820-1-git-send-email-linus.walleij@stericsson.com>
	<20121006133006.GA25123@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121006133006.GA25123-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Oct 6, 2012 at 3:30 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

>>   err_add_adap:
>> +     clk_unprepare(dev->clk);
>> + err_prep_clk:
>
> This is unrelated, right? And it is also unneeded because of Ulf
> Hansson's patch?

True. I'll roll out a v3 based on the latest i2c code.

Yours,
Linus Walleij
