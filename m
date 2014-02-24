From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nomadik: factor platform data into state container
Date: Mon, 24 Feb 2014 09:57:05 +0100
Message-ID: <CACRpkdZULnOmRL7Qv-3Y_R4Cxo1A3CtgUBLmUKjsaehEZHur2w@mail.gmail.com>
References: <1391423246-32410-1-git-send-email-linus.walleij@linaro.org>
	<20140218183539.GE18768@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140218183539.GE18768@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 18, 2014 at 7:35 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:

>> -     of_property_read_u32(np, "clock-frequency", &pdata->clk_freq);
>> +     /* Default to 400 kHz if no frequency is given in the node */
>> +     if (of_property_read_u32(np, "clock-frequency", &nmk->clk_freq))
>> +             nmk->clk_freq = 400000;
>
> I can't really recommend this. 100kHz is something all devices support,
> but, although common, 400 kHz is already an extension of the standard.
>
> Let me know if I should fix this up for you.

I think this is done like this because all devices on all Nomadik variants
out there (Nomadik, Ux500) support 400kHz.

Buit change it if you prefer, nothing will break, it will just get slower :-)

I can easily fix that up ipso facto by modifying the device trees to
state 400kHz for them.

Yours,
Linus Walleij
