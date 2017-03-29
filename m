From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v6 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed
Date: Wed, 29 Mar 2017 13:16:08 -0700
Message-ID: <CAFd5g4435JY72nk7xHa4KohvaGqK2UYOB4XLD3EajGCbgEzPFQ@mail.gmail.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-3-brendanhiggins@google.com> <CACPK8XdYNi2mna=aBbYvMroujLOPbVkPdU-DeYGrevjRBjHodQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XdYNi2mna=aBbYvMroujLOPbVkPdU-DeYGrevjRBjHodQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-i2c@vger.kernel.org

> Nit: Make this aspeed-i2c-domain to make this consistent with the
> other Aspeed drivers in the kernel tree.
>
> Could this irq code be embedded in the i2c driver? We took a similar
> approach for the Aspeed GPIO driver, which has a similar IRQ structure
> of one hardware IRQ that tells the driver to check status registers
> for the precise irq source. The upside being all of the i2c code is in
> the same place in the kernel tree.

In the previous version of the patch, this code was embedded in the
I2C driver as the "struct aspeed_i2c_controller;" I really did not
change anything about it other than rename some stuff and change the
init method to match what irqchip code wants. I pulled it out into a
separate driver because I was asked to by Vladimir; nevertheless, it
does turn the I2C driver into a normal platforms driver, which is
nice. Another benefit: if we put our dummy irqchip code in with the
other irqchips, it makes it easier for the irqchip people to recognize
when we are reusing the same patterns; for example, I would not at all
be surprised if there are other dummy irqchips which have the same
exact map(...) operation (I looked and did not see anything), but it
is quite possibly something that other people want to do. If we put
this stuff in drivers/irqchip, it is more likely that the irqchip
people would recognize this as a common use case. I do not think
either of these reasons I provided are particularly compelling, but I
do not think the reasons to move it out are particularly compelling
either (unless we decide we do not want make our own irq_domain).

Cheers
