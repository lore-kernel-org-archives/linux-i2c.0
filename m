From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Date: Thu, 14 Jun 2018 09:07:58 +0200
Message-ID: <20180614090758.17180594@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <20180614041941.4i2cadzoevujmzha@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614041941.4i2cadzoevujmzha@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <gala>
List-Id: linux-i2c@vger.kernel.org

On Thu, 14 Jun 2018 13:19:42 +0900
Wolfram Sang <wsa@the-dreams.de> wrote:

> Hi Boris,
> 
> > +/**
> > + * struct i3c_priv_xfer - I3C SDR private transfer
> > + * @rnw: encodes the transfer direction. true for a read, false for a write
> > + * @len: transfer length in bytes of the transfer
> > + * @data: input/output buffer
> > + */
> > +struct i3c_priv_xfer {
> > +	bool rnw;
> > +	u16 len;
> > +	union {
> > +		void *in;
> > +		const void *out;
> > +	} data;  
> 
> So, this is probably where most payloads end up?
> 
> I didn't notice any sign of DMA in these patches, but given my
> experiences, DMA will come sooner or later. And in I2C, this was
> problematic because then a lot of drivers were in the wild getting their
> buffers from everywhere (stack!). We now have an opt-in approach to mark
> buffers as DMA-safe.
> 
> I don't know if typical I3C transfers will be similar to I2C with
> usually small payloads where DMA usually makes not much sense. Yet, I
> think, that it might be a good idea to think about how this shall be
> handled with I3C right away. Maybe simply enforcing buffers to be
> DMA-safe. Or whatever.
> 
> A clear rule on that might save you hazzle later.

I completely agree. I'll clarify that and for people to pass DMA-able
buffers to this struct (just as the SPI framework does). Note that we
don't really have a way to ensure that the buffer is actually
DMA-safe from the core, because this notion is architecture/SoC
dependent.

> 
> Regards,
> 
>    Wolfram
> 
