From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Thu, 17 Aug 2017 11:28:45 +0200
Message-ID: <20170817112845.6f7ade8b@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <CACRpkdZm7rrw3PQa9Q2U8N-FopdQJTfdM4uMM9VaatTRfypE1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZm7rrw3PQa9Q2U8N-FopdQJTfdM4uMM9VaatTRfypE1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.>
List-Id: linux-i2c@vger.kernel.org

Le Thu, 17 Aug 2017 11:03:10 +0200,
Linus Walleij <linus.walleij@linaro.org> a écrit :

> On Mon, Jul 31, 2017 at 6:24 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> 
> > This infrastructure is not complete yet and will be extended over
> > time.  
> 
> I noticed the lack of pm_* from the core.
> 
> This will be noticed very quickly since the means the problem seen
> in e.g. commit 04f59143b571 and the wakeup IRQ business will make it
> impossible to do power-efficient drivers until that is resolved.
> 
> It'd be nice to have it to PM right from the start, and the I2C core has
> all the right infrastructure in place, so when this stabilize I'd say
> atleast it'd be *nice* if the PM business was added in the same
> kernel release that introduce this core infrastructure, even if it will
> be a separate patch.
> 
> I.e. I consider that more of necessary bread and butter and less of
> nice to have topping on the cake.
> 
> What I have seen that leaf vendors doing (i3c) device drivers do
> otherwise is complain "it is broken" and then they start to hack
> around it instead of helping out with the core. (I think you're
> well aware of that phenomenon.)

Noted. I'll try to provide core infrastructure for PM in my v2, but it's
kind of hard to design something when you don't have real devices. I
guess I can mimic I2C for now and make it evolve based on users needs.

Regards,

Boris
