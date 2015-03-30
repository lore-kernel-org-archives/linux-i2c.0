From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 02/86] i2c/i801: linux/pci_ids.h -> uapi/linux/pci_ids.h
Date: Mon, 30 Mar 2015 09:31:46 +0200
Message-ID: <20150330093146.589817f5@endymion.delvare>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
	<1427635734-24786-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1427635734-24786-3-git-send-email-mst@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 29 Mar 2015 15:37:30 +0200, Michael S. Tsirkin wrote:
> Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
> update i2c documentation accordingly.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Documentation/i2c/busses/i2c-i801 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
> index 82f48f7..8036644 100644
> --- a/Documentation/i2c/busses/i2c-i801
> +++ b/Documentation/i2c/busses/i2c-i801
> @@ -141,7 +141,7 @@ host bridge PCI device. Get yours with "lspci -n -v -s 00:00.0":
>  
>  Here the host bridge ID is 2570 (82865G/PE/P), the subvendor ID is 1043
>  (Asus) and the subdevice ID is 80f2 (P4P800-X). You can find the symbolic
> -names for the bridge ID and the subvendor ID in include/linux/pci_ids.h,
> +names for the bridge ID and the subvendor ID in include/uapi/linux/pci_ids.h,
>  and then add a case for your subdevice ID at the right place in
>  drivers/pci/quirks.c. Then please give it very good testing, to make sure
>  that the unhidden SMBus doesn't conflict with e.g. ACPI.

No objection from me.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
