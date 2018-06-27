From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: at24: Add address-width property
Date: Wed, 27 Jun 2018 12:40:13 +0300
Message-ID: <20180627094013.e42crqqufo2jqra6@paasikivi.fi.intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
 <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
 <CAMRc=MeowpZ+OjjWs6-67BOnY=+Nbpn4Bi_Xw3n+NLsELZaptQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MeowpZ+OjjWs6-67BOnY=+Nbpn4Bi_Xw3n+NLsELZaptQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: alanx.chiang@intel.com, linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, andriy.shevchenko@intel.com, Rajmohan Mani <rajmohan.mani@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, tfiga@chromium.org, jcliang@chromium.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 27, 2018 at 10:19:38AM +0200, Bartosz Golaszewski wrote:
> 2018-06-27 7:46 GMT+02:00  <alanx.chiang@intel.com>:
> > From: Alan Chiang <alanx.chiang@intel.com>
> >
> > The AT24 series chips use 8-bit address by default. If some
> > chips would like to support more than 8 bits, the at24 driver
> > should be added the compatible field for specfic chips.
> >
> > Provide a flexible way to determine the addressing bits through
> > address-width in this patch.
> >
> > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> >
> > ---
> > since v1:
> > -- Remove the address-width field in the example.
> > since v2:
> > -- Remove redundant space.
> >
> > ---
> >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> > index 61d833a..aededdb 100644
> > --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> > +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> > @@ -72,6 +72,8 @@ Optional properties:
> >
> >    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
> >
> > +  - address-width: number of address bits (one of 8, 16).
> > +
> >  Example:
> >
> >  eeprom@52 {
> > --
> > 2.7.4
> >
> 
> Rob,
> 
> we only have two possibilities here and the default is 8 bits.
> 
> What do you think about introducing a boolean property here called:
> 'address-width-16' instead of an integer?

I'd have thought the same, but it turns out address-width is already being
used by the at25 bindings:

Documentation/devicetree/bindings/eeprom/at25.txt

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
