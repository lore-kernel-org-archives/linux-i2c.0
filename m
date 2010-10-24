From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Subject: Re: [PATCH 12/12] hwmon: lis3: Release resources is case of failure
Date: Sun, 24 Oct 2010 16:59:23 +0200
Message-ID: <4CC449CB.1040005@tremplin-utc.net>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com> <1287748654-2626-13-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287748654-2626-13-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Op 22-10-10 13:57, Samu Onkalo schreef:
> If lis3lv02d_init_device fails, HW resources were not released
> properly. In case of failure call release_resources if available.
>
> Signed-off-by: Samu Onkalo<samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Acked-by: Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
> ---
>   drivers/hwmon/lis3lv02d_i2c.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> index 61c109b..94d5bde 100644
> --- a/drivers/hwmon/lis3lv02d_i2c.c
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -161,7 +161,12 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
>
>   	if (lis3_dev.reg_ctrl)
>   		lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
> +
> +	if (ret == 0)
> +		return 0;
>   fail:
> +	if (pdata&&  pdata->release_resources)
> +		pdata->release_resources();
>   	return ret;
>   }
>
