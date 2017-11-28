From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c-cht-wc: constify platform_device_id
Date: Tue, 28 Nov 2017 14:25:29 +0100
Message-ID: <6480ed7b-ae78-7a45-c9c9-fd19e0642546@redhat.com>
References: <bbbfa0879a3b9b778b11879fb6eb8150f4cb6838.1511864617.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbdK1NZb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 08:25:31 -0500
In-Reply-To: <bbbfa0879a3b9b778b11879fb6eb8150f4cb6838.1511864617.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

On 28-11-17 11:25, Arvind Yadav wrote:
> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/i2c/busses/i2c-cht-wc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index 190bbbc..db56759 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -342,7 +342,7 @@ static int cht_wc_i2c_adap_i2c_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static struct platform_device_id cht_wc_i2c_adap_id_table[] = {
> +static const struct platform_device_id cht_wc_i2c_adap_id_table[] = {
>   	{ .name = "cht_wcove_ext_chgr" },
>   	{},
>   };
> 
