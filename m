From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] i2c: xiic: Support disabling multi-master in DT
Date: Thu, 19 Mar 2020 15:04:09 +0530
Message-ID: <CAKfKVtGSq5rJ0EvZgyg1Rw3=d5Q4ReJUYM7hTSTPP4sXaJyJTw@mail.gmail.com>
References: <20200218135627.24739-1-ext-jaakko.laine@vaisala.com>
 <CAKfKVtFf+VpinkOGsBFZ2-_PKvx-C1L7G7_uhY2RCvV5dy6L_w@mail.gmail.com> <AM0PR06MB5185E501349E06428093B62FD4F70@AM0PR06MB5185.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:44152 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgCSJeX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Mar 2020 05:34:23 -0400
Received: by mail-io1-f67.google.com with SMTP id v3so1481154iot.11
        for <linux-i2c@vger.kernel.org>; Thu, 19 Mar 2020 02:34:22 -0700 (PDT)
In-Reply-To: <AM0PR06MB5185E501349E06428093B62FD4F70@AM0PR06MB5185.eurprd06.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jakko,

On Wed, Mar 18, 2020 at 10:19 PM Laine Jaakko EXT
<ext-jaakko.laine@vaisala.com> wrote:
>
> Hello,
>
> >> @@ -521,19 +523,26 @@ static int xiic_bus_busy(struct xiic_i2c *i2c)
> >>  static int xiic_busy(struct xiic_i2c *i2c)
> >>  {
> >>         int tries = 3;
> >> -       int err;
> >> +       int err = 0;
> >>
> >>         if (i2c->tx_msg)
> >>                 return -EBUSY;
> >>
> >> -       /* for instance if previous transfer was terminated due to TX error
> >> -        * it might be that the bus is on it's way to become available
> >> -        * give it at most 3 ms to wake
> >> +       /* In single master mode bus can only be busy, when in use by this
> >> +        * driver. If the register indicates bus being busy for some reason we
> >> +        * should ignore it, since bus will never be released and i2c will be
> >> +        * stuck forever.
> >>          */
> >
> >the other thing i was thinking how will multithreading .
> >Should we have a lock here.
> >
> >> -       err = xiic_bus_busy(i2c);
> >> -       while (err && tries--) {
> >> -               msleep(1);
> >> +       if (i2c->multimaster) {
> >> +               /* for instance if previous transfer was terminated due to TX
> >> +                * error it might be that the bus is on it's way to become
> >> +                * available give it at most 3 ms to wake
> >> +                */
> >>                 err = xiic_bus_busy(i2c);
> >> +               while (err && tries--) {
> >> +                       msleep(1);
> >> +                       err = xiic_bus_busy(i2c);
> >> +               }
> >>         }
> >>
> >>         return err;
>
> Which resource specifically are you worried about needing locking here?
>
Earlier multiple threads on the same processor will wait for bus busy.

Now my concern was

thread1 -> makes a transaction

thread2  -> this will not wait for bus busy and access.
