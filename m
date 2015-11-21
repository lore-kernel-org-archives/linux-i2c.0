From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3 1/1] i2c: taos-evm: replace simple_strtoul by
 kstrtou8
Date: Sat, 21 Nov 2015 21:11:31 +0100
Message-ID: <20151121211131.16715ba3@endymion.delvare>
References: <1447851356-6248-1-git-send-email-clabbe.montjoie@gmail.com>
	<1447851356-6248-2-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52695 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbbKUULe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 21 Nov 2015 15:11:34 -0500
In-Reply-To: <1447851356-6248-2-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Corentin,

On Wed, 18 Nov 2015 13:55:56 +0100, LABBE Corentin wrote:
> The simple_strtoul function is marked as obsolete.
> This patch replace it by kstrtou8.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>

Note: when there's a single patch you don't have to send an email with
PATCH 0/1.

> ---
>  drivers/i2c/busses/i2c-taos-evm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
> index 4c7fc2d..f673f5d 100644
> --- a/drivers/i2c/busses/i2c-taos-evm.c
> +++ b/drivers/i2c/busses/i2c-taos-evm.c
> @@ -130,7 +130,13 @@ static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  			return 0;
>  	} else {
>  		if (p[0] == 'x') {
> -			data->byte = simple_strtol(p + 1, NULL, 16);
> +			/*
> +			 * voluntarily dropping error code of kstrtou8 since all
> +			 * error code that it could return are invalid according
> +			 * to Documentation/i2c/fault-codes
> +			 */
> +			if (kstrtou8(p + 1, 16, &data->byte))
> +				return -EPROTO;
>  			return 0;
>  		}
>  	}


-- 
Jean Delvare
SUSE L3 Support
