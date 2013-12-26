From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V2 2/5] arm: shmobile: r7s72100: add i2c clocks
Date: Thu, 26 Dec 2013 22:20:23 +0100
Message-ID: <CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
	<1387402321-21866-3-git-send-email-wsa@the-dreams.de>
	<20131224024855.GC22401@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131224024855.GC22401-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 24, 2013 at 3:48 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> On Wed, Dec 18, 2013 at 10:31:58PM +0100, Wolfram Sang wrote:
>> From: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>>
>> Tested with RIIC2 on a genmai board. Others untested but hopefully
>> trivial enough to be added.
>>
>> Signed-off-by: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>> Acked-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>> ---
>>
>> V2: adapt to established sorting
>
> Thanks. This seems safe enough and I will queue it up.

Note that after dropping these lines:

       CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
       CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
       CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
       CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),

i2c stopped working.

Before:

of_irq_parse_one: dev=/i2c@fcfee800/eeprom@50, index=0
at24 2-0050: 16384 byte 24c128 EEPROM, writable, 64 bytes/write
i2c-riic fcfee800.i2c: registered with 400000Hz bus speed

After:

i2c-riic fcfee800.i2c: missing controller clock
i2c-riic: probe of fcfee800.i2c failed with error -2

Am I missing some other patch?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
