From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
Date: Wed, 27 Jun 2018 17:50:38 -0700
Message-ID: <f5e65551fea695b533eb275bdbcf43204d515d58.camel@perches.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
         <20180622104930.32050-10-boris.brezillon@bootlin.com>
         <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
         <20180626215648.1472b96e@bbrezillon>
         <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
         <20180626234638.076fb816@bbrezillon>
         <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
         <20180627213617.51e10712@bbrezillon>
         <8bf36e4025b6ec5198a668edda6bcbef3b06e97b.camel@perches.com>
         <CAHp75Vd5ucaeOD4S76ANcOVUA=QrCpGNAmun6+ihnsOTsgtcKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd5ucaeOD4S76ANcOVUA=QrCpGNAmun6+ihnsOTsgtcKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2018-06-28 at 03:00 +0300, Andy Shevchenko wrote:
> bitmap operations are working against unsigned long *. one long is
> also a bitmap.

Should only be so if declared via DECLARE_BITMAP

> So, that coccinelle scripts must be fixed accordingly.

We disagree about a non-existent script.
