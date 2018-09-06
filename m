From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] i2c: xiic: Make the start and the byte count write atomic
Date: Thu, 6 Sep 2018 12:38:08 +0530
Message-ID: <CAKfKVtHrN2gGWxrOy5jhhQQ5pxU=XBSym72m8nDYUJvrPGfdiw@mail.gmail.com>
References: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com> <20180904161114.GC5000@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904161114.GC5000@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Sep 4, 2018 at 9:41 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Sep 03, 2018 at 03:11:11PM +0530, shubhrajyoti.datta@gmail.com wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >
> > Disable interrupts while configuring the transfer and enable them back.
> >
> > We have below as the programming sequence
> > 1. start and slave address
> > 2. byte count and stop
> >
> > In some customer platform there was a lot of interrupts between 1 and 2
> > and after slave address (around 7 clock cyles) if 2 is not executed
> > then the transaction is nacked.
> >
> > To fix this case make the 2 writes atomic.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>
> I assume simply changing the order of the register writes won't fix it?
No that is not possible.
>
> I also assume this is stable material?
>
Yes let me know if you want me to resend with the stable tag?
