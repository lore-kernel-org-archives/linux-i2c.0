From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
Date: Tue, 26 Jun 2018 19:38:24 +0300
Message-ID: <94677b02051f8d2ad2e3c16d690442134b693cf8.camel@linux.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
         <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
         <CAMRc=Me511S4Qw_-SPNkpPXcby7rZApbgm9g2=W=irmy9Gsu3g@mail.gmail.com>
         <3a07d0d9fbe7178bbe9efa99fcb331df213a461f.camel@linux.intel.com>
         <CAMRc=MdvW_k3ZgrZAffD45r_zxOMWCyXoDx-YgXMQ2=-tSjyGw@mail.gmail.com>
         <94f847b50030a10c9dabd907a35c16a9f43e5af4.camel@linux.intel.com>
         <8E0971CCB6EA9D41AF58191A2D3978B61D6D9A20@PGSMSX111.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8E0971CCB6EA9D41AF58191A2D3978B61D6D9A20@PGSMSX111.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yeh, Andy" <andy.yeh@intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Chiang, AlanX" <alanx.chiang@intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-06-26 at 16:21 +0000, Yeh, Andy wrote:

> > > Ok makes sense in that case. Could you just point me towards an
> > > example model which has the address width different than the
> > > default
> > > for its type?
> > 
> > AFAIK, it's a companion device inside the camera voice coil IC, i.e.
> > DONGWOON DW9714.
> > 
> 
> Nope, actually it is DW9807 instead, which is used on a Samsung
> Chromebook.

Ah, okay, good to know.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
