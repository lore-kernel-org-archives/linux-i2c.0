From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] of: i2c: Add DT bindings for idle states to PCA954x mux driver
Date: Tue, 16 Dec 2014 15:38:28 +0200
Message-ID: <3857435.mVCtkYnmde@avalon>
References: <548E387E.2020502@nsn.com> <5722849.lDq3gpSIfD@avalon> <54902A49.7030804@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54902A49.7030804-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alexander,

On Tuesday 16 December 2014 13:49:13 Alexander Sverdlin wrote:
> On 16/12/14 12:07, ext Laurent Pinchart wrote:
> >>>> of: i2c: Add DT bindings for idle states to PCA954x mux driver
> >>>> 
> >>>> Introduce two new device tree bindings to specify idle state of PCA954x
> >>>> 
> >>>> family of I2C multiplexors:
> >>>>   - idle-state: specifies particular child bus to be selected in idle;
> >>>>   - idle-disconnect: signals that mux should disconnect all child buses
> >>>>   in idle;
> >>> 
> >>> Could you please briefly explain your use case(s) for those two
> >>> properties ?
> >> 
> >> idle-state specifies which bus will be connected when there is no data
> >> transfer. i2c-mux-gpio also has "idle-state" (though, it can replace both
> >> connect and disconnect cases in my patch). i2c-mux-pinctrl has special
> >> "idle" convention, specifying idle state as last in the list of states.
> >> Again, it can serve for both my properties.
> >> 
> >> idle-disconnect is what we actually use for some security reasons (so
> >> that I2C bus of the external SFP cage is not connected to the rest of I2C
> >> bus in idle).
> > 
> > Thank you for the explanation. I would add it to the DT bindings
> > documentation, or at least to the commit message.
> 
> Ok, I'll send v2 with all your comments addressed.

Thank you.

> > I understand the use cases of the idle-disconnect property. What do you
> > use idle-state for, when the idle state is different from disconnecting
> > the bus ?
>
> We do not have a use case for that. It was done only for the sake of
> completeness. Because other MUXes actually offer user this possibility. I
> was initially thinking about providing this on i2c-mux level for all of
> them, but unfortunately they all use deselect callback in different way and
> pinctrl is the worst case, as idle state cannot be represented with an int,
> but should be a pointer.
> 
> Anyway, if you think there is no use-case for this, I can drop this part.

Adding a DT property without a clear use case usually makes me a bit wary. I 
would thus prefer going for either idle-disconnect alone, or for an idle-state 
property that would allow selecting disconnection as one of the possible 
values.
 
