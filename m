From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH RESEND] macintosh: convert to i2c_new_scanned_device
Date: Tue, 11 Feb 2020 23:15:17 +1100
Message-ID: <87ftfhz5ey.fsf@mpe.ellerman.id.au>
References: <20200210170401.5357-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:36641 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgBKMPf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Feb 2020 07:15:35 -0500
In-Reply-To: <20200210170401.5357-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

Wolfram Sang <wsa+renesas@sang-engineering.com> writes:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). No functional change for this driver because
> it doesn't check the return code anyhow.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> I can take this via I2C tree if this makes things easier...

Yes please. Sorry I missed it before.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

>  drivers/macintosh/therm_windtunnel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
> index 8c744578122a..f15fec5e1cb6 100644
> --- a/drivers/macintosh/therm_windtunnel.c
> +++ b/drivers/macintosh/therm_windtunnel.c
> @@ -321,10 +321,10 @@ do_attach( struct i2c_adapter *adapter )
>  
>  		memset(&info, 0, sizeof(struct i2c_board_info));
>  		strlcpy(info.type, "therm_ds1775", I2C_NAME_SIZE);
> -		i2c_new_probed_device(adapter, &info, scan_ds1775, NULL);
> +		i2c_new_scanned_device(adapter, &info, scan_ds1775, NULL);
>  
>  		strlcpy(info.type, "therm_adm1030", I2C_NAME_SIZE);
> -		i2c_new_probed_device(adapter, &info, scan_adm1030, NULL);
> +		i2c_new_scanned_device(adapter, &info, scan_adm1030, NULL);
>  
>  		if( x.thermostat && x.fan ) {
>  			x.running = 1;
> -- 
> 2.20.1
