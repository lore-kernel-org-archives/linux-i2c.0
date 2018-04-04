From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Date: Wed, 4 Apr 2018 22:56:43 +0200
Message-ID: <20180404225643.6b40782f@endymion>
References: <20180402122536.5083-1-jandryuk@gmail.com>
        <20180402123435.5587-1-jandryuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402123435.5587-1-jandryuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, benjamin.tissoires@redhat.com, andyrtr@archlinux.org, aduggan@synaptics.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jason,

On Mon,  2 Apr 2018 08:34:35 -0400, Jason Andryuk wrote:
> The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
> hangs while plugged in if Linux enables the Host Notify features of
> i2c-i801.  The cold boot hang depends on how the system boots.  It does
> not hang on UEFI Grub text boot or legacy Grub text boot.  But it does
> hang on legacy Grub graphical boot and Intel Boot Agent PXE text boot.
> Booting unplugged is not affected.
> 
> Disabling the Host Notify feature with disable_feature=0x20 works around
> the bug, so automatically do so based on DMI information.
> 
> More information can be found here:
> https://www.spinics.net/lists/linux-i2c/msg33938.html
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> I only added my machine to the blacklist, since it's the only one I've
> tested.  More systems can be added when identified and tested.
> 
> v2: Fix open brace on function definition
> 
>  drivers/i2c/busses/i2c-i801.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 692b34125866..3e8e613c0801 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1042,6 +1042,25 @@ static const struct pci_device_id i801_ids[] = {
>  MODULE_DEVICE_TABLE(pci, i801_ids);
>  
>  #if defined CONFIG_X86 && defined CONFIG_DMI
> +static const struct dmi_system_id host_notify_dmi_blacklist[] = {
> +	{
> +		.ident = "HP EliteBook G3 850",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 850 G3"),

Please consider using DMI_EXACT_MATCH if possible, as it is faster.

> +		},
> +	},
> +};

Arrays passed to dmi_check_system must be terminated with an empty
element.

> +
> +static void blacklist_features(struct i801_priv *priv)
> +{
> +	if (dmi_check_system(host_notify_dmi_blacklist)) {
> +		dev_warn(&priv->pci_dev->dev,
> +			 "SMBus Host Notify disabled on this system");
> +		priv->features &= ~FEATURE_HOST_NOTIFY;
> +	}
> +}
> +
>  static unsigned char apanel_addr;
>  
>  /* Scan the system ROM for the signature "FJKEYINF" */
> @@ -1159,6 +1178,7 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
>  #else
>  static void __init input_apanel_init(void) {}
>  static void i801_probe_optional_slaves(struct i801_priv *priv) {}
> +static void blacklist_features(struct i801_priv *priv) {}
>  #endif	/* CONFIG_X86 && CONFIG_DMI */
>  
>  #if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
> @@ -1562,6 +1582,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  				   i801_feature_names[i]);
>  	}
>  	priv->features &= ~disable_features;
> +	blacklist_features(priv);
>  
>  	err = pcim_enable_device(dev);
>  	if (err) {

Other than that, it looks good to me.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
