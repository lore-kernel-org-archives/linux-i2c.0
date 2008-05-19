From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/1] i2c: align i2c_device_id
Date: Mon, 19 May 2008 21:00:03 +0200
Message-ID: <20080519210003.65b65d14@hyperion.delvare>
References: <1211203124-3096-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754534AbYESTAa@vger.kernel.org>
In-Reply-To: <1211203124-3096-1-git-send-email-jirislaby@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jiri,

On Mon, 19 May 2008 15:18:44 +0200, Jiri Slaby wrote:
> Align i2c_device_id.driver_data to 8 bytes to not fail on crossbuilds.
> 
> (Added in d2653e92732bd3911feff6bee5e23dbf959381db.)
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  include/linux/mod_devicetable.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index a37db57..1fd03e7 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -384,7 +384,8 @@ struct virtio_device_id {
>  
>  struct i2c_device_id {
>  	char name[I2C_NAME_SIZE];
> -	kernel_ulong_t driver_data;	/* Data private to the driver */
> +	kernel_ulong_t driver_data	/* Data private to the driver */
> +			__attribute__((aligned(sizeof(kernel_ulong_t))));
>  };
>  

Thanks for this patch, it's in my i2c tree now and will be sent to
Linus by the end of the week. I wasn't aware of this possible alignment
issue, sorry.

-- 
Jean Delvare
