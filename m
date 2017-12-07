From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] i2c: piix4: Fix port number check on release
Date: Thu, 7 Dec 2017 06:23:06 -0800
Message-ID: <17a4f7fe-18de-c7ce-07e3-3942b31e2b7a@roeck-us.net>
References: <20171207122545.1b8e17c6@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:38571 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753331AbdLGOXJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Dec 2017 09:23:09 -0500
Received: by mail-pg0-f50.google.com with SMTP id f12so4570568pgo.5
        for <linux-i2c@vger.kernel.org>; Thu, 07 Dec 2017 06:23:09 -0800 (PST)
In-Reply-To: <20171207122545.1b8e17c6@endymion>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>

On 12/07/2017 03:25 AM, Jean Delvare wrote:
> The port number shift is still hard-coded to 1 while it now depends
> on the hardware.
> 
> Thankfully 0 is always 0 no matter how you shift it, so this was a
> bug without consequences.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 0fe16195f891 ("i2c: piix4: Fix SMBus port selection for AMD Family 17h chips")
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---
> Sorry for missing this while reviewing the original patch.
> 

Sorry for missing it.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>   drivers/i2c/busses/i2c-piix4.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-4.14.orig/drivers/i2c/busses/i2c-piix4.c	2017-12-07 11:06:05.198260340 +0100
> +++ linux-4.14/drivers/i2c/busses/i2c-piix4.c	2017-12-07 12:18:56.405907856 +0100
> @@ -989,7 +989,7 @@ static void piix4_adap_remove(struct i2c
>   
>   	if (adapdata->smba) {
>   		i2c_del_adapter(adap);
> -		if (adapdata->port == (0 << 1)) {
> +		if (adapdata->port == (0 << piix4_port_shift_sb800)) {
>   			release_region(adapdata->smba, SMBIOSIZE);
>   			if (adapdata->sb800_main)
>   				release_region(SB800_PIIX4_SMB_IDX, 2);
> 
> 
