From: Naveen Kaje <nkaje@codeaurora.org>
Subject: Re: [PATCH v2 2/3] i2c-smbus: Allow parms to be passed in from sysfs
 new_device
Date: Wed, 11 May 2016 11:26:12 -0600
Message-ID: <46440bc4-ec3e-dcdc-5ea8-8a248519761c@codeaurora.org>
References: <1462896699-1627-1-git-send-email-minyard@acm.org>
 <1462896699-1627-3-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55722 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcEKR0P (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 13:26:15 -0400
In-Reply-To: <1462896699-1627-3-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Cc: Corey Minyard <cminyard@mvista.com>



On 5/10/2016 10:11 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> This allows "irq=<num>" and "edge" to be passed in to the i2c new_device
> after the name and i2c address.  This way the alert can be configured
> without having to have platform data.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested on QDF2432 with I2C IPMI client to ensure no regressions are 
introduced.
Tested-by: Naveen Kaje <nkaje@codeaurora.org>
> ---
>   drivers/i2c/i2c-smbus.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
>
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index 7748fd6..4f099ad 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -23,6 +23,7 @@
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   #include <linux/workqueue.h>
> +#include <linux/ctype.h>
>   
>   struct i2c_smbus_alert {
>   	unsigned int		alert_edge_triggered:1;
> @@ -123,15 +124,86 @@ static irqreturn_t smbalert_irq(int irq, void *d)
>   	return IRQ_HANDLED;
>   }
>   
> +static struct i2c_smbus_alert_setup *smbalert_parse_parms(struct device *dev,
> +		const char *parms,
> +		struct i2c_smbus_alert_setup *data)
> +{
> +	int rv;
> +	char end;
> +
> +	if (!parms)
> +		return NULL;
> +
> +	data->alert_edge_triggered = false;
> +	while (*parms) {
> +		const char *next = parms;
> +		const char *val;
> +		int parmlen;
> +
> +		while (*next && !isspace(*next) && *next != '=')
> +			next++;
> +
> +		parmlen = next - parms;
> +
> +		if (*next == '=') {
> +			next++;
> +			val = next;
> +			while (*next && !isspace(*next))
> +				next++;
> +		} else {
> +			val = NULL;
> +		}
> +
> +		if (strncmp(parms, "irq", parmlen) == 0) {
> +			if (!val) {
> +				dev_err(dev, "no irq parm value given\n");
> +				return NULL;
> +			}
> +			rv = sscanf(val, "%d%c", &data->irq, &end);
> +			if ((rv < 1) || ((rv > 1) && !isspace(end))) {
> +				dev_err(dev, "Invalid irq parm: %s\n", val);
> +				return NULL;
> +			}
> +		} else if (strncmp(parms, "edge", parmlen) == 0) {
> +			if (val) {
> +				dev_err(dev, "Value given with edge parm: %s\n",
> +					val);
> +				return NULL;
> +			}
> +			data->alert_edge_triggered = true;
> +		} else {
> +			dev_err(dev, "Invalid parameter: %s\n", parms);
> +			return NULL;
> +		}
> +
> +		while (*next && isspace(*next))
> +			next++;
> +		parms = next;
> +	}
> +
> +	return data;
> +}
> +
>   /* Setup SMBALERT# infrastructure */
>   static int smbalert_probe(struct i2c_client *ara,
>   			  const struct i2c_device_id *id)
>   {
>   	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
> +	struct i2c_smbus_alert_setup dummy_setup;
>   	struct i2c_smbus_alert *alert;
>   	struct i2c_adapter *adapter = ara->adapter;
>   	int res;
>   
> +	if (ara->parms)
> +		/* Came in through sysfs. */
> +		setup = smbalert_parse_parms(&ara->dev, ara->parms,
> +					     &dummy_setup);
> +
> +	if (!setup) {
> +		dev_err(&ara->dev, "SMBus alert without setup\n");
> +		return -ENODEV;
> +	}
> +
>   	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
>   			     GFP_KERNEL);
>   	if (!alert)
