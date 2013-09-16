From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4 v2] mfd: add STw481x driver
Date: Mon, 16 Sep 2013 14:44:35 +0200
Message-ID: <CACRpkdatiELF3WK9qE_Mgcq3iCgv5w3X22xp1=232JJq9sWggQ@mail.gmail.com>
References: <1379094851-26385-1-git-send-email-linus.walleij@linaro.org>
	<20130916091956.GF3999@lee--X1>
	<20130916104009.GA29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130916104009.GA29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wang Shilong <wangshilong1991-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 16, 2013 at 12:40 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Sep 16, 2013 at 10:19:56AM +0100, Lee Jones wrote:
>
>> Can't you just NULL .id_table?

No. That is not OK with the I2C core. It's
not easy to get rid of the requirement for .id_table
not to be NULL either.

>> Here's the code which would use it:
>> > /* match on an id table if there is one */
>> > if (driver->id_table)
>> >         return i2c_match_id(driver->id_table, client) != NULL;
>
>> Matching for "dummy" will just waste cycles.
>
> i2c_device_probe() will return -ENODEV if id_table is NULL before we get
> to actually matching.  We could remove that check though...

Copy+pasting from my own reply earlier:

I've tried to fix this for DT-only I2C devices
and this very driver was the reason.

But a tiresome regression due to drivers relying on this
i2c_device_id not being NULL and inability to remove it from the I2C
core without refactoring the world ensued, see:
commit c80f52847c50109ca248c22efbf71ff10553dca4

Reverted in:
commit 661f6c1cd926c6c973e03c6b5151d161f3a666ed

For this reason I think:
http://marc.info/?l=linux-next&m=137148411231784&w=2

I have tentatively given up getting pure DT I2C drivers
to probe, I don't think I have the whole picture, but
Wolfram has serious doubts about this and say we have
to be careful ....

Wolfram, do you have some ideas on how we should
proceed or ar you happy with merging this as-is?

Yours,
Linus Walleij
