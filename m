From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] eeprom: at24: check the return value of
 nvmem_unregister()
Date: Thu, 28 Dec 2017 12:28:45 +0100
Message-ID: <20171228112845.GB3729@localhost>
References: <20171227141038.31646-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33721 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdL1L2s (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Dec 2017 06:28:48 -0500
Content-Disposition: inline
In-Reply-To: <20171227141038.31646-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 27, 2017 at 03:10:38PM +0100, Bartosz Golaszewski wrote:
> This function can fail with -EBUSY, but we don't check its return
> value in at24_remove(). Bail-out of remove() if nvmem_unregister()
> doesn't succeed.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index e79833d62284..fb21e1c45115 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -684,11 +684,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  static int at24_remove(struct i2c_client *client)
>  {
>  	struct at24_data *at24;
> -	int i;
> +	int i, ret;
>  
>  	at24 = i2c_get_clientdata(client);
>  
> -	nvmem_unregister(at24->nvmem);
> +	ret = nvmem_unregister(at24->nvmem);
> +	if (ret)
> +		return ret;

I don't this makes much sense as a driver cannot refuse an unbind by
returning an errno from remove(). The return value is simply ignored,
remove() will never be called again, and you'd leave everything in an
inconsistent state.

It looks like the nvmem code grabs a reference to the owning module
in __nvmem_device_get() which would at least prevent a module unload
while another driver is using the device. And the (sysfs) userspace
interface should be fine as device removal is handled by the kernfs
code.

>  	for (i = 1; i < at24->num_addresses; i++)
>  		i2c_unregister_device(at24->client[i].client);

Johan
