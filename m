From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V2 2/5] arm: shmobile: r7s72100: add i2c clocks
Date: Thu, 26 Dec 2013 22:51:34 +0100
Message-ID: <CAMuHMdXP4DAF1_DPtNfwCyP8WHFU03=zgM7i8FW9n6tcJpAHHQ@mail.gmail.com>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
	<1387402321-21866-3-git-send-email-wsa@the-dreams.de>
	<20131224024855.GC22401@verge.net.au>
	<CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
	<20131226212539.GA2561@katana>
	<CAMuHMdXF6WmS_j4pC1U5jL3SK-ck7N=EA+-45duXdRZP1cOJkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXF6WmS_j4pC1U5jL3SK-ck7N=EA+-45duXdRZP1cOJkw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 26, 2013 at 10:34 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>>> Note that after dropping these lines:
>>>
>>>        CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
>>>        CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
>>>        CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
>>>        CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
>>>
>>> i2c stopped working.
>>
>> ??? Why do you want to drop these lines?
>
> Your v2 dropped them, presumably in response to Sergei's ICKy comments.
> And that's what Simon committed...

Upon checking again, your v2 did contain them, but gmail tried to smart
me out by not showing those few lines.
So it must have been Simon who dropped them, or lost them during rebase?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
