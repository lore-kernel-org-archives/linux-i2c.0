From: Eudean Sun <eudean-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: utilize hardware semaphore
Date: Fri, 2 Nov 2012 00:01:38 +0000 (UTC)
Message-ID: <loom.20121102T005401-899@post.gmane.org>
References: <12c67a1f-9634-4fd7-bce8-bcb661cb3064@zimbra> <489e78bb-0678-4593-9888-70a8667d8cda@zimbra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Aaron Sierra <asierra@...> writes:

> 
> The i2c-i801 driver (along with 12 others) was modified to include a check
> for ACPI resource conflicts by the following commit prior to 2.6.27
> release:
> 
>     commit 54fb4a05af0a4b814e6716cfdf3fa97fc6be7a32
>     i2c: Check for ACPI resource conflicts
> 

Thanks for posting this Aaron.

> +	if (status & SMBHSTSTS_INUSE_STS) {
> +		dev_err(&priv->pci_dev->dev, "SMBus is in use, can't use it!\n");
> +		return -EBUSY;
> +	}
> +
> +        return 0;
> +}

Noticed there are spaces rather than tabs indenting the return 0 above. Looks 
good otherwise.

Eudean
