From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC PATCH 10/12] media: pci: cx18: convert to
 i2c_new_scanned_device
Date: Wed, 6 Nov 2019 12:23:01 +0100
Message-ID: <f9cb0a3e-8f81-c641-0f32-1dc2ae2531a4@xs4all.nl>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-11-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-11-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Andy Walls <awalls@md.metrocast.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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
>  drivers/media/pci/cx18/cx18-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/cx18/cx18-i2c.c b/drivers/media/pci/cx18/cx18-i2c.c
> index 1ef7ccf4a722..a83435245251 100644
> --- a/drivers/media/pci/cx18/cx18-i2c.c
> +++ b/drivers/media/pci/cx18/cx18-i2c.c
> @@ -88,7 +88,7 @@ static int cx18_i2c_new_ir(struct cx18 *cx, struct i2c_adapter *adap, u32 hw,
>  		break;
>  	}
>  
> -	return i2c_new_probed_device(adap, &info, addr_list, NULL) == NULL ?
> +	return IS_ERR(i2c_new_scanned_device(adap, &info, addr_list, NULL)) ?
>  	       -1 : 0;
>  }
>  
> 
