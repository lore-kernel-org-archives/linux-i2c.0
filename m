From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: nomadik: remove platform data header
Date: Mon, 23 Dec 2013 18:18:39 +0100
Message-ID: <CACRpkdZvRkBC5hBaknW4vX2bfB780e1dyxQnMrRjybmYEXTe=A@mail.gmail.com>
References: <1385676727-15089-1-git-send-email-linus.walleij@linaro.org>
	<CACRpkdYcjrb_MpUEK6SSJx3b0-UPUfXy1UhOdndKS4i=SNVLgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdYcjrb_MpUEK6SSJx3b0-UPUfXy1UhOdndKS4i=SNVLgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 14, 2013 at 1:19 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Nov 28, 2013 at 11:12 PM, Linus Walleij
> <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> The Nomadik I2C is now configured from the device tree on all platforms
>> using this controller. Delete the platform data header and move the
>> definitions into the driver so it is all contained in one single file.
>>
>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Wolfram: ping on this.

Ping on this again.

Yours,
Linus Walleij
