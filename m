From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 11/11] dt-bindings: gpio: Add bindings for Cadence
 I3C gpio expander
Date: Mon, 26 Mar 2018 13:25:26 +0200
Message-ID: <20180326132526.1634946e@bbrezillon>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
        <20180323110020.19080-12-boris.brezillon@bootlin.com>
        <CAMuHMdX3TLmaN14gM4fTgzXwy1dgsMxCFBs_3wCFWM8rX=+8vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX3TLmaN14gM4fTgzXwy1dgsMxCFBs_3wCFWM8rX=+8vA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian
List-Id: linux-i2c@vger.kernel.org

On Mon, 26 Mar 2018 12:12:54 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Document the Cadence I3C gpio expander bindings.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt  
> 
> > +- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
> > +  The second cell bits[3:0] is used to specify trigger type and level flags:
> > +      1 = low-to-high edge triggered.
> > +      2 = high-to-low edge triggered.
> > +      3 = triggered on both edges.
> > +      4 = active high level-sensitive.
> > +      8 = active low level-sensitive.  
> 
> These are identical to the values in <dt-bindings/interrupt-controller/irq.h>.
> Perhaps you can refer to those definitions?

Well, I'm not sure this is allowed since DT bindings docs are
supposed to be OS-agnostic and macros defined in
<dt-bindings/interrupt-controller/irq.h> are, AFAIK, only available to
Linux.

Note that I copied these definitions from another binding ;-).

Rob, any opinion?


-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
