From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC PATCH 09/12] media: pci: bt8xx: convert to
 i2c_new_scanned_device
Date: Wed, 6 Nov 2019 12:19:44 +0100
Message-ID: <f5b078aa-73c7-993a-7221-98962a13ab23@xs4all.nl>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-10-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-10-wsa+renesas@sang-engineering.com>
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
>  drivers/media/pci/bt8xx/bttv-input.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/pci/bt8xx/bttv-input.c b/drivers/media/pci/bt8xx/bttv-input.c
> index 492bc85c2700..41226f1d0e5b 100644
> --- a/drivers/media/pci/bt8xx/bttv-input.c
> +++ b/drivers/media/pci/bt8xx/bttv-input.c
> @@ -386,7 +386,7 @@ void init_bttv_i2c_ir(struct bttv *btv)
>  
>  	if (btv->init_data.name) {
>  		info.platform_data = &btv->init_data;
> -		i2c_dev = i2c_new_device(&btv->c.i2c_adap, &info);
> +		i2c_dev = i2c_new_client_device(&btv->c.i2c_adap, &info);
>  	} else {
>  		/*
>  		 * The external IR receiver is at i2c address 0x34 (0x35 for
> @@ -396,9 +396,9 @@ void init_bttv_i2c_ir(struct bttv *btv)
>  		 * internal.
>  		 * That's why we probe 0x1a (~0x34) first. CB
>  		 */
> -		i2c_dev = i2c_new_probed_device(&btv->c.i2c_adap, &info, addr_list, NULL);
> +		i2c_dev = i2c_new_scanned_device(&btv->c.i2c_adap, &info, addr_list, NULL);
>  	}
> -	if (NULL == i2c_dev)
> +	if (IS_ERR(i2c_dev))
>  		return;
>  
>  #if defined(CONFIG_MODULES) && defined(MODULE)
> 
