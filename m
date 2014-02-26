From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nomadik: factor platform data into state container
Date: Wed, 26 Feb 2014 13:37:28 +0100
Message-ID: <CACRpkdaDFodytR7eWMVM4+jOZrbd4zhPU_=gXB3z9H0U=o89Wg@mail.gmail.com>
References: <1391423246-32410-1-git-send-email-linus.walleij@linaro.org>
	<20140218183539.GE18768@katana>
	<CACRpkdZULnOmRL7Qv-3Y_R4Cxo1A3CtgUBLmUKjsaehEZHur2w@mail.gmail.com>
	<20140224091311.GB2617@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140224091311.GB2617@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 24, 2014 at 10:13 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Feb 24, 2014 at 09:57:05AM +0100, Linus Walleij wrote:

>> I can easily fix that up ipso facto by modifying the device trees to
>> state 400kHz for them.
>
> Then lets do it this way.

After a check I see that this is already in place in the device trees.

Yours,
Linus Walleij
