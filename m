From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 12:39:37 +0200
Message-ID: <1a2b7588-9c2e-a25c-6bae-5c8c8675667e@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720120518.445b947b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720120518.445b947b@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian
List-Id: linux-i2c@vger.kernel.org

On 2018-07-20 12:05, Boris Brezillon wrote:
> On Fri, 20 Jul 2018 11:57:56 +0200 Peter Rosin <peda@axentia.se> wrote:
>> Maybe a bit-bang I3C master isn't feasible for some fundamental
>> reason?
> 
> No, it's clearly not. The way an I3C master is supposed to switch from
> open-drain to push-pull during a transaction or the concept of IBIs
> are the first things that come to mind, but I guess you have plenty of
> other reasons preventing you from implementing a i3c-bit-bang master.

Why can't a bit-banger switch from open-drain to push-pull? That's just
a matter of disconnecting some pull-ups, no? And maybe you know that no
device on your bus uses IBIs? Maybe none of reasons for why bit-banging
isn't feasible are applicable?

I.e. maybe there can be a I3C bit-banger that perhaps isn't generic and
isn't full-featured, but does work just fine in some specific setup?

Cheers,
Peter
