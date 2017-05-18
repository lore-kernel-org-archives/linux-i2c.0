From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/2] i2c: stub: use pr_fmt
Date: Thu, 18 May 2017 10:39:32 +0200
Message-ID: <20170518103932.288cee1a@endymion>
References: <20170516112105.2793-1-wsa+renesas@sang-engineering.com>
        <20170516112105.2793-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752916AbdERIjg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 May 2017 04:39:36 -0400
In-Reply-To: <20170516112105.2793-2-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-renesas-soc@vger.kernel.org

On Tue, 16 May 2017 13:21:05 +0200, Wolfram Sang wrote:
> Instead of hard coding "i2c-stub:", let's use the pr_fmt mechanism to
> achieve the same more easily. This makes it easier to stay consistent
> when adding new messages. Also, remove an unneeded OOM message while we
> are here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-stub.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
> index 0aa4d646f8fb26..5627b1df391c7e 100644
> --- a/drivers/i2c/i2c-stub.c
> +++ b/drivers/i2c/i2c-stub.c
> @@ -15,7 +15,8 @@
>      GNU General Public License for more details.
>  */
>  
> -#define DEBUG 1
> +#define DEBUG
> +#define pr_fmt(fmt) "i2c-stub: " fmt
>  
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> @@ -342,7 +343,7 @@ static int __init i2c_stub_allocate_banks(int i)
>  	if (!chip->bank_words)
>  		return -ENOMEM;
>  
> -	pr_debug("i2c-stub: Allocated %u banks of %u words each (registers 0x%02x to 0x%02x)\n",
> +	pr_debug("Allocated %u banks of %u words each (registers 0x%02x to 0x%02x)\n",
>  		 chip->bank_mask, chip->bank_size, chip->bank_start,
>  		 chip->bank_end);
>  
> @@ -363,28 +364,27 @@ static int __init i2c_stub_init(void)
>  	int i, ret;
>  
>  	if (!chip_addr[0]) {
> -		pr_err("i2c-stub: Please specify a chip address\n");
> +		pr_err("Please specify a chip address\n");
>  		return -ENODEV;
>  	}
>  
>  	for (i = 0; i < MAX_CHIPS && chip_addr[i]; i++) {
>  		if (chip_addr[i] < 0x03 || chip_addr[i] > 0x77) {
> -			pr_err("i2c-stub: Invalid chip address 0x%02x\n",
> +			pr_err("Invalid chip address 0x%02x\n",
>  			       chip_addr[i]);
>  			return -EINVAL;
>  		}
>  
> -		pr_info("i2c-stub: Virtual chip at 0x%02x\n", chip_addr[i]);
> +		pr_info("Virtual chip at 0x%02x\n", chip_addr[i]);
>  	}
>  
>  	/* Allocate memory for all chips at once */
>  	stub_chips_nr = i;
>  	stub_chips = kcalloc(stub_chips_nr, sizeof(struct stub_chip),
>  			     GFP_KERNEL);
> -	if (!stub_chips) {
> -		pr_err("i2c-stub: Out of memory\n");
> +	if (!stub_chips)
>  		return -ENOMEM;
> -	}
> +
>  	for (i = 0; i < stub_chips_nr; i++) {
>  		INIT_LIST_HEAD(&stub_chips[i].smbus_blocks);
>  

Looks good to me.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
