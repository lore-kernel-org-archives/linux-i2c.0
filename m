From: vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date: Mon, 3 Sep 2018 10:33:11 +0100
Message-ID: <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
 <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Przemyslaw Gaj <pgaj@cadence.com>, vitor <Vitor.Soares@synopsys.com>, Boris Brezillon <boris.brezillon@bootlin.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@>
List-Id: linux-i2c@vger.kernel.org

Hi Przemek,


On 30-08-2018 20:00, Przemyslaw Gaj wrote:
>      So, per my understanding since the Main master support the hand-off of
>      the bus you accept all incoming MR, right? Or do you check all devices BCR?
>
> I'm not sure what do you mean here. Mastership request(MR) is from secondary master
> to current master. Current master can NACK this request if for example it comes from
> wrong device. If it's ok, current master sends GETACCMST command and secondary master
> may ACK or NACK this command. It it's acked, secondary master becomes current master.
>      
>      Best regards,
>      Vitor Soares
>
> Please let me know if something is unclear.
>
> Regards,
> Przemek
>      

Sorry, it s not clear yet.

For instances there is a bus with several secondary master. If each of 
them request the bus mastership (one at a time), will you accept all by 
default? Because you can only accept only some of them.

Regards,
Vitor Soares
