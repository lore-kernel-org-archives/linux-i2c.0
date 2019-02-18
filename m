From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive error interrupts
Date: Mon, 18 Feb 2019 12:03:18 +0530
Message-ID: <CAKfKVtGu3dzSR71-Rsp8SR8nq8-XhY5FrgDvxv9iu_L-TyL5+Q@mail.gmail.com>
References: <20190129195214.30272-1-sxauwsk@163.com> <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
 <2019021615501780626817@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2019021615501780626817@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "sxauwsk@163.com" <sxauwsk@163.com>
Cc: "michal.simek" <michal.simek@xilinx.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

Hi ,
On Sat, Feb 16, 2019 at 1:21 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
>
> >Hi Sxauwsk,
> >
> >On Wed, Jan 30, 2019 at 3:13 PM sxauwsk <sxauwsk@163.com> wrote:
> >>
> >> When the adapter receive error interrupts, such as NACK, arbitration lost,
> >> cdns_i2c_master_xfer return to the caller directly instead of resuming
> >> the adapter which resulted in the adapter being out of control.
> >>
> >> So when driver detect err_status then try to repair and fix it.
> >>
> >> Signed-off-by: sxauwsk <sxauwsk@163.com>
> >> ---
> >>  drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> >> index b13605718291..e10048d7524a 100644
> >> --- a/drivers/i2c/busses/i2c-cadence.c
> >> +++ b/drivers/i2c/busses/i2c-cadence.c
> >> @@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
> >>         cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
> >>                           CDNS_I2C_IDR_OFFSET);
> >>
> >> -       /* If it is bus arbitration error, try again */
> >> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> >> -               return -EAGAIN;
> >> -
> >>         return 0;
> >>  }
> >>
> >> @@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >>                         id->bus_hold_flag = 0;
> >>
> >>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> >> -               if (ret)
> >> +               if (!ret)
> >>                         goto out;
> >>
> >In case  the Arbitration error happend  the cdns_i2c_process_msg would return 0
> >and we will miss the check  below.
> >
> >Am I missing something ?
> >
> >>                 /* Report the other error interrupts to application */
> >>                 if (id->err_status) {
> >>                         cdns_i2c_master_reset(adap);
> >>
> >> +                       /* If it is bus arbitration error, try again */
> >> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> >> +                               ret = -EAGAIN;
> >> +                               goto out;
> >> +                       }
> >> +
> >>                         if (id->err_status & CDNS_I2C_IXR_NACK) {
> >>                                 ret = -ENXIO;
> >>                                 goto out;
> >> --
> >> 2.19.2
> >>
> >>
>
> In cdns_i2c_process_msg process, when detect arbitration lost error return -EAGAIN to  cdns_i2c_master_xfer,  not return 0
> that mean cdns_i2c_process_msg  just go out ignore error check and  problem occur, So we should do something when arbitration error detect.

Arbitration lost is fine how about other errors like NACK.
