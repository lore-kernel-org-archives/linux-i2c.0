From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: get the i2c pin group by pinctrl api
Date: Wed, 27 Mar 2013 11:20:28 +0100
Message-ID: <CACRpkdbg=ii1XjUmVd7GOOWF_FAMq_uUcvaGstbWjiGWGEbFLQ@mail.gmail.com>
References: <1363591361-5992-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363591361-5992-1-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 18, 2013 at 8:22 AM, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org> wrote:

> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>
> hardcode set i2c pin group to i2c function before, here we
> move to use standard pinctrl API to get pins of the group.
>
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

NAK.

This is done by the device core as of commit
ab78029ecc347debbd737f06688d788bd9d60c1d
"drivers/pinctrl: grab default handles from device core".

You only need to fetch pinctrl handles in drivers if you're
using anything else than the default state.

Yours,
Linus Walleij
