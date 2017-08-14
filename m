From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 1/1] i2c: aspeed: add proper support fo 24xx clock params
Date: Sun, 13 Aug 2017 20:52:26 -0700
Message-ID: <CAFd5g470uRHdW_ZgN3MkCW8=ztow7vJobtye5-BBbUN+=R9SUg@mail.gmail.com>
References: <20170728204558.6455-1-brendanhiggins@google.com>
 <20170728204558.6455-2-brendanhiggins@google.com> <CAPLgG==69mNpqoqKUf-0tT4iJJ5-aCg+1uaAoLJ5QSe+8LGYkw@mail.gmail.com>
 <CAPLgG=kUxfriYRq-fc+AD=eo1T+6xa4imzda7Fd_aXmAb2pD3Q@mail.gmail.com>
 <CAFd5g45O7rJymFgnWj3SnSKhCvXoX4_xCO8FqeBFCe0-Du9AYg@mail.gmail.com> <20170812113013.2ajkurbj7ongg5cq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170812113013.2ajkurbj7ongg5cq@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rick Altherr <raltherr@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Robi Buranyi <rburanyi@google.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 12, 2017 at 4:30 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> That being said, I could implement this as a custom clock subclass, which
>> would probably be cleaner that what I have done.
>
> Shall I wait for that one or do you want this patch to be included?
> I don't mind, your call here...
>

Let's go ahead with this patch. I do not have too much experience with the
clock stuff, so I imagine that will probably take some back and forth.

Thanks!
