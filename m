From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC PATCH 07/12] media: pci: cx23885: convert to
 i2c_new_scanned_device
Date: Wed, 6 Nov 2019 12:18:56 +0100
Message-ID: <f22a6c45-2015-ba78-7dce-f7b2ad3f7740@xs4all.nl>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-8-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-8-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 11/6/19 10:50 AM, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
> 
> Build tested only. RFC, please comment and/or ack, but don't apply yet.
> 
>  drivers/media/pci/cx23885/cx23885-i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/cx23885/cx23885-i2c.c b/drivers/media/pci/cx23885/cx23885-i2c.c
> index 4f327ee9659e..f51fad33dc04 100644
> --- a/drivers/media/pci/cx23885/cx23885-i2c.c
> +++ b/drivers/media/pci/cx23885/cx23885-i2c.c
> @@ -337,8 +337,8 @@ int cx23885_i2c_register(struct cx23885_i2c *bus)
>  		strscpy(info.type, "ir_video", I2C_NAME_SIZE);
>  		/* Use quick read command for probe, some IR chips don't
>  		 * support writes */
> -		i2c_new_probed_device(&bus->i2c_adap, &info, addr_list,
> -				      i2c_probe_func_quick_read);
> +		i2c_new_scanned_device(&bus->i2c_adap, &info, addr_list,
> +				       i2c_probe_func_quick_read);
>  	}
>  
>  	return bus->i2c_rc;
> 
