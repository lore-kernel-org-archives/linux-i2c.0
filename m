From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 5/5] i2c: i801: warn on i2c_handle_smbus_host_notify()
 errors
Date: Mon, 1 Aug 2016 16:14:25 +0200
Message-ID: <20160801161425.374dbcd9@endymion>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
 <1469699443-22129-6-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38473 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbcHAOeh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Aug 2016 10:34:37 -0400
In-Reply-To: <1469699443-22129-6-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, 28 Jul 2016 11:50:43 +0200, Benjamin Tissoires wrote:
> i2c_handle_smbus_host_notify() returns 1 on success, something else on
> errors.

I did not notice before, but that doesn't make much sense IMHO. Your
function follows the "negative number on error" return model, so
returning the boolean value from schedule_work() doesn't look good.
Either you don't care about that value, and you should ignore it and
return 0 on success. Or you care and you should handle it in the
function. Right now value false/0 is in a gray zone, you don't consider
it as success according to the above comment, but you don't treat it as
an error in the code below either. I suppose it can't actually happen?
If so, I advise you don't check the value returned by schedule_work().

> There is a chance we get called while Host Notify is not available (yet),
> so we need to clear the Host Notify bit in those rare case.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index a9b9bb4..f02b248 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -578,12 +578,20 @@ static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
>  {
>  	unsigned short addr;
>  	unsigned int data;
> +	int ret;
> +
> +	if (unlikely(!priv->host_notify))
> +		goto out;

This covers the case where you get an interrupt before the handler is
installed. Good catch, I never considered it.

>  
>  	addr = inb_p(SMBNTFDADD(priv)) >> 1;
>  	data = inw_p(SMBNTFDDAT(priv));
>  
> -	i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
> +	ret = i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
> +	if (ret < 0)
> +		dev_warn(&priv->pci_dev->dev,
> +			 "Host Notify handling failed: %d\n", ret);
>  
> +out:
>  	/* clear Host Notify bit and return */
>  	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
>  	return IRQ_HANDLED;

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
