From: fetzerch <fetzer.ch@gmail.com>
Subject: Re: [PATCH] i2c: piix4: remove unneeded assignments
Date: Tue, 1 Dec 2015 21:31:52 +0100
Message-ID: <565E03B8.6030807@googlemail.com>
References: <1448890989-32733-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35223 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbLAUbz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Dec 2015 15:31:55 -0500
Received: by wmuu63 with SMTP id u63so189012345wmu.0
        for <linux-i2c@vger.kernel.org>; Tue, 01 Dec 2015 12:31:54 -0800 (PST)
In-Reply-To: <1448890989-32733-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Christian Fetzer <fetzer.ch@gmail.com>

Hi Wolfram,

On 30.11.2015 14:43, Wolfram Sang wrote:
> smatch rightfully says:
> drivers/i2c/busses/i2c-piix4.c:504 piix4_access warn: unused return: i = inb_p()
> drivers/i2c/busses/i2c-piix4.c:537 piix4_access warn: unused return: i = inb_p()
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> 
> Christian, can you please check on HW? I could only compile-test.

Your patch works fine on my machine!

Thanks for merging my patchset btw.
Christian

> 
>  drivers/i2c/busses/i2c-piix4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index af4e606f8886bd..e045985950737c 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -501,7 +501,7 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
>  			if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
>  				return -EINVAL;
>  			outb_p(len, SMBHSTDAT0);
> -			i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
> +			inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
>  			for (i = 1; i <= len; i++)
>  				outb_p(data->block[i], SMBBLKDAT);
>  		}
> @@ -534,7 +534,7 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
>  		data->block[0] = inb_p(SMBHSTDAT0);
>  		if (data->block[0] == 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
>  			return -EPROTO;
> -		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
> +		inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
>  		for (i = 1; i <= data->block[0]; i++)
>  			data->block[i] = inb_p(SMBBLKDAT);
>  		break;
> 
