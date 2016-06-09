From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [v2,01/10] i2c-i801: Remove hwpec from block byte-by-byte
 function
Date: Thu, 9 Jun 2016 11:36:44 +0200
Message-ID: <20160609093643.GC24234@mail.corp.redhat.com>
References: <1464570544-975-2-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464570544-975-2-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
List-Id: linux-i2c@vger.kernel.org

Hi Corey,

I wanted to send a global rev-by, but it looks like some changes in this
series are required from my point of view, so I'll just send individual
rev-by and change requests as my review progresses.

On May 29 2016 or thereabouts, Corey Minyard wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> It's not used in the function, so get rid of it.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---

I am not entirely sure if this was kept for a reason or not, but the
argument is not used. So:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/i2c/busses/i2c-i801.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 64b1208b..818c0c8 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -554,8 +554,7 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
>   */
>  static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>  					       union i2c_smbus_data *data,
> -					       char read_write, int command,
> -					       int hwpec)
> +					       char read_write, int command)
>  {
>  	int i, len;
>  	int smbcmd;
> @@ -698,7 +697,7 @@ static int i801_block_transaction(struct i801_priv *priv,
>  	else
>  		result = i801_block_transaction_byte_by_byte(priv, data,
>  							     read_write,
> -							     command, hwpec);
> +							     command);
>  
>  	if (command == I2C_SMBUS_I2C_BLOCK_DATA
>  	 && read_write == I2C_SMBUS_WRITE) {
