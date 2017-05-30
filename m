From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: i2c-mux: Fix channel parent node assignment
Date: Tue, 30 May 2017 10:46:03 +0200
Message-ID: <CAMuHMdWfv=wd0rmG60U-RnAE1HhVNEQ8qSoSmDhZRFPp_8HU6g@mail.gmail.com>
References: <1496132006-20329-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdV3MMMegePaNRk07Stym+ovhjksPFrpeBRbxSciSB7BTQ@mail.gmail.com> <20170530083848.GA19019@w540>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170530083848.GA19019@w540>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: jmondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Peter Rosin <peda@axentia.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jacopo,

On Tue, May 30, 2017 at 10:38 AM, jmondi <jacopo@jmondi.org> wrote:
> On Tue, May 30, 2017 at 10:31:21AM +0200, Geert Uytterhoeven wrote:
>> On Tue, May 30, 2017 at 10:13 AM, Jacopo Mondi
>> <jacopo+renesas@jmondi.org> wrote:
>> > I2c-mux channels are created with the mux parent device as their own
>> > parent, while they should be siblings of the mux itself.
>>
>> Isn't it the other way around? Cfr. the example and the patch.
>
> Yeah, I actually didn't know the exact meaning of "siblings" then.
>
> So:
> I2c-mux channels are created as mux siblings while they should be
> children of the mux itself. Fix it.
>
> Any better? ;)

Perfect!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
