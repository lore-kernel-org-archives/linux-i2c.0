From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/13] i2c/i2c-nomadik: use pm_runtime API
Date: Wed, 11 May 2011 14:35:07 +0200
Message-ID: <BANLkTi=bxZn4-ePopBXmNTpfX6dCeMstug@mail.gmail.com>
References: <1304977077-31661-1-git-send-email-linus.walleij@linaro.org>
	<20110510221948.GA634@freya.fluff.org>
	<BANLkTinQn5dQWXM12zUqWp-u1gF0Y-6nEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTinQn5dQWXM12zUqWp-u1gF0Y-6nEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2011/5/11 Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>:
> On Wed, May 11, 2011 at 03:49, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
>> On Mon, May 09, 2011 at 11:37:57PM +0200, Linus Walleij wrote:
>>> + =A0 =A0 /*
>>> + =A0 =A0 =A0* During system suspend, runtime suspend transitions a=
re disabled.
>>> + =A0 =A0 =A0* This check and direct call are here so that even if =
some driver
>>> + =A0 =A0 =A0* performs i2c transactions in its suspend rountine, w=
e would properly
>>> + =A0 =A0 =A0* runtime suspend the i2c driver.
>>> + =A0 =A0 =A0*/
>>> + =A0 =A0 if (!pm_runtime_suspended(dev))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dev->bus && dev->bus->pm && dev->bus-=
>pm->runtime_suspend)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->bus->pm->runtime_sus=
pend(dev);
>>> +
>>
>> surely there must be better way of calling this?
>
> This is not needed and can be removed.
>
>>
>>> + =A0 =A0 return 0;
>>> +}
>>
>>> +static int nmk_i2c_resume(struct device *dev)
>>> +{
>>> + =A0 =A0 if (!pm_runtime_suspended(dev))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dev->bus && dev->bus->pm && dev->bus-=
>pm->runtime_resume)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->bus->pm->runtime_res=
ume(dev);
>>> +
>>> + =A0 =A0 return 0;
>>
>> ditto.
>
> This too.

Cool, I'll cut it out of this patch and rebase the patch set.

Yours,
Linus Walleij
