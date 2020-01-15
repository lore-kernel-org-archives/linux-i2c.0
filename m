From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/3] i2c: parport: move include file into main source
Date: Wed, 15 Jan 2020 15:17:43 +0100
Message-ID: <20200115151743.63e6b02d@endymion>
References: <20200113210643.5033-1-wsa+renesas@sang-engineering.com>
        <20200113210643.5033-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgAOORp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 15 Jan 2020 09:17:45 -0500
In-Reply-To: <20200113210643.5033-4-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org

On Mon, 13 Jan 2020 22:06:43 +0100, Wolfram Sang wrote:
> After removal of the parport-light driver, this include is used by the
> parport driver exclusively and can be included in the main source.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-parport.c | 100 ++++++++++++++++++++++++++++-
>  drivers/i2c/busses/i2c-parport.h | 106 -------------------------------
>  2 files changed, 99 insertions(+), 107 deletions(-)
>  delete mode 100644 drivers/i2c/busses/i2c-parport.h
> 
> diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
> index e8ed882de402..d03d22812eef 100644
> --- a/drivers/i2c/busses/i2c-parport.c
> +++ b/drivers/i2c/busses/i2c-parport.c
> (...)
> @@ -42,6 +125,7 @@ static LIST_HEAD(adapter_list);
>  static DEFINE_MUTEX(adapter_list_lock);
>  #define MAX_DEVICE 4
>  static int parport[MAX_DEVICE] = {0, -1, -1, -1};
> +static int type = -1;
>  
>  
>  /* ----- Low-level parallel port access ----------------------------------- */
> @@ -318,5 +402,19 @@ MODULE_PARM_DESC(parport,
>  		 " Default is one device connected to parport0.\n"
>  );
>  
> +module_param(type, int, 0);
> +MODULE_PARM_DESC(type,
> +	"Type of adapter:\n"
> +	" 0 = Philips adapter\n"
> +	" 1 = home brew teletext adapter\n"
> +	" 2 = Velleman K8000 adapter\n"
> +	" 3 = ELV adapter\n"
> +	" 4 = ADM1032 evaluation board\n"
> +	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
> +	" 6 = Barco LPT->DVI (K5800236) adapter\n"
> +	" 7 = One For All JP1 parallel port adapter\n"
> +	" 8 = VCT-jig\n"
> +);

Isn't it considered a better practice to keep the module_param (and
MODULE_PARM_DESC) close to the declaration of the variable itself so
that correctness can be easily verified and changing the type later
would be easier?

Other than that, I'm fine with the change, thanks for doing this.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
