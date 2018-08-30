From: vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date: Thu, 30 Aug 2018 14:57:36 +0100
Message-ID: <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Przemyslaw Gaj <pgaj@cadence.com>, Boris Brezillon <boris.brezillon@bootlin.com>, vitor <Vitor.Soares@synopsys.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@>
List-Id: linux-i2c@vger.kernel.org

Hi Przemyslaw


On 28-08-2018 13:55, Przemyslaw Gaj wrote:
> Hi Vitor,
>
> I have already implemented Mastership request/handover but we are waiting for Boris’s patch to be accepted and merged. Anyway, my comments below.
>
> ﻿On 8/28/18, 2:02 PM, "Boris Brezillon" <boris.brezillon@bootlin.com> wrote:
>
>      EXTERNAL MAIL
>      
>      
>      Hi Vitor,
>      
>      On Tue, 28 Aug 2018 12:50:12 +0100
>      vitor <Vitor.Soares@synopsys.com> wrote:
>      
>      > Hi Boris,
>      >
>      > The DT Bindings say "The node describing an I3C bus should be named
>      > i3c-master.". Do you have a field for secondary master?
>
> I think we don’t need separate field for secondary master. Main and secondary masters
> support similar functionalities. It’s enough to have this state internally and do mastership it it's needed.

Yes, you are right.

>
>      >
>      > On 24-08-2018 19:16, Boris Brezillon wrote:
>      > > Well, before even considering supporting secondary master registration,
>      > > we need to handle mastership handover. As for the DAA operation, it's
>      > > likely to be host specific, so we'll have to add a new hook to the
>      > > i3c_master_controller_ops struct.
>      > Do you mean when master try to delegate the bus ownership through
>      > GETACCMST? or to get the bus ownership with IBI-MR?
>      
>      I think we need to support both.
>
> I agree.

That's ok to me.

>      
>      >
>      > I think that could be useful to pass the ibi type on request_ibi(),
>      > there is some case where the master doesn't support IBI-MR.
>      
>      Actually, I was planning on making it completely separate from
>      regular slave IBIs. That is, the master controller driver would demux
>      the slave, MR and Hot Join IBIs, and if there's an MR request, queue a
>      mastership handover work to the workqueue (pretty much what we do for
>      Hot-Join already). Mastership handover is anyway likely to be IP
>      specific, so I don't think there's a need to make it look like a
>      regular IBI.
>
> I think it's better to have separate function to do mastership request.
>      
>      Regarding whether IBI-MR support should be exposed to the I3C framework
>      or not depends on how much will be automated on the framework side. I
>      don't the answer yet, but that's probably something will figure out
>      along the road.
>
> My current implementation is: when request_mastership field
> of i3c_master_controller_ops structure is set, master driver supports mastership requests.
> That's how I check if this is supported or not.
>      
>      Regards,
>      
>      Boris
>      
> Regards,
> Przemek
>
when you say request_mastership, do you mean the current master do the 
mastership hand-off or the secondary master request to be current master?

So, per my understanding since the Main master support the hand-off of 
the bus you accept all incoming MR, right? Or do you check all devices BCR?

Best regards,
Vitor Soares
