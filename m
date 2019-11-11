From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 06/12] input: mouse: convert to i2c_new_scanned_device
Date: Mon, 11 Nov 2019 10:19:41 -0800
Message-ID: <20191111181941.GB57214@dtor-ws>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191106095033.25182-7-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 06, 2019 at 10:50:24AM +0100, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. RFC, please comment and/or ack, but don't apply yet.
> 
>  drivers/input/mouse/psmouse-smbus.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
> index 027efdd2b2ad..35bf50a871d2 100644
> --- a/drivers/input/mouse/psmouse-smbus.c
> +++ b/drivers/input/mouse/psmouse-smbus.c
> @@ -198,10 +198,12 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HOST_NOTIFY))
>  		return 0;
>  
> -	smbdev->client = i2c_new_probed_device(adapter, &smbdev->board,
> -					       addr_list, NULL);
> -	if (!smbdev->client)
> +	smbdev->client = i2c_new_scanned_device(adapter, &smbdev->board,
> +					        addr_list, NULL);
> +	if (IS_ERR(smbdev->client)) {
> +		smbdev->client = NULL;
>  		return 0;
> +	}
>  
>  	/* We have our(?) device, stop iterating i2c bus. */
>  	return 1;

I'd prefer postponing assignment until after we get valid value. I.e.

	client = i2c_new_probed_device(...);
	if (IS_ERR(client))
		return 0;

	/* We have our(?) device, stop iterating i2c bus. */
	smbdev->client = client;
	return 1;

Thanks.

-- 
Dmitry
