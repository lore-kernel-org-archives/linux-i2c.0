From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date: Thu, 6 Sep 2018 14:59:46 +0200
Message-ID: <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com> <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon> <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon> <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon> <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com> <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com> <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Przemyslaw Gaj <pgaj@cadence.com>
Cc: Vitor Soares <Vitor.Soares@synopsys.com>, Boris Brezillon <boris.brezillon@bootlin.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.c>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 6, 2018 at 2:43 PM Przemyslaw Gaj <pgaj@cadence.com> wrote:
>
> Hi Boris, Vitor,
>
> This repository does not contain full kernel sources, but it should be enough to discuss mastership request feature.
> https://github.com/przemekgaj/i3c-linux/commit/d54fe68a9d3e573c0c454a2c6f1afafc20142ec5
>
> Please keep in mind that this is initial version, but mastership works correctly. I added one property to DT to reflect relationship between masters.
> It is possible to request mastership on demand (using sysfs. Useful in case when Linux machine is equipped only with secondary master controller) or automatically change operation mode when device driver wants to read/write something from/to device.
>
> I'm sure I will have to rework something because this was implemented on sources from PATCH v4. I saw that Boris released v7 yesterday :)


Can you explain the reason for having a user space interface and DT property?
I thought we had concluded earlier that we wouldn't need that, but it's possible
that I missed something in the discussion since then.

      Arnd
