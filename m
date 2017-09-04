From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v5 3/3] eeprom: at24: enable runtime pm support
Date: Mon, 4 Sep 2017 10:38:51 +0300
Message-ID: <20170904073850.i77nk36k5extin56@valkosipuli.retiisi.org.uk>
References: <1504507245-12902-1-git-send-email-divagar.mohandass@intel.com>
 <1504507245-12902-4-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:54914 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751949AbdIDHiy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Sep 2017 03:38:54 -0400
Content-Disposition: inline
In-Reply-To: <1504507245-12902-4-git-send-email-divagar.mohandass@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com

Hi Divagar,

On Mon, Sep 04, 2017 at 12:10:45PM +0530, Divagar Mohandass wrote:
> Currently the device is kept in D0, there is an opportunity
> to save power by enabling runtime pm.
> 
> Device can be daisy chained from PMIC and we can't rely on I2C core
> for auto resume/suspend. Driver will decide when to resume/suspend.
> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> ---
>  drivers/misc/eeprom/at24.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2199c42..03f5cb7 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -750,9 +782,12 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	err = at24_read(at24, 0, &test_byte, 1);

You do pm_runtime_put()s here and drop the ones below as it's needed
unconditionally. Then I think we're done.

>  	if (err) {
>  		err = -ENODEV;
> +		pm_runtime_put(&client->dev);
>  		goto err_clients;
>  	}
>  
> +	pm_runtime_put(&client->dev);
> +
>  	at24->nvmem_config.name = dev_name(&client->dev);
>  	at24->nvmem_config.dev = &client->dev;
>  	at24->nvmem_config.read_only = !writable;

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
