From: Naveen Kaje <nkaje@codeaurora.org>
Subject: Re: [PATCH v2 3/3] ipmi: Handle I2C parms in the SSIF driver.
Date: Wed, 11 May 2016 11:26:44 -0600
Message-ID: <f29ae056-7942-c698-6a8b-02c72258a786@codeaurora.org>
References: <1462896699-1627-1-git-send-email-minyard@acm.org>
 <1462896699-1627-4-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55769 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbcEKR0q (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 13:26:46 -0400
In-Reply-To: <1462896699-1627-4-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Cc: Corey Minyard <cminyard@mvista.com>



On 5/10/2016 10:11 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested on QDF2432 with I2C IPMI client to ensure no regressions are 
introduced.
Tested-by: Naveen Kaje <nkaje@codeaurora.org>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 097c868..bbd9744 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -200,7 +200,7 @@ struct ssif_info {
>   	struct ipmi_smi_msg *waiting_msg;
>   	struct ipmi_smi_msg *curr_msg;
>   	enum ssif_intf_state ssif_state;
> -	unsigned long       ssif_debug;
> +	unsigned int        ssif_debug;
>   
>   	struct ipmi_smi_handlers handlers;
>   
> @@ -1386,6 +1386,60 @@ restart:
>   	return found;
>   }
>   
> +static int ssif_parse_parms(struct ssif_info *ssif_info,
> +			    const char *parms, u8 *slave_addr)
> +{
> +	int rv;
> +	char end;
> +
> +	if (!parms)
> +		return 0;
> +
> +	while (*parms) {
> +		const char *next = parms;
> +		const char *val;
> +		int parmlen;
> +
> +		while (*next && !isspace(*next) && *next != '=')
> +			next++;
> +
> +		if (*next != '=') {
> +			pr_err("IPMI SSIF invalid parm starting at %s\n",
> +			       parms);
> +			return -EINVAL;
> +		}
> +
> +		parmlen = next - parms;
> +		next++;
> +		val = next;
> +		while (*next && !isspace(*next))
> +			next++;
> +
> +		if (strncmp(parms, "ipmb", parmlen) == 0) {
> +			rv = sscanf(val, "%hhx%c", slave_addr, &end);
> +			if ((rv < 1) || ((rv > 1) && !isspace(end))) {
> +				pr_err("Invalid ipmb address: %s\n", val);
> +				return -EINVAL;
> +			}
> +		} else if (strncmp(parms, "debug", parmlen) == 0) {
> +			rv = sscanf(val, "%i%c", &ssif_info->ssif_debug, &end);
> +			if ((rv < 1) || ((rv > 1) && !isspace(end))) {
> +				pr_err("Invalid debug value: %s\n", val);
> +				return -EINVAL;
> +			}
> +		} else {
> +			pr_err("Invalid IPMI SSIF parameter: %s\n", parms);
> +			return -EINVAL;
> +		}
> +
> +		while (*next && isspace(*next))
> +			next++;
> +		parms = next;
> +	}
> +
> +	return 0;
> +}
> +
>   static bool check_acpi(struct ssif_info *ssif_info, struct device *dev)
>   {
>   #ifdef CONFIG_ACPI
> @@ -1435,6 +1489,12 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   		if (!addr_info) {
>   			/* Must have come in through sysfs. */
>   			ssif_info->addr_source = SI_HOTMOD;
> +			rv = ssif_parse_parms(ssif_info, client->parms,
> +					      &slave_addr);
> +			if (rv) {
> +				pr_err(PFX "Unable to parse parms from i2c\n");
> +				goto out;
> +			}
>   		} else {
>   			ssif_info->addr_source = addr_info->addr_src;
>   			ssif_info->ssif_debug = addr_info->debug;
