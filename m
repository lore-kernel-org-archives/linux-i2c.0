From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: factor platform data into state container
Date: Mon, 23 Dec 2013 18:19:05 +0100
Message-ID: <CACRpkdadLqn1R2psCZNDJc7frdw9x6Yfw1oBUidj2aKSe4RmeA@mail.gmail.com>
References: <1385676737-15127-1-git-send-email-linus.walleij@linaro.org>
	<CACRpkdZxN2vE7nyxtOrk8mpvcnyqnfaKo3qgTY1J-E__Kv8zJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZxN2vE7nyxtOrk8mpvcnyqnfaKo3qgTY1J-E__Kv8zJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 14, 2013 at 1:20 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Nov 28, 2013 at 11:12 PM, Linus Walleij
> <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> Move the former platform data struct nmk_i2c_controller into the
>> per-device state container struct i2c_nmk_client, and remove all
>> the platform data probe path hacks.
>>
>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Wolfram: ping on this.

Ping on this again.

Yours,
Linus Walleij
