From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
 property
Date: Thu, 5 Jul 2018 16:24:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com> <1530522740-2798-2-git-send-email-alanx.chiang@intel.com> <20180705212204.GA10449@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705212204.GA10449@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: alanx.chiang@intel.com, linux-i2c@vger.kernel.org, andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 5 Jul 2018, Rob Herring wrote:

> On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
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
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > ---
> > since v1:
> > -- Remove the address-width field in the example.
> > since v2:
> > -- Remove redundant space.
> > since v3:
> > -- Add Acked-by.
> >
> > ---
> >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

  "... should be added the compatible field ..."??

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
