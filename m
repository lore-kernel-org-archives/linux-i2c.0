From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [2/2] i2c: piix4: Use usleep_range()
Date: Sun, 11 Feb 2018 12:12:22 -0800
Message-ID: <20180211201222.GA29596@roeck-us.net>
References: <1514652658-6228-2-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38425 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbeBKUMY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 11 Feb 2018 15:12:24 -0500
Content-Disposition: inline
In-Reply-To: <1514652658-6228-2-git-send-email-linux@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>, =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 30, 2017 at 08:50:58AM -0800, Guenter Roeck wrote:
> The piix4 i2c driver is extremely slow. Replacing msleep()
> with usleep_range() increases its speed substantially.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Any comments or concerns ?

Thanks,
Guenter

> ---
>  drivers/i2c/busses/i2c-piix4.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 78dd5951d6e7..52a8b1c5c110 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
>  
>  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
>  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> -		msleep(2);
> +		usleep_range(2000, 2000);
>  	else
> -		msleep(1);
> +		usleep_range(500, 1000);
>  
>  	while ((++timeout < MAX_TIMEOUT) &&
>  	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
> -		msleep(1);
> +		usleep_range(200, 500);
>  
>  	/* If the SMBus is still busy, we give up */
>  	if (timeout == MAX_TIMEOUT) {
