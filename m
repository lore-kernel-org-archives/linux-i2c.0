From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v3 3/3] eeprom: at24: enable runtime pm support
Date: Wed, 30 Aug 2017 15:41:23 +0300
Message-ID: <20170830124122.3oipo4ykpzmkzdy2@valkosipuli.retiisi.org.uk>
References: <1504066266-30051-1-git-send-email-divagar.mohandass@intel.com>
 <1504066266-30051-4-git-send-email-divagar.mohandass@intel.com>
 <20170830075329.cyhzitpfwojq3aox@valkosipuli.retiisi.org.uk>
 <7B8CE47BD58441468D2BB13285B50E6031DE621E@BGSMSX107.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7B8CE47BD58441468D2BB13285B50E6031DE621E-yHIBzpp8AekLtBVenmexd7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 30, 2017 at 12:32:07PM +0000, Mohandass, Divagar wrote:
> >> @@ -743,6 +770,15 @@ static int at24_probe(struct i2c_client *client,
> >> const struct i2c_device_id *id)
> >>
> >>  	i2c_set_clientdata(client, at24);
> >>
> >> +	/* enable runtime pm */
> >> +	pm_runtime_get_noresume(&client->dev);
> >> +	err = pm_runtime_set_active(&client->dev);
> >> +	if (err < 0)
> >> +		goto err_clients;
> >> +
> >> +	pm_runtime_enable(&client->dev);
> >> +	pm_runtime_put(&client->dev);
> >> +
> >
> >You're just about to perform a read here. I believe you should move the last
> >put after that.
> 
> At the end of at24_read we are performing a pm_runtime_put, still we need this change ?

True, so this isn't an actual problem.

It'll still power the chip down when you're about to need it, so it'd make
sense to perform the check before pm_runtime_put().

I might move the runtime PM setup after the check altogether.

-- 
Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
