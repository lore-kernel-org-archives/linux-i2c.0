From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 08/12] i2c: meson: explicitly ignore messages with length
 zero
Date: Wed, 8 Mar 2017 23:03:46 +0100
Message-ID: <00a0854d-b0f6-5711-0b6e-25f0f3fe9b4f@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
 <11e16ab1-e3dd-56d0-55c5-1420576a9bb3@gmail.com>
 <CANe6Qb9nKdLnOcwEwuk8NXEB+fxW2S_kkzP+U+qygYhNqz0Y0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33320 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbdCHWF3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 17:05:29 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so5802681wrg.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 14:03:56 -0800 (PST)
In-Reply-To: <CANe6Qb9nKdLnOcwEwuk8NXEB+fxW2S_kkzP+U+qygYhNqz0Y0w@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Dooks <bjdooks@googlemail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-amlogic@lists.infradead.org

Am 08.03.2017 um 08:53 schrieb Ben Dooks:
> Probably a bad idea. Zero data could just be an address is there check
> 
Thanks for pointing out.

> On 8 Mar 2017 06:51, "Heiner Kallweit" <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
> 
>     Explicitely ignore messages with length zero. This also allows to
>     remove some now unneeded checks during message processing.
> 
>     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>>
>     ---
>      drivers/i2c/busses/i2c-meson.c | 20 +++++++++-----------
>      1 file changed, 9 insertions(+), 11 deletions(-)
> 
>     diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
>     index b3b881f9..58414699 100644
>     --- a/drivers/i2c/busses/i2c-meson.c
>     +++ b/drivers/i2c/busses/i2c-meson.c
>     @@ -196,12 +196,10 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
>             for (i = 0; i < i2c->count - 1; i++)
>                     meson_i2c_add_token(i2c, TOKEN_DATA);
> 
>     -       if (i2c->count) {
>     -               if (write || i2c->pos + i2c->count < i2c->msg->len)
>     -                       meson_i2c_add_token(i2c, TOKEN_DATA);
>     -               else
>     -                       meson_i2c_add_token(i2c, TOKEN_DATA_LAST);
>     -       }
>     +       if (write || i2c->pos + i2c->count < i2c->msg->len)
>     +               meson_i2c_add_token(i2c, TOKEN_DATA);
>     +       else
>     +               meson_i2c_add_token(i2c, TOKEN_DATA_LAST);
> 
>             if (write)
>                     meson_i2c_put_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
>     @@ -257,11 +255,8 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
> 
>             switch (i2c->state) {
>             case STATE_READ:
>     -               if (i2c->count > 0) {
>     -                       meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos,
>     -                                          i2c->count);
>     -                       i2c->pos += i2c->count;
>     -               }
>     +               meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
>     +               i2c->pos += i2c->count;
> 
>                     if (i2c->pos >= i2c->msg->len) {
>                             meson_i2c_stop(i2c);
>     @@ -371,6 +366,9 @@ static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>             clk_enable(i2c->clk);
> 
>             for (i = 0; i < num; i++) {
>     +               /* ignore messages with length 0 */
>     +               if (!msgs[i].len)
>     +                       continue;
>                     ret = meson_i2c_xfer_msg(i2c, &msgs[i], i == num - 1);
>                     if (ret)
>                             break;
>     --
>     2.12.0
> 
> 
> 
>     _______________________________________________
>     linux-amlogic mailing list
>     linux-amlogic@lists.infradead.org <mailto:linux-amlogic@lists.infradead.org>
>     http://lists.infradead.org/mailman/listinfo/linux-amlogic <http://lists.infradead.org/mailman/listinfo/linux-amlogic>
> 
