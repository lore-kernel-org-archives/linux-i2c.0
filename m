From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date: Thu, 6 Sep 2018 15:45:41 +0200
Message-ID: <CAK8P3a1dgw5_54rdE6Emsii93VuT8msA4z79C-iCCxCZihuFJw@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com> <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon> <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon> <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon> <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com> <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com> <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
 <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
 <20180906151437.4259d6fc@bbrezillon> <20180906152055.5618d235@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906152055.5618d235@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Przemyslaw Gaj <pgaj@cadence.com>, Vitor Soares <Vitor.Soares@synopsys.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 6, 2018 at 3:21 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Thu, 6 Sep 2018 15:14:37 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> > When a master is not in control of the bus, it gets informed of devices
> > present on the bus by monitoring DAA or DEFSLVS broadcast events. That
> > means the secondary master should populate the bus with I3C/I2C devices
> > on such events, but that's not enough, because DEFSLVS/DAA do not
> > provide all device info. Some of them (like read/write/ibi limitations)
> > require extra CCC commands, and, to send those CCC commands, the
> > secondary master must claim the bus. We could add a case where we
> > declare devices as partially discovered until the master acquires
> > ownership of the bus, but that means part of the data returned by
> > i3c_device_get_info() will be inaccurate, which might have an impact on
> > some i3c driver ->probe() functions.
>
> Hm, one possible solution would be to register partially discovered
> devices to the device model and let i3c_device_get_info() claim the bus
> and request missing data when needed. This way, if the driver needs to
> call i3c_device_get_info() in its probe path, it should work just fine.

I guess you could also call i3c_device_get_info() in the common i3c_probe()
function before calling into the driver.

However, either way, we may still have a problem here: if the current master
decides not to hand over master access to us at all, the probe() function
will be blocked indefinitely, and that may stop us from probing other devices
later on, or hang the module loader (depending on what context that
probe() is called from).

Using a timeout here could avoid the hang, but leads to other potential
issues, e.g. how to decide whether to retry the probe later.

       Arnd
