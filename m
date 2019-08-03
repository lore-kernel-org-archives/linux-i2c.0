From: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/2] media: ir-kbd-i2c: convert to
 i2c_new_dummy_device()
Date: Sat, 3 Aug 2019 13:17:49 -0300
Message-ID: <20190803131749.4d6517ab@coco.lan>
References: <20190730175555.14098-1-wsa+renesas@sang-engineering.com>
        <20190730175555.14098-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730175555.14098-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Sean Young <sean@mess.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Em Tue, 30 Jul 2019 19:55:54 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> escreveu:

> Convert this driver to use the new i2c_new_dummy_device() call and bail
> out if the dummy device cannot be registered to make failure more
> visible to the user.
> 

Please don't do that.

At first glance, devm_* sounds a good idea, but we had enough issues
using it on media system.

I don't mind mind much if some SoC specific would use it, but doing
it on generic drivers is a very bad idea. We have removed almost all
devm_* calls from the media system.

The problem with devm is that it the de-allocation routines aren't
called during device unbind. They happen a way later, only when the
device itself is physically removed, or the driver is removed.

That caused lots of headaches to debug memory lifetime issues on
media.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since v1:
> 
> * reworded commit message because there was no NULL ptr access
> 
>  drivers/media/i2c/ir-kbd-i2c.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/ir-kbd-i2c.c b/drivers/media/i2c/ir-kbd-i2c.c
> index 876d7587a1da..f46717052efc 100644
> --- a/drivers/media/i2c/ir-kbd-i2c.c
> +++ b/drivers/media/i2c/ir-kbd-i2c.c
> @@ -885,9 +885,12 @@ static int ir_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	INIT_DELAYED_WORK(&ir->work, ir_work);
>  
>  	if (probe_tx) {
> -		ir->tx_c = i2c_new_dummy(client->adapter, 0x70);
> -		if (!ir->tx_c) {
> +		ir->tx_c = devm_i2c_new_dummy_device(&client->dev,
> +						     client->adapter, 0x70);
> +		if (IS_ERR(ir->tx_c)) {
>  			dev_err(&client->dev, "failed to setup tx i2c address");
> +			err = PTR_ERR(ir->tx_c);
> +			goto err_out_free;
>  		} else if (!zilog_init(ir)) {
>  			ir->carrier = 38000;
>  			ir->duty_cycle = 40;
> @@ -904,9 +907,6 @@ static int ir_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	return 0;
>  
>   err_out_free:
> -	if (ir->tx_c)
> -		i2c_unregister_device(ir->tx_c);
> -
>  	/* Only frees rc if it were allocated internally */
>  	rc_free_device(rc);
>  	return err;
> @@ -919,9 +919,6 @@ static int ir_remove(struct i2c_client *client)
>  	/* kill outstanding polls */
>  	cancel_delayed_work_sync(&ir->work);
>  
> -	if (ir->tx_c)
> -		i2c_unregister_device(ir->tx_c);
> -
>  	/* unregister device */
>  	rc_unregister_device(ir->rc);
>  



Thanks,
Mauro
