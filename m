From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v4 3/3] eeprom: at24: enable runtime pm support
Date: Thu, 31 Aug 2017 18:37:02 +0300
Message-ID: <20170831153702.eeilqwdxsoy4e3vt@valkosipuli.retiisi.org.uk>
References: <1504112740-14072-1-git-send-email-divagar.mohandass@intel.com>
 <1504112740-14072-4-git-send-email-divagar.mohandass@intel.com>
 <20170830211938.3m4xdwlfq5yozymq@valkosipuli.retiisi.org.uk>
 <7B8CE47BD58441468D2BB13285B50E6031DE6BFC@BGSMSX107.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7B8CE47BD58441468D2BB13285B50E6031DE6BFC@BGSMSX107.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mohandass, Divagar" <divagar.mohandass@intel.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mani, Rajmohan" <rajmohan.mani@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 31, 2017 at 11:24:38AM +0000, Mohandass, Divagar wrote:
> >> @@ -743,6 +770,14 @@ static int at24_probe(struct i2c_client *client,
> >> const struct i2c_device_id *id)
> >>
> >>  	i2c_set_clientdata(client, at24);
> >>
> >> +	/* enable runtime pm */
> >> +	pm_runtime_get_noresume(&client->dev);
> >> +	err = pm_runtime_set_active(&client->dev);
> >> +	if (err < 0)
> >> +		goto err_clients;
> >
> >Btw. I don't think pm_runtime_set_active() can fail here. In other words it'd be
> >fine to ignore the return value.
> >
> 
> Ack
> 
> 
> >> +
> >> +	pm_runtime_enable(&client->dev);
> >> +
> >>  	/*
> >>  	 * Perform a one-byte test read to verify that the
> >>  	 * chip is functional.
> >> @@ -753,6 +788,8 @@ static int at24_probe(struct i2c_client *client, const
> >struct i2c_device_id *id)
> >>  		goto err_clients;
> >
> >I suppose the runtime PM state is re-initialised for a device when a driver is
> >probed, but it'd still be nice to decrement the use count if this fails.
> 
> Ack
> 
> >You should also disable PM runtime if probe fails and set the device
> >suspended again.
> >
> >Same for other error cases. I think you'll need a new label.
> >
> 
> Can I disable PM runtime and set suspend in the 'err_clients' label itself ?

Disable, yes, but the get and put calls need to be balanced.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
