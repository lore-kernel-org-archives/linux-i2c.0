From: Uwe Bugla <uwe.bugla-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] i2c: Prevent log spam on some DVB adapters
Date: Thu, 21 Aug 2008 16:44:55 +0200
Message-ID: <200808211644.55576.uwe.bugla@gmx.de>
References: <20080821151556.53319c57@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080821151556.53319c57-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Florian Schirmer <jolt-8fvKG/JI9D0dnm+yROfE0A@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, patrick.boettcher-T5F83Mi6MZE@public.gmane.org, stoth-tHsjnVUC+Ghl57MIdRCFDg@public.gmane.org, mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Linux I2C <i2c@>
List-Id: linux-i2c@vger.kernel.org

Am Thursday 21 August 2008 15:15:56 schrieben Sie:
> Some DVB adapters do not support the special I2C transaction that we
> use for probing purposes. There's no point in logging this event, as
> there's nothing the user can do and in general there is no actual
> problem. So, degrade one of these message to a debug message, and
> move the other one around so that it is only printed on bogus drivers.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Uwe Bugla <uwe.bugla-Mmb7MZpHnFY@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> --- linux-2.6.27-rc4.orig/drivers/i2c/i2c-core.c	2008-08-21
> 14:04:03.000000000 +0200 +++
> linux-2.6.27-rc4/drivers/i2c/i2c-core.c	2008-08-21 14:58:14.000000000 +0200
> @@ -1190,8 +1190,8 @@ int i2c_probe(struct i2c_adapter *adapte
>  		 && address_data->normal_i2c[0] == I2C_CLIENT_END)
>  			return 0;
>
> -		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
> -			 "can't probe for chips\n");
> +		dev_dbg(&adapter->dev, "SMBus Quick command not supported, "
> +			"can't probe for chips\n");
>  		return -EOPNOTSUPP;
>  	}
>
> @@ -1352,6 +1352,10 @@ static int i2c_detect(struct i2c_adapter
>  		}
>  	}
>
> +	/* Stop here if the classes do not match */
> +	if (!(adapter->class & driver->class))
> +		goto exit_free;
> +
>  	/* Stop here if we can't use SMBUS_QUICK */
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
>  		if (address_data->probe[0] == I2C_CLIENT_END
> @@ -1364,10 +1368,6 @@ static int i2c_detect(struct i2c_adapter
>  		goto exit_free;
>  	}
>
> -	/* Stop here if the classes do not match */
> -	if (!(adapter->class & driver->class))
> -		goto exit_free;
> -
>  	/* Probe entries are done second, and are not affected by ignore
>  	   entries either */
>  	for (i = 0; address_data->probe[i] != I2C_CLIENT_END; i += 2) {

Salut Jean,

in case that you change the following:

@@ -1188,8 +1188,8 @@ int i2c_probe(struct i2c_adapter *adapte

instead of:

@@ -1190,8 +1190,8 @@ int i2c_probe(struct i2c_adapter *adapte,

@@ -1350,6 +1350,10 @@ static int i2c_detect(struct i2c_adapter

instead of:

@@ -1352,6 +1352,10 @@ static int i2c_detect(struct i2c_adapter,

@@ -1362,10 +1366,6 @@ static int i2c_detect(struct i2c_adapte

instead of:

@@ -1364,10 +1368,6 @@ static int i2c_detect(struct i2c_adapte

I'll give you my: Signed-Off-By: Uwe Bugla <uwe.bugla-Mmb7MZpHnFY@public.gmane.org>

for your patch material......

Mille fois merci encore une fois!  : )

I've understood the issue in so far that this patch stuff only suppresses the 
symptom, but does not cure the source problem, and I'd be very happy to see a 
card driver fully supporting the I2C bus.

And if I'm not completely aside my DVB-S card runs somwhow now, but it runs 
with an applied brake.

Fact is that the nerving messages are gone  : )

C'est une plaisanterie travailler avec toi, Jean!  : )

On se verra

Uwe


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
