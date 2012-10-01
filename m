From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: i2c_dw_xfer_msg can be static
Date: Sun, 30 Sep 2012 19:12:16 -0700
Message-ID: <CANOOhLRmObHz2LuJF6=h4hu4KqeFerCA6YzsJL-+P-EubLd3NQ@mail.gmail.com>
References: <20120930140451.6701adaf@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120930140451.6701adaf-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 30, 2012 at 5:04 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> i2c_dw_xfer_msg is only called internally so it can be static. It
> original was, before the driver split. No idea why it was changed at
> that time.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Ack

Not sure how it got dropped sorry

> ---
>  drivers/i2c/busses/i2c-designware-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-3.6-rc7.orig/drivers/i2c/busses/i2c-designware-core.c 2012-09-30 13:49:56.000000000 +0200
> +++ linux-3.6-rc7/drivers/i2c/busses/i2c-designware-core.c      2012-09-30 13:50:09.893408917 +0200
> @@ -370,7 +370,7 @@ static void i2c_dw_xfer_init(struct dw_i
>   * messages into the tx buffer.  Even if the size of i2c_msg data is
>   * longer than the size of the tx buffer, it handles everything.
>   */
> -void
> +static void
>  i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  {
>         struct i2c_msg *msgs = dev->msgs;
>
>
> --
> Jean Delvare
