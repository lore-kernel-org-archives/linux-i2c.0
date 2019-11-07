From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Date: Thu, 7 Nov 2019 11:43:07 +0530
Message-ID: <CAKfKVtH8OvA9Hku8V2CxRkX8hiouLzsEJTTDQWgBtQF8PGXyBQ@mail.gmail.com>
References: <20190219012447.5900-1-sxauwsk@163.com> <CAKfKVtEwHcydp=+hNhG91h3qbMoYOPq7jEYjbuAVrWXT53DC3Q@mail.gmail.com>
 <2019110516474778997625@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2019110516474778997625@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "sxauwsk@163.com" <sxauwsk@163.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Shikai,

On Tue, Nov 5, 2019 at 2:18 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
>
> >Hi Shikai,
> >
> >On Tue, Feb 19, 2019 at 8:19 AM Shikai Wang <sxauwsk@163.com> wrote:
> >>
> >> When the adapter receive arbitration lost error interrupts,
> >> cdns_i2c_master_xfer return to the caller directly instead of resetting
> >> the adapter which resulted in the adapter being out of control.
> >>
> >> So when driver detect err_status such as arbitration lost,
> >> then try to repair and fix it.
> >>
> >I am missing the issue that you are facing.
> >You are having a multimaster scenario and getting arbitration lost.
> >
> >the current code would attempt a retry did that lead to any issues?
> >
> >Can you explain the issue that you are facing?
>
> Of cource,  The following describe my situation.
>
> In my product,  Touchscreen connect to zynq-7000 XC7Z010 by i2c bus( Just connect only one i2c-device of touchscreen),
> when user tap Touchscreen, Touchscreen interrupt send to CPU and notifyed i2c-driver to obtain location data by i2c-bus,

So it is single master single slave.
>
> when Tap the screen frequently,  sometimes CPU get interrupt from touchscreen and try to obtain data,  then detect arbitration lost,
the arbitration lost is surprising in non-multimaster scenario.
Is there any other master in the configuration that we may not be triggering.
Or can  you probe the lines?

> Although i2c-driver try three times,  it's useless.

You get bus busy? what is the issue.
>
> Actually i2c clock-line and data-line keep high, that mean i2c bus free.
> Once this situation occur, i2c-control did't work anynay but cpu receive interrputs still.
>
> I am sorry that I have't found a good solution for this issuse;
