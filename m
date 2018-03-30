From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 04/10] dt-bindings: i3c: Document core bindings
Date: Fri, 30 Mar 2018 09:59:02 +0200
Message-ID: <20180330095902.00f75106@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-5-boris.brezillon@bootlin.com>
        <CAMuHMdW-MhzaW-bWL25Y+--UHxLB+Mm5+SmhwA+PiezUEg0Ycw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdW-MhzaW-bWL25Y+--UHxLB+Mm5+SmhwA+PiezUEg0Ycw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ij>
List-Id: linux-i2c@vger.kernel.org

On Fri, 30 Mar 2018 09:55:22 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Fri, Mar 30, 2018 at 9:47 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > A new I3C subsystem has been added and a generic description has been
> > created to represent the I3C bus and the devices connected on it.
> >
> > Document this generic representation.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> > Changes in v4:
> > - Clarify the fact that static address == I3C address and dynamic  
> 
> static address == I2C address?

hehe, indeed.

> 
> >   address == I3C address  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
