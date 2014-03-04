From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] i2c: Add driver for Cadence I2C controller
Date: Tue, 4 Mar 2014 09:20:17 -0800
Message-ID: <a6082008-e1c8-45cd-9bd0-6727dd087633@TX2EHSMHS041.ehs.local>
References: <1393632046-20062-1-git-send-email-soren.brinkmann@xilinx.com>
 <8af0e222-6337-4ec4-b718-099a9decc5ec@TX2EHSMHS034.ehs.local>
 <20140304170401.GA18529@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140304170401.GA18529@joshc.qualcomm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Harini Katakam <harinik@xilinx.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Josh,

On Tue, 2014-03-04 at 11:04AM -0600, Josh Cartwright wrote:
> On Fri, Feb 28, 2014 at 07:06:29PM -0800, S?ren Brinkmann wrote:
> > On Fri, 2014-02-28 at 04:00PM -0800, Soren Brinkmann wrote:
> > > Add a driver for the Cadence I2C controller. This controller is f=
or
> > > example found in Xilinx Zynq.
> > >=20
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > ---
> > >  .../devicetree/bindings/i2c/i2c-cadence.txt        |  21 +
> > >  MAINTAINERS                                        |   1 +
> > >  drivers/i2c/busses/Kconfig                         |   7 +
> > >  drivers/i2c/busses/Makefile                        |   1 +
> > >  drivers/i2c/busses/i2c-cadence.c                   | 901 +++++++=
++++++++++++++
> > >  5 files changed, 931 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cad=
ence.txt
> > >  create mode 100644 drivers/i2c/busses/i2c-cadence.c
> > >=20
> > [...]
> > > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kcon=
fig
> > > index f5ed03164d86..7806c1654068 100644
> > > --- a/drivers/i2c/busses/Kconfig
> > > +++ b/drivers/i2c/busses/Kconfig
> > > @@ -375,6 +375,13 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> > >  	help
> > >  	  The unit of the TWI clock is kHz.
> > > =20
> > > +config I2C_CADENCE
> > > +	tristate "Cadence I2C Controller"
> > > +	depends on ARCH_ZYNQ
> > This can be reduced to a dependency on COMMON_CLK only, I think.
>=20
> Do you really need to depend on COMMON_CLK?  Most of the clk_* API's =
are
> properly stubbed when !HAVE_CLK.
I do. clk_register_notifier() is only available with COMMON_CLK.
Alternatively those #ifdefs could go into the driver, but that wouldn't
look nice :)

There is v2 on the list already, let's move the discussion there.

	S=C3=B6ren


