From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] I2C: busses: Do not print error message in syslog if no ACK received
Date: Tue, 12 Nov 2013 19:00:59 +0100
Message-ID: <201311121900.59305.marex@denx.de>
References: <1384278336-3694-1-git-send-email-wernerandy@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384278336-3694-1-git-send-email-wernerandy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Werner <wernerandy@gmx.de>
Cc: wsa@the-dreams.de, jacmet@sunsite.dk, baohua.song@csr.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dear Andreas Werner,

> Using the i2c-eg20t driver and call i2cdetect or probe on the bus,
> the driver will print a lot of error messages if there was no ACK
> received.
> 
> i2cdetect normally print a table with all the available devices. If there
> is no device on the address, the table will be empty.
> Currently with the i2c-eg20t driver, the table is not visible because
> the error messages destroy the table.
> 
> Error message: pch_i2c_getack return -71
> 
> This patch prevent the driver to print the messages to syslog if debug is
> not set.
> 
> Tested on Intel Atom E6xx and Eg20t Chipset.
> 
> Signed-off-by: Andreas Werner <wernerandy@gmx.de>
> ---
>  drivers/i2c/busses/i2c-eg20t.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-eg20t.c
> b/drivers/i2c/busses/i2c-eg20t.c index 0f37529..b10c651 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -322,7 +322,7 @@ static s32 pch_i2c_getack(struct i2c_algo_pch_data
> *adap) reg_val = ioread32(p + PCH_I2CSR) & PCH_GETACK;
> 
>  	if (reg_val != 0) {
> -		pch_err(adap, "return%d\n", -EPROTO);
> +		pch_dbg(adap, "return%d\n", -EPROTO);
>  		return -EPROTO;
>  	}

I'd just kill the pch_err() line altogether:

if (reg_val)
	return -EPROTO;

That is because if you look at the only caller of this function, which is 
pch_i2c_wait_for_check_xfer(), you will see that at the only place where 
pch_i2c_getack() is called there is already pch_dbg():

369         if (pch_i2c_getack(adap)) {
370                 pch_dbg(adap, "Receive NACK for slave address"
371                         "setting\n");
372                 return -EIO;
373         }

btw. (idea for subsequent patch) this pch_dbg() should be fixed to be a one-
liner /wrt the text so we can grep for the error messages. Such text arg should 
never be split in multiple lines in kernel.

Best regards,
Marek Vasut
