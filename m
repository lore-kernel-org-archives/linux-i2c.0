From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
Date: Fri, 22 Jun 2018 20:35:17 +0200
Message-ID: <20180622203517.1665030f@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-10-boris.brezillon@bootlin.com>
        <27aae5b0-f8eb-bed7-9d14-5c739769977a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27aae5b0-f8eb-bed7-9d14-5c739769977a@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion>
List-Id: linux-i2c@vger.kernel.org

On Fri, 22 Jun 2018 09:04:47 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 06/22/2018 03:49 AM, Boris Brezillon wrote:
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 71c0ab46f216..19ed6006aea1 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -898,6 +898,17 @@ config GPIO_TS4900
> >  
> >  endmenu
> >  
> > +menu "I3C GPIO expanders"
> > +	depends on I3C
> > +
> > +config GPIO_CDNS_I3C
> > +	tristate "Cadence I3C GPIO expander"
> > +	select GPIOLIB_IRQCHIP
> > +	help
> > +	  Say yes here to enabled the driver for Cadence I3C GPIO expander.  
> 
> 	               to enable the driver

I'll fix this typo

Thanks,

Boris
