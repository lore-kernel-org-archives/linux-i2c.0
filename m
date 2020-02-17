From: Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH 1/3] i2c: convert SMBus alert setup function to return an
 ERRPTR
Date: Mon, 17 Feb 2020 08:58:39 +0100
Message-ID: <20200217075837.2agub5deqdpet3ce@rric.localdomain>
References: <20200210172929.6001-1-wsa+renesas@sang-engineering.com>
 <20200210172929.6001-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200210172929.6001-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, George Cherian <gcherian@marvell.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 10.02.20 18:29:25, Wolfram Sang wrote:
> Only few drivers use this call, so drivers and I2C core are converted at
> once with this patch. By simply using i2c_new_client_device() instead of
> i2c_new_device(), we easily can return an ERRPTR for this function as
> well. To make out of tree users aware that something changed, the
> function is renamed to i2c_install_smbus_alert().
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> -struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
> +struct i2c_client *i2c_install_smbus_alert(struct i2c_adapter *adapter,
>  					 struct i2c_smbus_alert_setup *setup);

This function naming is a bit odd. It creates a struct i2c_client.
Then, there is also i2c_new_client_device() and i2c_new_device(). For
i2c_new_client_device() there are no users at all outside of
i2c-core-base.c (except for Falcon NIC), it is only a wrapper.

So how about reducing the interface to those both only to:?

 i2c_new_device()
 i2c_new_device_smbus()

To avoid a namespace collision it could also get new names using
*_create_*.

Thanks,

-Robert
