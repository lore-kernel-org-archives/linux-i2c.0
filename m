From: rishi gupta <gupt21@gmail.com>
Subject: Re: [PATCH v3] HID: mcp2221: add usb to i2c-smbus host bridge
Date: Tue, 10 Mar 2020 18:24:10 +0530
Message-ID: <CALUj-guKqkRKVKDa1U+gv0rLx23zc5cFT3Qnakp4muk9LSUYfQ@mail.gmail.com>
References: <1580185137-11255-1-git-send-email-gupt21@gmail.com> <20200310122934.GA13896@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36029 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgCJMyX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Mar 2020 08:54:23 -0400
In-Reply-To: <20200310122934.GA13896@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, wsa+renesas@sang-engineering.com, Greg KH <gregkh@linuxfoundation.org>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

I will send two more patches in sometime.

Patch 1: Define i2c_adapter_quirks to let i2c core check msg's order,
type and length
              As of now this driver itself is doing this sanity.

Patch 2: Add support for GPIO functionality

On Tue, Mar 10, 2020 at 5:59 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > +     if (num == 1) {
> > +             if (msgs->flags & I2C_M_RD) {
> > +                     ret = mcp_i2c_smbus_read(mcp, msgs, MCP2221_I2C_RD_DATA,
> > +                                                     0, 0, NULL);
> > +             } else {
> > +                     ret = mcp_i2c_write(mcp, msgs, MCP2221_I2C_WR_DATA, 1);
> > +             }
> > +             if (ret)
> > +                     goto exit;
> > +             ret = num;
> > +     } else if (num == 2) {
> > +             /* Ex transaction; send reg address and read its contents */
> > +             if (msgs[0].addr == msgs[1].addr &&
> > +                     !(msgs[0].flags & I2C_M_RD) &&
> > +                      (msgs[1].flags & I2C_M_RD)) {
> > +
> > +                     ret = mcp_i2c_write(mcp, &msgs[0],
> > +                                             MCP2221_I2C_WR_NO_STOP, 0);
> > +                     if (ret)
> > +                             goto exit;
> > +
> > +                     ret = mcp_i2c_smbus_read(mcp, &msgs[1],
> > +                                             MCP2221_I2C_RD_RPT_START,
> > +                                             0, 0, NULL);
> > +                     if (ret)
> > +                             goto exit;
> > +                     ret = num;
> > +             } else {
> > +                     dev_err(&adapter->dev,
> > +                             "unsupported multi-msg i2c transaction\n");
> > +                     ret = -EOPNOTSUPP;
> > +             }
> > +     } else {
> > +             dev_err(&adapter->dev,
> > +                     "unsupported multi-msg i2c transaction\n");
> > +             ret = -EOPNOTSUPP;
> > +     }
>
> Have a look at struct i2c_adapter_quirks and especially the flags to let
> the I2C core do the sanity checks from here.
>
