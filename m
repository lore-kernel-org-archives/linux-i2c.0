From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
Date: Thu, 28 Jun 2018 03:00:58 +0300
Message-ID: <CAHp75Vd5ucaeOD4S76ANcOVUA=QrCpGNAmun6+ihnsOTsgtcKg@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com> <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
 <20180626215648.1472b96e@bbrezillon> <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
 <20180626234638.076fb816@bbrezillon> <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
 <20180627213617.51e10712@bbrezillon> <8bf36e4025b6ec5198a668edda6bcbef3b06e97b.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8bf36e4025b6ec5198a668edda6bcbef3b06e97b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 28, 2018 at 1:54 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-06-27 at 21:36 +0200, Boris Brezillon wrote:
>> I mean, kzalloc() is not deprecated AFAIK and I don't really see the
>> benefit of using kmalloc_array(), but if that makes you happy, let's go
>> for kmalloc_array().
>
> kcalloc

IIRC in the original code kmalloc(x*y) is used.

>> I do run checkpatch --strict and fix most of the thing reported except
>> those hurting readability. I don't remember seeing checkpatch complain
>> about kzalloc() usage, and I guess it's not smart enough to detect that
>> for_each_bit_set() can be used to replace the "for() if (BIT(x) & val)"
>> pattern.
>
> That would not an appropriate conversion suggestion in any case.
> coccinelle could at least look at whether or not x is allocated
> as a bitmap via DECLARE_BITMAP or bitmap_alloc

Huh?!

bitmap operations are working against unsigned long *. one long is
also a bitmap.
So, that coccinelle scripts must be fixed accordingly.

-- 
With Best Regards,
Andy Shevchenko
