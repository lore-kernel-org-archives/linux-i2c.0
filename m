From: Peter Rosin <peda@axentia.se>
Subject: Re: Getting at gpio- and pinctrl-devices as a consumer
Date: Fri, 25 Nov 2016 17:19:42 +0100
Message-ID: <fb732c43-19d2-f3fc-52af-7667ec091475@axentia.se>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
 <20161124151420.GF4271@katana>
 <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
 <20161124195230.GA1666@katana>
 <b481ed92-c9d2-b4da-b484-6d8bec6038f0@axentia.se>
 <CACRpkdb0cdvxgnuOBNfdY+idVcTXMwzKRYfCsFpiRx2qaVrt=w@mail.gmail.com>
 <45787444-a237-7363-5f03-0cd207cb82c2@axentia.se>
 <CACRpkdbRiT9ZqG23ewTHBDRdHT=1E2ei1qoLUOGr_jd47MNvog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0112.outbound.protection.outlook.com ([104.47.1.112]:44933
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932254AbcKYQTu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 25 Nov 2016 11:19:50 -0500
In-Reply-To: <CACRpkdbRiT9ZqG23ewTHBDRdHT=1E2ei1qoLUOGr_jd47MNvog@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On 2016-11-25 14:39, Linus Walleij wrote:
> On Fri, Nov 25, 2016 at 10:24 AM, Peter Rosin <peda@axentia.se> wrote:
>> [Me]
>>> struct device *gpiod_get_backing_device(struct gpio_desc *d);
>>>
>>> Is simple but is it really what you want?
>>
>> Well, my first attempt was to simply have a property in the
>> devicetree stating that the mux was controlled from the same
>> i2c bus it was muxing, but that was shot down because it
>> should be possible to deduce this from the implementation (or
>> something of that meaning, it was a while ago), which to me
>> meant examining the "struct device"-tree.
> 
> The problem goes into any subsystem providing resources for
> a mux in this case, generally for example it is not OK for a
> device to runtime suspend or shut down its regulator or turn off
> its clock if it is acting as a mux. GPIO and pin control just happens
> to be two resource in this specific case.

Just to be clear, we are only talking of muxers used to mux an
i2c-bus. But if some other popular bus is muxed the problems would
probably be similar.

If there is any action (that is not aware of the mux) on the muxed
i2c-bus as the result of a i2c-mux-foo driver requesting a change to
update the mux state, this will deadlock. Unless of course the mux
is operated with the more relaxed locking (mux-locked instead of
parent-locked). So yes, if some multi-function chip provides a
gpio pin to some i2c-mux, and if this chip for some reason
triggers some strange action when a gpio change is requested, and
this action in turn triggers a transfer on the muxed i2c-bus, it
will not work as intended (it will deadlock). I.e., there are all
kinds of ways to defeat the current check to determine if
i2c-mux-gpio and i2c-mux-pinctrl need relaxed locking. But none
or them worked in this setting before I introduced the more relaxed
mux-locked mode either, so I do not feel all that bad about it.

And the checks can of course be improved if needed.

>> For the gpio_desc it is easy. However, it is worse for the
>> pinctrl case.
> 
> It is annoying to do this in a sense, because it starts to kill
> the abstraction we have created exactly in order to avoid
> consumers having to worry much about their providers
> internals. No we are opening the can and letting the stuff
> out all over the place.

Sorry about that. If it matters I'd be just as happy to have the
devicetree author declare the situation explicitly for the i2c-mux
driver, and I didn't really try to argue for that. Maybe it can
be argued that the needed little piece of info isn't really all that
specific to the linux implementation?

Let me try:

-----------8<-----------

It is unreasonable to require that the i2c-mux code can determine
if the devices needed to operate the mux needs to use the i2c-bus
that is muxed. This requires domain knowledge of the whole system,
and fingers everywhere. There should not be a design restriction
on the system such that this question must have answer.

Assuming everybody agrees with the above, the question becomes: Is
it required that the i2c-mux code knows if any devices needed to
operate the mux needs to use the i2c-bus that is muxed?

I say yes.

Case one: Normal iomem gpios directly from some SOC are used to
mux an i2c-bus. If the i2c-bus is not locked as these gpios are
updated, you might see half a transfer on one i2c child channel,
and the other half on some other channel. Or worse. This might
wreak havoc among the client devices. I.e. the i2c-mux must in
this case lock the i2c-bus during the gpio update to make sure
nothing bad hits the clients devices.

Case two: A gpio update might need to use the muxed i2c-bus. The
simplest case is if the io-expander used to operate an i2c-mux sits
on the same i2c-bus that it is muxing, but it might be a lot more
complex with a chain of dependencies ending up causing an i2c
transfer (also, the client devices are known to handle broken crap
on the i2c-bus and are not affected by a little bit of garbage).
I.e. the i2c-mux must in this case make sure to not lock the
i2c-bus during the gpio update.

In other words, without a full view of the system, it is not
possible to know if the i2c-bus should or should not be locked
when updating the gpios used to operate a mux on the i2c-bus.

-----------8<-----------

I can take the above argument to the dt list and perhaps win them
over. But that doesn't mean that we can simply remove the code,
since doing so would regress anything depending on the current
behavior of (at least sometimes) automatically finding the i2c
dependency. But maybe the users are few and able to add a dt
property in case it's needed?

And I like code that works without configuration, so I would
prefer it to remain and continue to discover the easy case.

> Have you looked into the discussion about device dependencies
> in general? Isn't this problem mappable as a subset of that?

Haven't seen it before. My understanding of the driver model is
not the best, and the docs are behind which makes it hard to
know what to believe. The discussions generally fly a bit over
my head, I guess I simply need to dig into the code a bit more...

> This was discussed at length at the last kernel summit:
> https://lwn.net/Articles/705852/
> 
> See especially Rafael's commit
> 9ed9895370aedd6032af2a9181c62c394d08223b
> to driver core in linux-next

This looks like it could be useful; given a gpio, look up its
device, then do a deep search of the supplier list and look
for any device sitting on the muxed i2c-bus. But of course
consumers might also get a notifier and react. I think it's
next to impossible to automatically cover all cases...

An that still requires the i2c-mux driver to lookup the backing
device of gpios (or device_s_ for pinctrl-states).

Cheers,
Peter
