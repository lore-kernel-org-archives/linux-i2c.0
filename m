From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: factor platform data into state container
Date: Tue, 7 Jan 2014 19:04:01 +0100
Message-ID: <CACRpkdYcbjSHM1+nzhec37FNn3uiwdmmO5CXbA2zvhFd_XFirQ@mail.gmail.com>
References: <1385676737-15127-1-git-send-email-linus.walleij@linaro.org>
	<20140103153553.GD7132@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140103153553.GD7132@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 3, 2014 at 4:35 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> +     if (!np) {
>> +             dev_err(&adev->dev, "no device node\n");
>> +             return -ENODEV;
>
> Can this really happen? How should driver and device match otherwise?

Nah. I'll fix.

> Rest is looking good.

Does this mean that you applied patch 1/3 and 2/3?

Yours,
Linus Walleij
