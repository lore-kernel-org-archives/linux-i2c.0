From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 02/10] docs: driver-api: Add I3C documentation
Date: Wed, 27 Jun 2018 09:20:36 +0200
Message-ID: <20180627092036.605dbf12@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-3-boris.brezillon@bootlin.com>
        <4898e391-f954-a399-0bca-7588942280b9@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4898e391-f954-a399-0bca-7588942280b9@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion>
List-Id: linux-i2c@vger.kernel.org

Hi Randy,

On Tue, 26 Jun 2018 14:07:49 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:


> > +
> > +I3C Private SDR transfers
> > +-------------------------
> > +
> > +Private SDR (Single Data Rate) transfers should be used for anything that is
> > +device specific and does not require high transfer speed.
> > +
> > +It is the equivalent of I2C transfers but in the I3C world. Each transfer is
> > +passed the device address (dynamic address assigned during DAA), a payload
> > +and a direction.
> > +
> > +The only difference with I2C is that the transfer is much faster (typical SCL  
> 
> what is SCL?  It's not used anywhere else in this doc.

It's an acronym used by I²C, it means Serial Clock Line. I'll just
replace that by "typical clock frequency is 12.5MHz".

> 
> > +frequency is 12.5MHz).
> > +
> > +I3C HDR commands
> > +----------------
> > +
> > +HDR commands should be used for anything that is device specific and requires
> > +high transfer speed.
> > +
> > +The first thing attached to an HDR command is the HDR mode. There are currently
> > +3 different modes defined by the I3C specification (refer to the specification
> > +for more details):
> > +
> > +* HDR-DDR: Double Data Rate mode
> > +* HDR-TSP: Ternary Symbol Pure. Only usable on busses with no I2C devices
> > +* HDR-TSL: Ternary Symbol Legacy. Usable on busses with I2C devices
> > +
> > +When sending an HDR command, the whole bus has to enter HDR mode, which is done
> > +using a broadcast CCC command.
> > +Once the bus has entered a specific HDR mode, the master sends the HDR command.
> > +An HDR command is made of:
> > +
> > +* one 16-bits command word
> > +* N 16-bits data words  
> 
> I supposed the I3C spec will tell me the byte order of these words on the bus?
> or this doc could tell us here.

It's big endian. I'll make it clear in this doc.

I'll also fix all the other mistakes you pointed out.

> 
> and you can add (if you want to):
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I'll definitely add your R-b. Thanks for the review.

Boris