> >>>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
> >>>> ---
> >>>> 
> >>>>  .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |    3 +
> >>>>  drivers/i2c/muxes/i2c-mux-pca954x.c                |   51
> >>>>  ++++++++++++--
> >>>>  2 files changed, 48 insertions(+), 6 deletions(-)
> >>>> 
> >>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> >>>> b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt index
> >>>> 34a3fb6..1fbe287 100644
> >>>> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> >>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> >>>> 
> >>>> @@ -16,6 +16,9 @@ Required Properties:
> >>>>  Optional Properties:
> >>>>    - reset-gpios: Reference to the GPIO connected to the reset input.
> >>>> 
> >>>> +  - idle-state: Child bus connected in idle state (specified by its
> >>>> "reg" value)
> >>>> +  - idle-disconnect: Boolean; if defined, forces mux to disconnect all
> >>>> children
> >>>> +    in idle state
> >>>> 
> >>>>  Example:
> >>>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c
> >>>> b/drivers/i2c/muxes/i2c-mux-pca954x.c index ec11b40..69cf603 100644
> >>>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> >>>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> >>>> @@ -43,6 +43,7 @@
> >>>> 
> >>>>  #include <linux/module.h>
> >>>>  #include <linux/pm.h>
> >>>>  #include <linux/slab.h>
> >>>> 
> >>>> +#include <linux/of.h>
> >>> 
> >>> Could you please keep headers sorted alphabetically ?
> >> 
> >> Yes...
> >> 
> >>>>  #define PCA954X_MAX_NCHANS 8
> >>>> 
> >>>> @@ -62,6 +63,8 @@ struct pca954x {
> >>>> 
> >>>>  	struct i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
> >>>>  	
> >>>>  	u8 last_chan;		/* last register value */
> >>>> 
> >>>> +	bool idle_disconnect;
> >>>> +	s8 idle_chan;		/* valid if not negative */
> >>>> 
> >>>>  };
> >>>>  
> >>>>  struct chip_desc {
> >>>> 
> >>>> @@ -172,10 +175,20 @@ static int pca954x_deselect_mux(struct
> >>>> i2c_adapter
> >>>> *adap, void *client, u32 chan)
> >>>> 
> >>>>  {
> >>>>  
> >>>>  	struct pca954x *data = i2c_get_clientdata(client);
> >>>> 
> >>>> +	struct pca954x_platform_data *pdata =
> >>>> +		dev_get_platdata(&((struct i2c_client *)client)->dev);
> >>>> +
> >>>> +	if ((pdata && pdata->modes[chan].deselect_on_exit) ||
> >>>> +	    data->idle_disconnect) {
> >>> 
> >>> I would copy pdata->modes[chan].deselect_on_exit to
> >>> data->idle_disconnect in the probe function, so you could avoiding
> >>> accessing pdata here.
> >> 
> >> Unfortunately, this pdata has different (per-channel) semantics. I cannot
> >> really understand, why it was done this way, but anyway it's not possible
> >> to use one global bit to represent per-channel bits without changing the
> >> behavior.
> >> 
> >> I'm not keen to brake out-of-tree code (if any), but may be it will be
> >> decided to drop this per-channel deselect_on_exit, because it's not used
> >> at least in the kernel tree...
> > 
> > I'd vote for removing deselect_on_exit from platform data, but I won't
> > insist.
>
> Then it should be a separate patch, probably... I can send a series removing
> pdata pits and adding a DT binding.
> 
> >>>> +		/* Deselect active channel */
> >>>> +		data->last_chan = 0;
> >>>> +		return pca954x_reg_write(adap, client, data->last_chan);
> >>>> +	}
> >>>> 
> >>>> -	/* Deselect active channel */
> >>>> -	data->last_chan = 0;
> >>>> -	return pca954x_reg_write(adap, client, data->last_chan);
> >>>> +	if (data->idle_chan >= 0)
> >>>> +		return pca954x_select_chan(adap, client, data->idle_chan);
> >>>> +
> >>>> +	return 0;
> >>>> 
> >>>>  }
> >>>>  
> >>>>  /*
> >>>> 
> >>>> @@ -186,6 +199,7 @@ static int pca954x_probe(struct i2c_client *client,
> >>>> 
> >>>>  {
> >>>>  
> >>>>  	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
> >>>>  	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
> >>>> 
> >>>> +	struct device_node *of_node = client->dev.of_node;
> >>>> 
> >>>>  	struct gpio_desc *gpio;
> >>>>  	int num, force, class;
> >>>>  	struct pca954x *data;
> >>>> 
> >>>> @@ -216,6 +230,27 @@ static int pca954x_probe(struct i2c_client
> >>>> *client,
> >>>> 
> >>>>  	data->type = id->driver_data;
> >>>>  	data->last_chan = 0;		   /* force the first selection */
> >>>> 
> >>>> +	data->idle_chan = -1;		   /* no forced idle state */
> >>>> +
> >>>> +	if (of_node) {
> >>>> +		u32 ch;
> >>>> +
> >>>> +		if (of_property_read_bool(of_node, "idle-disconnect"))
> >>>> +			data->idle_disconnect = true;
> >>>> +
> >>>> +		if (!of_property_read_u32_index(of_node, "idle-state", 0, &ch)) {
> >>>> +			if (ch < PCA954X_MAX_NCHANS) {
> >>>> +				data->idle_chan = ch;
> >>>> +				/* Force idle state from the beginning */
> >>>> +				ret = pca954x_select_chan(adap, client, ch);
> >>>> +				if (ret)
> >>>> +					return ret;
> >>>> +			} else {
> >>>> +				dev_warn(&client->dev,
> >>>> +				         "Invalid idle-state property\n");
> >>>> +			}
> >>>> +		}
> >>>> +	}
> >>>> 
> >>>>  	/* Now create an adapter for each channel */
> >>>>  	for (num = 0; num < chips[data->type].nchans; num++) {
> >>>> 
> >>>> @@ -234,8 +269,7 @@ static int pca954x_probe(struct i2c_client *client,
> >>>> 
> >>>>  		data->virt_adaps[num] =
> >>>>  		
> >>>>  			i2c_add_mux_adapter(adap, &client->dev, client,
> >>>>  			
> >>>>  				force, num, class, pca954x_select_chan,
> >>>> 
> >>>> -				(pdata && pdata->modes[num].deselect_on_exit)
> >>>> -					? pca954x_deselect_mux : NULL);
> >>>> +				pca954x_deselect_mux);
> >>>> 
> >>>>  		if (data->virt_adaps[num] == NULL) {
> >>>>  		
> >>>>  			ret = -ENODEV;
> >>>> 
> >>>> @@ -281,7 +315,12 @@ static int pca954x_resume(struct device *dev)
> >>>> 
> >>>>  	struct pca954x *data = i2c_get_clientdata(client);
> >>>>  	
> >>>>  	data->last_chan = 0;
> >>>> 
> >>>> -	return i2c_smbus_write_byte(client, 0);
> >>>> +	/* Restore idle state on resume */
> >>>> +	if (data->idle_chan >= 0)
> >>>> +		return pca954x_select_chan(to_i2c_adapter(client->dev.parent),
> >>>> +		                           client, data->idle_chan);
> >>>> +	else
> >>>> +		return i2c_smbus_write_byte(client, 0);
> >>>> 
> >>>>  }
> >>>>  #endif

-- 
Regards,

Laurent Pinchart
