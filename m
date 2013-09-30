From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] driver core: introduce helper macro initcall_driver()
Date: Mon, 30 Sep 2013 22:28:14 +0800
Message-ID: <52498A7E.8080606@linaro.org>
References: <1380518035-5319-1-git-send-email-hanjun.guo@linaro.org> <1380518035-5319-2-git-send-email-hanjun.guo@linaro.org> <20130930101500.GA3222@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130930101500.GA3222@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fabio Porcedda <fabio.porcedda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2013=E5=B9=B409=E6=9C=8830=E6=97=A5 18:15, Wolfram Sang wrote:
> On Mon, Sep 30, 2013 at 01:13:52PM +0800, Hanjun Guo wrote:
>> For some devices especially on platform/I2C/SPI bus, they want to
>> be initialized earlier than other devices, so the driver use initcal=
l
>> such as subsys_initcall to make this device initialize earlier.
> And this is something we want to get rid of in favor of deferred
> probing.
>
>> But for those drivers, lots of them just do nothing special in
>> xxx_initcall/exit, so introduce a helper macro initcall_driver() to
>> eliminate lots of boilerplate just like module_driver() did.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> So, NACK because using some *_initcall in drivers should not be
> encouraged.

Ok, got it. I agree with you, *_initcall in module driver is really
confusing people :)

Thanks
Hanjun
>
> Thanks,
>
>     Wolfram
>
