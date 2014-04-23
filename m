From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif,
 fsi2 compat strings
Date: Wed, 23 Apr 2014 09:26:46 +0200
Message-ID: <CAMuHMdUBf4ATws9+P6EOvjG2V8povMMWL6xOQeFESC9Wm5xz8g@mail.gmail.com>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
	<5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
	<CAMuHMdUA+wJmgn0P_q38ri7_TAq7zha-ekSUrvdpntG5gFv56Q@mail.gmail.com>
	<20140423071813.GA2777@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140423071813.GA2777@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulrich Hecht <ulrich.hecht-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Apr 23, 2014 at 9:18 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> > -               compatible = "renesas,rmobile-iic";
>> > +               compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";
>>
>> I see an opportunity for improvement here: this driver doesn't seem to have
>> any bindings documented under Documentation/devicetree/bindings/?
>
> I am brushing up this driver currently, so consider it done. Just

That's great to hear, thanks!

> waiting for a minor email issue to be solved before I can send out
> patches.

Good luck!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
