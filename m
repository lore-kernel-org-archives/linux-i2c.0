From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
Date: Fri, 26 Aug 2016 09:39:03 +0200
Message-ID: <CACRpkdZViewtQgW4GCuOkiKthqZMvXheORmg2rc-xG1cK4S4iA@mail.gmail.com>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org> <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
 <CACRpkdZeomin6_u=1hm-fJucMnQmAJXu01YaC0g1KdafWPD2kg@mail.gmail.com> <5903e282-aaf9-9c86-5df5-17b75d5b4018@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5903e282-aaf9-9c86-5df5-17b75d5b4018-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nick Vaccaro <nvaccaro-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Ge Gao <ggao-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org>, Anna Si <asi-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org>, Nathan Royer <nroyer-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Gregor Boirie <gregor.boirie-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 25, 2016 at 10:32 PM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
> On 2016-08-25 14:44, Linus Walleij wrote:

>> Then the rest is merge mechanics, dunno the best there,
>> Jonathan can decide.
>
> I waited a bit for someone to scream about v4.8-rc3 being a bad base
> for some reason, but there was only silence. I have now pushed the
> series, and it can be pulled by anyone interested.
>
> Wolfram, please merge it into i2c/for-next
>
> Linus/Jonathan, technically you don't need all patches and can skip
> the last three, but it seems a bit over the top to be super anal
> about that detail...

OK I'll pull this into my development branch. At least we can
merge the bindings, whether to merge the driver this or next merge
window (or simply apply the patch to the I2C tree!) is another issue.

Yours,
Linus Walleij
