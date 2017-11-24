From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Fix Failed to allocate irq -2147483648 error
Date: Fri, 24 Nov 2017 14:49:57 +0100
Message-ID: <20171124144957.6a7323cc@endymion>
References: <20171122112817.9554-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171122112817.9554-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Hans,

On Wed, 22 Nov 2017 12:28:17 +0100, Hans de Goede wrote:
> On Apollo Lake devices the BIOS does not set up IRQ routing for the i801
> SMBUS controller IRQ, so we end up with dev->irq set to IRQ_NOTCONNECTED.
> 
> Detect this and do not try to use the irq in this case silencing:
> i801_smbus 0000:00:1f.1: Failed to allocate irq -2147483648: -107

Isn't it a BIOS bug?

> Cc: stable@vger.kernel.org
> BugLink: https://communities.intel.com/thread/114759
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 9e12a53ef7b8..8eac00efadc1 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1617,6 +1617,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	/* Default timeout in interrupt mode: 200 ms */
>  	priv->adapter.timeout = HZ / 5;
>  
> +	if (dev->irq == IRQ_NOTCONNECTED)
> +		priv->features &= ~FEATURE_IRQ;
> +
>  	if (priv->features & FEATURE_IRQ) {
>  		u16 pcictl, pcists;

Certainly better than returning a cryptic error message, so:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

However if this is considered a BIOS bug then a pr_err(FW_BUG...) would
be good to add IMHO.

-- 
Jean Delvare
SUSE L3 Support
