From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Getting at gpio- and pinctrl-devices as a consumer
Date: Fri, 25 Nov 2016 14:39:14 +0100
Message-ID: <CACRpkdbRiT9ZqG23ewTHBDRdHT=1E2ei1qoLUOGr_jd47MNvog@mail.gmail.com>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
 <20161124151420.GF4271@katana> <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
 <20161124195230.GA1666@katana> <b481ed92-c9d2-b4da-b484-6d8bec6038f0@axentia.se>
 <CACRpkdb0cdvxgnuOBNfdY+idVcTXMwzKRYfCsFpiRx2qaVrt=w@mail.gmail.com> <45787444-a237-7363-5f03-0cd207cb82c2@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <45787444-a237-7363-5f03-0cd207cb82c2@axentia.se>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 25, 2016 at 10:24 AM, Peter Rosin <peda@axentia.se> wrote:
>[Me]
>> struct device *gpiod_get_backing_device(struct gpio_desc *d);
>>
>> Is simple but is it really what you want?
>
> Well, my first attempt was to simply have a property in the
> devicetree stating that the mux was controlled from the same
> i2c bus it was muxing, but that was shot down because it
> should be possible to deduce this from the implementation (or
> something of that meaning, it was a while ago), which to me
> meant examining the "struct device"-tree.

The problem goes into any subsystem providing resources for
a mux in this case, generally for example it is not OK for a
device to runtime suspend or shut down its regulator or turn off
its clock if it is acting as a mux. GPIO and pin control just happens
to be two resource in this specific case.

> For the gpio_desc it is easy. However, it is worse for the
> pinctrl case.

It is annoying to do this in a sense, because it starts to kill
the abstraction we have created exactly in order to avoid
consumers having to worry much about their providers
internals. No we are opening the can and letting the stuff
out all over the place.

Have you looked into the discussion about device dependencies
in general? Isn't this problem mappable as a subset of that?
This was discussed at length at the last kernel summit:
https://lwn.net/Articles/705852/

See especially Rafael's commit
9ed9895370aedd6032af2a9181c62c394d08223b
to driver core in linux-next

Yours,
Linus Walleij
