From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 39/86] i2c/i801: use uapi/linux/pci_ids.h directly
Date: Mon, 30 Mar 2015 09:32:22 +0200
Message-ID: <20150330093222.3006d3c8@endymion.delvare>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
	<1427635734-24786-40-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427635734-24786-40-git-send-email-mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 29 Mar 2015 15:40:42 +0200, Michael S. Tsirkin wrote:
> Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
> use the new header directly so we can drop
> the wrapper in include/linux/pci_ids.h.
> 
> Signed-off-by: Michael S. Tsirkin <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 8fafb25..948a1a2 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -164,7 +164,7 @@
>  #define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_INTR | \
>  				 STATUS_ERROR_FLAGS)
>  
> -/* Older devices have their ID defined in <linux/pci_ids.h> */
> +/* Older devices have their ID defined in <uapi/linux/pci_ids.h> */
>  #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
>  #define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
>  #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS		0x1c22

No objection from me.

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>


-- 
Jean Delvare
SUSE L3 Support
