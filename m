From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v1] i2c: aspeed: fixed potential null pointer dereference
Date: Mon, 31 Jul 2017 18:57:09 +0930
Message-ID: <CACPK8XdT5yxKFj75JCuXZ+3GT1Q6x0EYADmFdu6we6SHwTMnLw@mail.gmail.com>
References: <20170729010012.5032-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37608 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdGaJ1b (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 31 Jul 2017 05:27:31 -0400
In-Reply-To: <20170729010012.5032-1-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Patrick Venture <venture@google.com>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Jul 29, 2017 at 10:30 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> Before I skipped null checks when the master is in the STOP state; this
> fixes that.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Joel Stanley <joel@jms.id.au>

Out of interest, was this found by code review, or did you hit this in testing?

Cheers,

Joel

> ---
>  drivers/i2c/busses/i2c-aspeed.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index f19348328a71..6fdf9231c23c 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -410,10 +410,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>         }
>
>         /* We are in an invalid state; reset bus to a known state. */
> -       if (!bus->msgs && bus->master_state != ASPEED_I2C_MASTER_STOP) {
> +       if (!bus->msgs) {
>                 dev_err(bus->dev, "bus in unknown state");
>                 bus->cmd_err = -EIO;
> -               aspeed_i2c_do_stop(bus);
> +               if (bus->master_state != ASPEED_I2C_MASTER_STOP)
> +                       aspeed_i2c_do_stop(bus);
>                 goto out_no_complete;
>         }
>         msg = &bus->msgs[bus->msgs_index];
> --
> 2.14.0.rc0.400.g1c36432dff-goog
>
