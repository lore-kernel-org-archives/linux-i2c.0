From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 6/9] i2c-designware: move controller config to bus specific
 portion of driver
Date: Tue, 25 Jan 2011 11:22:33 +0900
Message-ID: <4D3E33E9.3010306@renesas.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
 <1295033256-30077-7-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1295033256-30077-7-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 1/15/2011 4:27 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> With multiple I2C adapters possible in the system each running at
> (possibly) different speeds we need to move the controller
> configuration bit field to the adapter.

This is also a good first step to support per-bus basis I2C bus-speed
configuration, because current i2c-designware driver is going to
configure all I2C busses with the same speed settings, unfortunately.

> @@ -375,6 +373,7 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
>  		return -EIO;
>  }
>  
> +
>  /*
>   * Prepare controller for a transaction and call i2c_dw_xfer_msg
>   */

!

> @@ -212,7 +214,6 @@ const struct pci_device_id *id)
>  
>  	i2c_dw_init(dev);
>  
> -
>  	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;

!

As talked with Dirk-san before, this patch improves a situation at
PCI driver side only, and we need to come up with a way for platform
side in the future!
-- 
Shinya Kuribayashi
Renesas Electronics
