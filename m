From: vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date: Tue, 28 Aug 2018 12:50:12 +0100
Message-ID: <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824201600.7d80bca9@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, vitor <Vitor.Soares@synopsys.com>
Cc: linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
List-Id: linux-i2c@vger.kernel.org

Hi Boris,

The DT Bindings say "The node describing an I3C bus should be named 
i3c-master.". Do you have a field for secondary master?

On 24-08-2018 19:16, Boris Brezillon wrote:
> Well, before even considering supporting secondary master registration,
> we need to handle mastership handover. As for the DAA operation, it's
> likely to be host specific, so we'll have to add a new hook to the
> i3c_master_controller_ops struct.
Do you mean when master try to delegate the bus ownership through 
GETACCMST? or to get the bus ownership with IBI-MR?

I think that could be useful to pass the ibi type on request_ibi(), 
there is some case where the master doesn't support IBI-MR.

> Once you've done that, we'll have trigger a mastership handover
> everytime an I3C driver tries to send a frame on the bus, and the
> master this frame should do through is not in control of the bus. That
> should be pretty easy for the nominal case, but error cases are likely
> to be hard to deal with.
> Note that I have a ->cur_master field in the i3c_bus object which
> stores allows us to track whose the currently active master. If
> master->this != master->bus->cur_master that means you need to start a
> mastership handover procedure.
>
> That's all I thought about for now, and we'll probably face other
> problems when implementing it. Let me know if you have other questions,
> and don't hesitate to share your code early during the development
> phase.
>
> Also note that the bus representation is likely to change based on
> Arnd's feedback, so you might have to rework your implementation a bit
> at some point.
>
> Regards,
>
> Boris

Best regards,
Vitor Soares
