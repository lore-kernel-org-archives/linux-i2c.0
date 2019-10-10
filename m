From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 2/4] i2c: at91: implement i2c bus recovery
Date: Thu, 10 Oct 2019 08:54:09 +0200
Message-ID: <20191010065408.y7i7aywdztgixv47@M43218.corp.atmel.com>
References: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
 <20191002144658.7718-3-kamel.bouhara@bootlin.com>
 <20191009135500.ufkxcemccwfcfys7@M43218.corp.atmel.com>
 <20191009140145.GE4254@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191009140145.GE4254@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 09, 2019 at 04:01:47PM +0200, Alexandre Belloni wrote:
> 
> On 09/10/2019 15:55:00+0200, Ludovic Desroches wrote:
> > On Wed, Oct 02, 2019 at 04:46:56PM +0200, Kamel Bouhara wrote:
> > > External E-Mail
> > > 
> > > 
> > > Implement i2c bus recovery when slaves devices might hold SDA low.
> > > In this case re-assign SCL/SDA to gpios and issue 9 dummy clock pulses
> > > until the slave release SDA.
> > > 
> > 
> > Hi Kamel,
> > 
> > Thanks for adding this new feature. As I see patches only for sama5d3 and
> > sama5d4, I assume it has not been tested with a sama5d2, isn't it?
> > 
> 
> I there a point having it on sama5d2 as the controller already supports
> this feature?
> 

Right, I was focused on pinctrl and forget we have this feature
supported by the IP.

> > I doubt it works with a sama5d2 because of the pinctrl. I also wonder if it can
> > work if we add .strict = true to pinmux_ops which is something plan for the
> > future...
> > 
> 
> I don't see why it wouldn't work with strict as this is switching muxing
> properly instead of using the pins for two functions at the same time.
> 

Not sure devm_gpiod_get won't fail with strict.

Ludovic
