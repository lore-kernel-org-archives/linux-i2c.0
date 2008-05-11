From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] I2C: SiByte: Mark i2c_sibyte_add_bus() as static
Date: Sun, 11 May 2008 11:07:08 +0200
Message-ID: <20080511110708.57aedfa6@hyperion.delvare>
References: <Pine.LNX.4.55.0805110311170.18978@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755564AbYEKJHd@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0805110311170.18978@cliff.in.clinika.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 May 2008 03:14:05 +0100 (BST), Maciej W. Rozycki wrote:
>  The i2c_sibyte_add_bus() function is not called, nor meant to, from 
> outside, so mark it as static; fixing a sparse warning too.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  It should be obvious.  Please apply.
> 
>   Maciej
> 
> patch-2.6.26-rc1-20080505-sibyte-i2c-sparse-16
> diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c
> --- linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c	2008-05-05 02:55:25.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c	2008-05-11 01:11:00.000000000 +0000
> @@ -132,7 +132,7 @@ static const struct i2c_algorithm i2c_si
>  /*
>   * registering functions to load algorithms at runtime
>   */
> -int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
> +static int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
>  {
>  	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
>  

Applied, thanks.

-- 
Jean Delvare
