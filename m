From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Sat, 22 Dec 2007 21:08:50 -0800
Message-ID: <200712222108.51292.david-b@pacbell.net>
References: <kOXVGr9s.1198344701.9162110.khali@gcu-squad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <kOXVGr9s.1198344701.9162110.khali-IO4AeUl/lkuWVfeAwA7xHQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 22 December 2007, Jean Delvare wrote:

> > +/**
> > + * i2c_new_dummy - return a new i2c device bound to a dummy driver
> > + * @adapter: the adapter managing the device
> > + * @address: seven bit address to be used
> > + * @type: optional label used for i2c_client.name
> 
> Do you have a use case in mind for this feature?

You mean the "type" field?  In the at24.c driver I posted, it's
the same name used with the "real" i2c_client node.  That helps
make sense of just what the "dummy" is for; sysfs can show it.
Being tied to a "dummy" driver is not very explanatory.


> > + * This returns the new i2c client, which may be saved for later use with
> > + * i2c_unregister_device(); or NULL to indicate an error.
> 
> I'd say it _should_ be saved. Calling i2c_unregister_device() is pretty
> much mandatory, unless the driver can't be built as a module.

OK by me, "which should be saved".


> > + */
> > +struct i2c_client *
> > +i2c_new_dummy(struct i2c_adapter *adapter, unsigned address, const char *type)
> 
> The rest of i2c-core uses an unsigned short for addresses, maybe do the
> same here for consistency?

It's promoted by C!  But no problem.  I'll make it u16 to match
the SMBus calls and struct i2c_msg ... and be more concise, still
fitting on one line.


> > +{
> > +	struct i2c_board_info info = {
> > +		.driver_name	= "dummy",
> > +		.addr		= address,
> > +	};
> > +
> > +	if (type)
> > +		strncpy(info.type, type, sizeof info.type);
> 
> Please use strlcpy() instead, strncpy() is error-prone.

OK.


> > @@ -848,11 +893,24 @@ static int __init i2c_init(void)
> >  	retval = bus_register(&i2c_bus_type);
> >  	if (retval)
> >  		return retval;
> > -	return class_register(&i2c_adapter_class);
> > +	retval = class_register(&i2c_adapter_class);
> > +	if (retval)
> > +		goto bus_err;
> > +	retval = i2c_add_driver(&dummy_driver);
> > +	if (retval)
> > +		goto class_err;
> > +	return 0;
> > +
> > +class_err:
> > +	class_unregister(&i2c_adapter_class);
> > +bus_err:
> > +	bus_unregister(&i2c_bus_type);
> > +	return retval;
> >  }
> 
> Thanks for fixing a broken error path...

I could hardly avoid it!  :)


> > --- a/include/linux/i2c.h	2007-12-15 20:57:54.000000000 -0800
> > +++ b/include/linux/i2c.h	2007-12-15 21:01:22.000000000 -0800
> > @@ -261,6 +261,12 @@ i2c_new_probed_device(struct i2c_adapter
> >  		      struct i2c_board_info *info,
> >  		      unsigned short const *addr_list);
> >  
> > +/* For devices that use several addresses, use i2c_new_dummy() to make
> > + * client handles for the exta addresses.
> 
> Typo: extra.

Glitchey keyboard.  :(


> > + */
> > +extern struct i2c_client *
> > +i2c_new_dummy(struct i2c_adapter *adap, unsigned address, const char *type);
> > +
> >  extern void i2c_unregister_device(struct i2c_client *);
> >  
> >  /* Mainboard arch_initcall() code should register all its I2C devices.
> > 
> 
> Other than that the patch looks just fine. Please respin it and I'll
> apply it.

Thanks.  Update to follow.

- Dave
