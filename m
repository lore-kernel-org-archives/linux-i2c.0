From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/3] i2c: cros_ec: Support a limited i2c tunnel for exynos5250-spring
Date: Fri, 27 Jun 2014 14:44:28 -0700
Message-ID: <CAD=FV=V32sTVEpZAi=3q0rp0J_KP552_9wLUiyuPBxNjDT+tsQ@mail.gmail.com>
References: <1403898973-19571-1-git-send-email-dianders@chromium.org>
	<1403898973-19571-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403898973-19571-4-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>
Cc: Vincent Palatin <vpalatin@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Randall Spangler <rspangler@chromium.org>, Simon Glass <sjg@chromium.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Stephan van Schaik <stephan@synkhronix.com>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, Jun 27, 2014 at 12:56 PM, Doug Anderson <dianders@chromium.org> wrote:
> On exynos5250-spring the battery and tps65090 regulator are sitting on
> an i2c bus behind the EC (much like on exynos5420-peach-pit).  However
> on spring we don't have the full EC_CMD_I2C_PASSTHRU command.
>
> For the production kernel of spring we used a solution like this:
> - Fork the tps65090 driver and make a version that talks straight to
>   the cros_ec MFD driver and sends special EC commands for talking to
>   the regulator.
> - Add code into the i2c tunnel to look for i2c transfers and convert
>   them into special EC commands for talking to the battery.
>
> For reference:
> * http://crosreview.com/66116
> * https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/drivers/regulator/cros_ec-tps65090.c
>
> The above solution works great but is a bunch of code.  It appears
> that we can make do with the limited i2c passthrough commands that
> actually happened to be present on the exynos5250-spring EC.  Doing
> this we can present ourselves as supporting a small subset of smbus.
> We might need to do a few extra transfers here and there but we don't
> need any extra code.
>
> Seriss-cc: linux-samsung-soc
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 92 ++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)

I just got done talking to Randall and he suggested that this might
not actually work on Spring.  :(

It looks like in the Spring timeframe I2C EC commands were restricted
if the write protect screw was in place.  ...so someone will probably
want to take some of the code referenced above instead of this patch.

Patches #1 and #2 are probably still valid, though.

-Doug
