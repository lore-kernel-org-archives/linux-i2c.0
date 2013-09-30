From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] driver core: introduce helper macro initcall_driver()
Date: Mon, 30 Sep 2013 22:23:14 +0800
Message-ID: <52498952.9040604@linaro.org>
References: <1380518035-5319-1-git-send-email-hanjun.guo@linaro.org> <1380518035-5319-2-git-send-email-hanjun.guo@linaro.org> <20130930091622.GW19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130930091622.GW19304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fabio Porcedda <fabio.porcedda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2013=E5=B9=B409=E6=9C=8830=E6=97=A5 17:16, Mark Brown wrote:
> On Mon, Sep 30, 2013 at 01:13:52PM +0800, Hanjun Guo wrote:
>> For some devices especially on platform/I2C/SPI bus, they want to
>> be initialized earlier than other devices, so the driver use initcal=
l
>> such as subsys_initcall to make this device initialize earlier.
> We're trying to move away from needing to do this and to using deferr=
ed
> probing to resolve init ordering issues.  Should we not be able to
> convert the drivers to module_X_driver()?
Hi Mark,

Thanks for your comments.

That would be great to move away *_initcall in module driver, and
this patch set is not necessary if we can use deferred probe to solve
all the init order issues.

Thanks
Hanjun
