From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 9/9] i2c: rk3x: support fast-mode plus for rk3399
Date: Thu, 5 May 2016 16:02:16 -0700
Message-ID: <CAD=FV=UtHPDtB7LTbUpwcjOcoYwNma59-TRDU3hrt6c_2TWxxA@mail.gmail.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
	<1462372668-6583-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34760 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288AbcEEXCR (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 19:02:17 -0400
Received: by mail-yw0-f175.google.com with SMTP id j74so149548423ywg.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 May 2016 16:02:17 -0700 (PDT)
In-Reply-To: <1462372668-6583-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

David,

On Wed, May 4, 2016 at 7:37 AM, David Wu <david.wu@rock-chips.com> wrote:
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 47368c4..c66cc39 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -124,6 +124,17 @@ static const struct i2c_spec_values fast_mode_spec = {
>         .min_hold_buffer_ns = 1300,
>  };
>
> +static const struct i2c_spec_values fast_mode_plus_spec = {
> +       .min_hold_start_ns = 260,
> +       .min_low_ns = 500,
> +       .min_high_ns = 260,
> +       .min_setup_start_ns = 260,
> +       .max_data_hold_ns = 400,

I'm curious where you got the data_hold_ns.  I can't quite remember
what this parameter does / how the timing function works anymore, but
the doc I have (search for UM10204 and click the first link) shows
values for Standard-mode and Fast-mode but not Fast-mode Plus.  It
seems to imply that this is a bit of a bogus number anyway because it
only matters if we don't stretch the tLOW to go along with the longer
data hold.

As I have said in the previous patch, how all this stuff works has
totally left my brain, so if you understand it that's probably good
enough.  If you feel like I should try to re-understand this again so
I can review it more deeply, let me know.


Since I assume that you had some sane reason to include max_data_hold_ns:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
