From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/5] i2c: i801: minor formatting issues
Date: Fri, 29 Jul 2016 11:13:02 +0200
Message-ID: <20160729111302.7c991de7@endymion>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
	<1469699443-22129-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48737 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbcG2JNF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jul 2016 05:13:05 -0400
In-Reply-To: <1469699443-22129-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 28 Jul 2016 11:50:40 +0200, Benjamin Tissoires wrote:
> No functional changes, just typos and remove unused #define.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index cde9a7c..80d67b8 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -186,10 +186,10 @@
>  #define SMBHSTSTS_INTR		0x02
>  #define SMBHSTSTS_HOST_BUSY	0x01
>  
> -/* Host Notify Status registers bits */
> +/* Host Notify Status register bits */
>  #define SMBSLVSTS_HST_NTFY_STS	1
>  
> -/* Host Notify Command registers bits */
> +/* Host Notify Command register bits */
>  #define SMBSLVCMD_HST_NTFY_INTREN	0x01
>  
>  #define STATUS_ERROR_FLAGS	(SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | \
> @@ -269,8 +269,6 @@ struct i801_priv {
>  	struct smbus_host_notify *host_notify;
>  };
>  
> -#define SMBHSTNTFY_SIZE		8
> -
>  #define FEATURE_SMBUS_PEC	(1 << 0)
>  #define FEATURE_BLOCK_BUFFER	(1 << 1)
>  #define FEATURE_BLOCK_PROC	(1 << 2)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
