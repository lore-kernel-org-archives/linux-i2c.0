From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 3/4] gpiolib: add irq_not_threaded flag to gpio_chip
Date: Thu, 23 Oct 2014 14:10:19 +0900
Message-ID: <CAAVeFuKcteLaNp6C3EuSmGxpb_8aGYXw4FYjFqXXH2St5mbZDA@mail.gmail.com>
References: <1413384491-23703-1-git-send-email-octavian.purdila@intel.com>
 <1413384491-23703-4-git-send-email-octavian.purdila@intel.com>
 <CAAVeFuJ4B37YgvTBctXqmtWJtg3b19PDt1EEZF5Rc6KVXZzUtw@mail.gmail.com> <CAE1zot+FL54r3a6-qJwDti3D2dGCSwN=a0g0ki28cy1ToXgSfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAE1zot+FL54r3a6-qJwDti3D2dGCSwN=a0g0ki28cy1ToXgSfg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 20, 2014 at 7:19 PM, Octavian Purdila
<octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Oct 20, 2014 at 8:08 AM, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> On Wed, Oct 15, 2014 at 11:48 PM, Octavian Purdila
>> <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> > Some GPIO chips (e.g. the DLN2 USB adapter) have blocking get/set
>> > operation but do not need a threaded irq handler.
>>
>> Sorry if you already explained this (I have been a little bit late
>> with the GPIO reviews recently), but does this optimization bring a
>> significant benefit that justifies adding another field in struct
>> gpio_chip? If so it would be nice to have it in the commit message. If
>> not, do we need this at all?
>
> Hi Alexandre,
>
> In the case DLN2 USB GPIO adapter the GPIO interrupt is generated in
> the completion routine of a receive URB, which means that we are in
> interrupt context. If a threaded irq is used, we would have to
> schedule work instead of running to interrupt handler directly which
> is unnecessary and adds latency.
>
> BTW, AFAIC Linus W already merged this patch in his next tree, I am
> keeping it in this series because it was not pulled in the mfd-next
> tree.

You're right, it's all good then. Thanks for the explanation.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
