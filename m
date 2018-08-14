From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Tue, 14 Aug 2018 20:52:00 +0300
Message-ID: <CAHp75VctrKtj8oa4OuhsAKcwsBXUnb_Qyfu3DiHB7ghcyfY9GQ@mail.gmail.com>
References: <20180726225508.74612-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726225508.74612-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Dmitry Torokhov <dtor@chromium.org>, venkateswarlu.v.vinjamuri@intel.corp-partner.google.com
List-Id: linux-i2c@vger.kernel.org

+Cc: Jarkko

On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore <dbasehore@chromium.org> wrote:
> This enables the async suspend property for i2c devices. This reduces
> the suspend/resume time considerably on platforms with multiple i2c
> devices (such as a trackpad or touchscreen).
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/i2c/i2c-core-base.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 1ba40bb2b966..3382bb7e1dcc 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -749,6 +749,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>         client->dev.of_node = info->of_node;
>         client->dev.fwnode = info->fwnode;
>
> +       device_enable_async_suspend(&client->dev);
>         i2c_dev_set_name(adap, client, info);
>
>         if (info->properties) {
> --
> 2.18.0.345.g5c9ce644c3-goog
>



-- 
With Best Regards,
Andy Shevchenko
