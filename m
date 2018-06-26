From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
Date: Tue, 26 Jun 2018 18:48:05 +0300
Message-ID: <94f847b50030a10c9dabd907a35c16a9f43e5af4.camel@linux.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
         <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
         <CAMRc=Me511S4Qw_-SPNkpPXcby7rZApbgm9g2=W=irmy9Gsu3g@mail.gmail.com>
         <3a07d0d9fbe7178bbe9efa99fcb331df213a461f.camel@linux.intel.com>
         <CAMRc=MdvW_k3ZgrZAffD45r_zxOMWCyXoDx-YgXMQ2=-tSjyGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MdvW_k3ZgrZAffD45r_zxOMWCyXoDx-YgXMQ2=-tSjyGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: alanx.chiang@intel.com, linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com, Sakari Ailus <sakari.ailus@linux.intel.com>, Rajmohan Mani <rajmohan.mani@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-06-26 at 15:30 +0200, Bartosz Golaszewski wrote:
> 2018-06-26 15:23 GMT+02:00 Andy Shevchenko <andriy.shevchenko@linux.in
> tel.com>:
> > On Tue, 2018-06-26 at 14:36 +0200, Bartosz Golaszewski wrote:
> > > 2018-06-26 14:14 GMT+02:00 Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>:
> > > > On Tue, 2018-06-26 at 09:41 +0200, Bartosz Golaszewski wrote:
> > > > > What is your use case exactly? Do you have an EEPROM model
> > > > > that's
> > > > > not
> > > > > yet supported explicitly in the driver? Why would you need
> > > > > this
> > > > > option?
> > > > 
> > > > The current at24 driver has no address width support,
> > > >  thus, reusing same
> > > > (allocated) IDs (non-DT case) is hard.
> > 
> > ^^^^^
> > 
> > > Every supported compatible has the width already specified in its
> > > corresponding chip data.
> > 
> > 
> > Please, read again carefully what I wrote before.
> > 
> 
> Ok makes sense in that case. Could you just point me towards an
> example model which has the address width different than the default
> for its type?

AFAIK, it's a companion device inside the camera voice coil IC, i.e.
DONGWOON DW9714.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
