From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
 updates, part 2
Date: Sat, 23 Feb 2008 20:48:15 +0100
Message-ID: <20080223204815.53efe8ea@hyperion.delvare>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<20080223175356.95681BA69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<31e679430802231000i4a360269v5d0bc61fc21fd7c3@mail.gmail.com>
	<200802231010.40108.david-b@pacbell.net>
	<31e679430802231100r19df9157x9bbd910a592f4392@mail.gmail.com>
	<31e679430802231108k613bdd9ds2782aed429b65b50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430802231108k613bdd9ds2782aed429b65b50-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 23 Feb 2008 21:08:04 +0200, Felipe Balbi wrote:
> Sorry replying to myself, but I have a better with most of comments
> from Jean applied.
> Missing irq flags, mostly.
> 
> It's attached

This update adds this bug:

> +	if (client->irq > 0)
> +		status = request_irq(client->irq, isp1301_irq,
> +				IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING,
> +				DRIVER_NAME, isp);
>  	if (status < 0) {

This test should be moved inside the "if (client->irq > 0)".

> -		dev_dbg(&i2c->dev, "can't get IRQ %d, err %d\n",
> -				isp->irq, status);
> +		dev_dbg(&client->dev, "can't get IRQ %d, err %d\n",
> +				client->irq, status);
>  #ifdef	CONFIG_USB_OTG
>  fail2:
>  #endif
> -		i2c_detach_client(i2c);
> +		i2c_detach_client(client);

Also note (I missed it in my previous review): don't call
i2c_detach_client() for a new-syle driver!

>  		goto fail1;
>  	}

You addressed some of the issues I raised (thanks) but not all, so I
still can't include this patch into my i2c tree for now.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
