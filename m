From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c-nomadik: Fixup clock handling
Date: Mon, 1 Oct 2012 13:42:47 +0200
Message-ID: <CAPDyKFpyB7SBY=Ht7Mz8KsC_eugNVTMF1C251BYPZMS2pFsDYg@mail.gmail.com>
References: <1348154447-3815-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdZZ-gNBi7EDwhXHawmzPD9dE8wo9voX-MJ7CYQ058k-Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZZ-gNBi7EDwhXHawmzPD9dE8wo9voX-MJ7CYQ058k-Jw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Juts a kind reminder on this. Do you see any problem merging this?

Kind regards
Ulf Hansson

On 20 September 2012 21:17, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Sep 20, 2012 at 5:20 PM, Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
>
>> From: Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>>
>> Make sure to clk_prepare as well as clk_enable.
>
> Looks correct. xfer() is slowpatch so we might as well call
> prepare/unprepare functions there.
> Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Yours,
> Linus Walleij
