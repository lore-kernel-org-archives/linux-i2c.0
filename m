From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Mon, 17 Jun 2013 23:15:30 +0100
Message-ID: <CACxGe6sTq=h9jjqesjvUA4Bweh7zgE4VOLoOTgGPC_D_v+8NtA@mail.gmail.com>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg@mail.gmail.com>
 <51BF2FC5.40207@wwwdotorg.org> <CACRpkdbjy+PcpNkSg4PuuP2Z9RyrnqSW0uchHFHVZ8VYPeoDyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdbjy+PcpNkSg4PuuP2Z9RyrnqSW0uchHFHVZ8VYPeoDyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 17, 2013 at 5:33 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jun 17, 2013 at 5:48 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>
>> This has just shown up in next-20130617, and breaks at least the
>> TPS65910 and TPS62360 drivers, since they assume that the id parameter
>> passed to probe is non-NULL. However, now the parameter is NULL since
>> these drivers have both an ID table and an OF match table.
>
> So you mean they come in through the DT boot path and assume
> that parameter is non-null even though they should not make use of
> it?
>
>> I'd like to suggest this patch be reverted an re-introduced immediately
>> after the merge window. That should give enough time for everyone to get
>> a heads-up on fixing any drivers with a similar problem, rather than
>> trying to cram all that in immediately before the merge window.
>
> OK that works for me, I'm not in any hurry.

Deferring by a merge window isn't going to make it any less painful.
Do your best to find all the users that need to be changed. Use a
coccinelle search perhaps, but I think it should be merged anyway.

g.
