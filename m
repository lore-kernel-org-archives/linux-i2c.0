From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] i2c: cadence: Handle transfer_size rollover
Date: Thu, 28 Nov 2019 17:24:32 +0530
Message-ID: <CAKfKVtE8zaQhcYCOSjO26u9MjTJhLDO_R_L2Nca7_EbzBz8DEg@mail.gmail.com>
References: <20190131213957.11568-1-alex.williams@ettus.com>
 <CAKfKVtFM1zPb-MjBwY8WREy4xoHW60JrjZ-LnSzBvJ1Yv_zgsw@mail.gmail.com> <CAJZzcDiv8BGDa8pj-2gP+BWiu=CfrsDi15xHr=UUFwCwE-E4zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZzcDiv8BGDa8pj-2gP+BWiu=CfrsDi15xHr=UUFwCwE-E4zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williams <alex.williams@ettus.com>
Cc: mical.simek@xilinx.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Alex Williams <alex.williams@ni.com>
List-Id: linux-i2c@vger.kernel.org

Hi ,
Apologies for teh late reply,
Somehow replied only to Alex.
On Fri, Feb 15, 2019 at 8:59 PM Alex Williams <alex.williams@ettus.com> wrote:
>
> On Fri, Feb 15, 2019 at 2:53 AM Shubhrajyoti Datta
> <shubhrajyoti.datta@gmail.com> wrote:
> >
> > HI Alex,
> >
> > Thanks for the patch.
> >
> > On Fri, Feb 1, 2019 at 4:22 AM <alex.williams@ettus.com> wrote:
> > >
> > > From: Alex Williams <alex.williams@ni.com>
> > >
> > > Under certain conditions, Cadence's I2C controller's transfer_size
> >
> > Any help in reproducing the conditions would be appreciated
> >
> >
> > > register will roll over and generate invalid read transactions. Before
> > > this change, the ISR relied solely on the RXDV bit to determine when to
> > > write more data to the user's buffer. The invalid read data would cause
> > > overruns, smashing stacks and worse.
> > >
> > > This change stops the buffer writes to the requested boundary and
> > > reports the error. The controller will be reset so normal transactions
> > > may resume.
> > >
> > > Signed-off-by: Alex Williams <alex.williams@ni.com>
>
>
> One possible related errata is here:
> https://www.xilinx.com/support/answers/61664.html
>
> In our case, we only needed to hammer on i2c to reproduce in a few
> minutes, with a script like this:
> while true
>     do date
>     cat /sys/class/gpio/gpio882/direction > /dev/null
>     cat /sys/class/gpio/gpio883/direction > /dev/null
>     cat /sys/class/gpio/gpio884/direction > /dev/null
>     cat /sys/class/gpio/gpio885/direction > /dev/null
>     cat /sys/class/gpio/gpio886/direction > /dev/null
>     cat /sys/class/gpio/gpio887/direction > /dev/null
>     cat /sys/class/gpio/gpio888/direction > /dev/null
>     cat /sys/class/gpio/gpio889/direction > /dev/null
>     cat /sys/class/gpio/gpio890/direction > /dev/null
>     cat /sys/class/gpio/gpio891/direction > /dev/null
>     cat /sys/class/gpio/gpio892/direction > /dev/null
>
>     cat /sys/class/gpio/gpio894/direction > /dev/null
>     cat /sys/class/gpio/gpio895/direction > /dev/null
>     cat /sys/class/gpio/gpio896/direction > /dev/null
>     cat /sys/class/gpio/gpio897/direction > /dev/null
>     cat /sys/class/gpio/gpio898/direction > /dev/null
>     cat /sys/class/gpio/gpio899/direction > /dev/null
>     cat /sys/class/gpio/gpio900/direction > /dev/null
>     cat /sys/class/gpio/gpio901/direction > /dev/null
>     cat /sys/class/gpio/gpio902/direction > /dev/null
>     cat /sys/class/gpio/gpio903/direction > /dev/null
>     cat /sys/class/gpio/gpio904/direction > /dev/null
>     cat /sys/class/gpio/gpio905/direction > /dev/null
> done
>
> In normal usage, we have code that sets up a number of i2c GPIO
> expanders and pokes them for values as it initializes devices.
> Occasionally, the transfer size register will roll over, and the ISR
> will cause memory corruption, since it doesn't stop writing at the
> requested boundary.
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
