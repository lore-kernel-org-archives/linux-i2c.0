From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 12:05:18 +0200
Message-ID: <20180720120518.445b947b@bbrezillon>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
        <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian
List-Id: linux-i2c@vger.kernel.org

On Fri, 20 Jul 2018 11:57:56 +0200
Peter Rosin <peda@axentia.se> wrote:

> 
> Maybe a bit-bang I3C master isn't feasible for some fundamental
> reason?

No, it's clearly not. The way an I3C master is supposed to switch from
open-drain to push-pull during a transaction or the concept of IBIs
are the first things that come to mind, but I guess you have plenty of
other reasons preventing you from implementing a i3c-bit-bang master.
