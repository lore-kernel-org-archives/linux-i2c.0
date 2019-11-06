From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC PATCH 08/12] media: pci: cx88: convert to
 i2c_new_scanned_device
Date: Wed, 6 Nov 2019 12:18:28 +0100
Message-ID: <faa29a3b-c939-eec3-355e-8c0ddc873391@xs4all.nl>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-9-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-9-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 11/6/19 10:50 AM, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

This commit text is a bit out-of-sync with the actual patch.

This should be improved for the next version. Looks good otherwise.

Regards,

	Hans

> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. RFC, please comment and/or ack, but don't apply yet.
> 
>  drivers/media/pci/cx88/cx88-input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/cx88-input.c
> index 589f52d961eb..c7c2acd55266 100644
> --- a/drivers/media/pci/cx88/cx88-input.c
> +++ b/drivers/media/pci/cx88/cx88-input.c
> @@ -613,7 +613,7 @@ void cx88_i2c_init_ir(struct cx88_core *core)
>  	}
>  
>  	/*
> -	 * We can't call i2c_new_probed_device() because it uses
> +	 * We can't call i2c_new_scanned_device() because it uses
>  	 * quick writes for probing and at least some RC receiver
>  	 * devices only reply to reads.
>  	 * Also, Hauppauge XVR needs to be specified, as address 0x71
> 
