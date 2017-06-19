From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: algo-bit: add support for I2C_M_STOP
Date: Mon, 19 Jun 2017 10:30:02 +0200
Message-ID: <20170619103002.5d502c92@endymion>
References: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sat, 17 Jun 2017 19:12:38 +0200, Wolfram Sang wrote:
> Support for enforced STOPs will allow us to use SCCB compatible devices.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Notes: I don't actually have any SCCB compatible sensor but verified with a
> logic analyzer that repeated starts got replaced with a stop + start sequence.
> However, we have members in our team who might need this feature soon. I'll
> likely wait for their Tested-by unless something unforseen happens.
> 
>  drivers/i2c/algos/i2c-algo-bit.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index a8e89df665b904..4758058352959d 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -549,12 +549,17 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
>  	bit_dbg(3, &i2c_adap->dev, "emitting start condition\n");
>  	i2c_start(adap);
>  	for (i = 0; i < num; i++) {
> +		bool did_stop = false;

I'm pretty certain you want to declare and initialize this variable
outside the loop.

> +
>  		pmsg = &msgs[i];
>  		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK;
>  		if (!(pmsg->flags & I2C_M_NOSTART)) {
> -			if (i) {
> -				bit_dbg(3, &i2c_adap->dev, "emitting "
> -					"repeated start condition\n");
> +			if (did_stop) {
> +				bit_dbg(3, &i2c_adap->dev, "emitting start condition\n");
> +				i2c_start(adap);
> +				did_stop = false;
> +			} else if (i) {
> +				bit_dbg(3, &i2c_adap->dev, "emitting repeated start condition\n");
>  				i2c_repstart(adap);
>  			}
>  			ret = bit_doAddress(i2c_adap, pmsg);
> @@ -588,6 +593,12 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
>  				goto bailout;
>  			}
>  		}
> +
> +		if (pmsg->flags & I2C_M_STOP && i != num - 1) {

I recommend adding parentheses around the bit matching when combined
with &&. I know it is not strictly needed and the compiler doesn't
care, but I find it easier to read, and there seems to be a consensus
(90 %) on that in the kernel tree.

> +			bit_dbg(3, &i2c_adap->dev, "emitting enforced stop condition\n");
> +			i2c_stop(adap);
> +			did_stop = true;
> +		}
>  	}
>  	ret = i;
>  

I have 2 questions:

1* Repeated start happens between messages of a same transaction, and
you handle that case above. However in the case of 10-bit address
clients, there is also a repeated start happening during the address
phase of the transaction, if the first message is a read. Did you check
what the SCCB protocol expects in that case?

2* I'm not sure why you add the enforced stop at the end of one
iteration and the start at the beginning of the next iteration. It
would be more simple and efficient to do both at the beginning of the
next iteration. The only case where it would make a difference is if
both I2C_M_NOSTART and I2C_M_STOP are specified. In this case you
currently emit a stop condition but no start, which I don't think can
work at all.

What about something like that instead? Or I am missing something?

--- linux-4.11.orig/drivers/i2c/algos/i2c-algo-bit.c	2017-06-19 09:57:17.949074198 +0200
+++ linux-4.11/drivers/i2c/algos/i2c-algo-bit.c	2017-06-19 10:23:26.711088536 +0200
@@ -553,8 +553,17 @@ static int bit_xfer(struct i2c_adapter *
 		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK;
 		if (!(pmsg->flags & I2C_M_NOSTART)) {
 			if (i) {
-				bit_dbg(3, &i2c_adap->dev, "emitting "
-					"repeated start condition\n");
+				if (msgs[i - 1].flags & I2C_M_STOP) {
+					bit_dbg(3, &i2c_adap->dev,
+						"emitting enforced stop condition\n");
+					i2c_stop(adap);
+					bit_dbg(3, &i2c_adap->dev,
+						"emitting start condition\n");
+					i2c_start(adap);
+				}
+
+				bit_dbg(3, &i2c_adap->dev,
+					"emitting repeated start condition\n");
 				i2c_repstart(adap);
 			}
 			ret = bit_doAddress(i2c_adap, pmsg);


-- 
Jean Delvare
SUSE L3 Support
