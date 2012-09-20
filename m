From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c-nomadik: Fixup clock handling
Date: Thu, 20 Sep 2012 21:17:37 +0200
Message-ID: <CACRpkdZZ-gNBi7EDwhXHawmzPD9dE8wo9voX-MJ7CYQ058k-Jw@mail.gmail.com>
References: <1348154447-3815-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348154447-3815-1-git-send-email-ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 20, 2012 at 5:20 PM, Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:

> From: Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>
> Make sure to clk_prepare as well as clk_enable.

Looks correct. xfer() is slowpatch so we might as well call
prepare/unprepare functions there.
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
