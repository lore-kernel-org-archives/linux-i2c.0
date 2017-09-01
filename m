From: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4 3/3] eeprom: at24: enable runtime pm support
Date: Fri, 1 Sep 2017 18:26:47 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DE74AB@BGSMSX107.gar.corp.intel.com>
References: <1504112740-14072-1-git-send-email-divagar.mohandass@intel.com>
 <1504112740-14072-4-git-send-email-divagar.mohandass@intel.com>
 <20170830211938.3m4xdwlfq5yozymq@valkosipuli.retiisi.org.uk>
 <7B8CE47BD58441468D2BB13285B50E6031DE6BFC@BGSMSX107.gar.corp.intel.com>
 <20170831153702.eeilqwdxsoy4e3vt@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170831153702.eeilqwdxsoy4e3vt-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sakari,

Thanks for the review.
My comments below.

---
^Divagar

>-----Original Message-----
>From: Sakari Ailus [mailto:sakari.ailus-X3B1VOXEql0@public.gmane.org]
>Sent: Thursday, August 31, 2017 9:07 PM
>To: Mohandass, Divagar <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org;
>devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Subject: Re: [PATCH v4 3/3] eeprom: at24: enable runtime pm support
>
>On Thu, Aug 31, 2017 at 11:24:38AM +0000, Mohandass, Divagar wrote:
>> >> @@ -743,6 +770,14 @@ static int at24_probe(struct i2c_client
>> >> *client, const struct i2c_device_id *id)
>> >>
>> >>  	i2c_set_clientdata(client, at24);
>> >>
>> >> +	/* enable runtime pm */
>> >> +	pm_runtime_get_noresume(&client->dev);
>> >> +	err = pm_runtime_set_active(&client->dev);
>> >> +	if (err < 0)
>> >> +		goto err_clients;
>> >
>> >Btw. I don't think pm_runtime_set_active() can fail here. In other
>> >words it'd be fine to ignore the return value.
>> >
>>
>> Ack
>>
>>
>> >> +
>> >> +	pm_runtime_enable(&client->dev);
>> >> +
>> >>  	/*
>> >>  	 * Perform a one-byte test read to verify that the
>> >>  	 * chip is functional.
>> >> @@ -753,6 +788,8 @@ static int at24_probe(struct i2c_client
>> >> *client, const
>> >struct i2c_device_id *id)
>> >>  		goto err_clients;
>> >
>> >I suppose the runtime PM state is re-initialised for a device when a
>> >driver is probed, but it'd still be nice to decrement the use count if this
>fails.
>>
>> Ack
>>
>> >You should also disable PM runtime if probe fails and set the device
>> >suspended again.
>> >
>> >Same for other error cases. I think you'll need a new label.
>> >
>>
>> Can I disable PM runtime and set suspend in the 'err_clients' label itself ?
>
>Disable, yes, but the get and put calls need to be balanced.

We are performing pm_runtime_put after the first read check and in the error condition, so PM runtime disable alone should be sufficient in the 'err_clients' label.
I think it is balanced, your comments ?

>
>--
>Sakari Ailus
>e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
