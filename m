From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Sun, 6 Jan 2008 11:30:31 -0800
Message-ID: <200801061130.31774.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712291905.15160.david-b@pacbell.net>
	<20080106122356.78556b8a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080106122356.78556b8a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 06 January 2008, Jean Delvare wrote:
> > +static struct i2c_client *verify_client(struct device *dev)
> > +{
> > +	if (dev->bus != &i2c_bus_type)
> 
> Is this paranoia, or can this test really succeed? I thought that all
> children of an i2c adapter node would always be i2c clients.

Let's call it well-founded paranoia.  I know that when the SPI
code got a "remove class_device" patch, I had to fix an oops
caused by an unexpected child ... and at the top of my current
GIT snapshot is 911833440b498e3e4fe2f12c1ae2bd44400c7004 which
fixed similar oopsing in SCSI.



> > @@ -713,28 +717,19 @@ EXPORT_SYMBOL(i2c_del_driver);
> >  
> >  /* ------------------------------------------------------------------------- */
> >  
> > -static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
> > +static int i2c_checkaddr(struct device *dev, void *addrp)
> 
> I don't much like this name, why don't you keep __i2c_check_addr?

Changing it is no problem.  I guess the name bothered me too,
my working copy uses "i2c_czechaddr", would you believe.  ;)


> >  
> > +struct i2c_cmd_arg {
> > +	unsigned	cmd;
> > +	void		*arg;
> > +};
> > +
> > +static int i2c_cmd(struct device *dev, void *_arg)
> > +{
> > +	struct i2c_client	*client = verify_client(dev);
> > +	struct i2c_cmd_arg	*arg = _arg;
> > +
> > +	if (client)
> > +		client->driver->command(client, arg->cmd, arg->arg);
> 
> client->driver->command may or may not be defined. The original code
> was checking for this, and so should yours.

OK.


> > --- a/drivers/i2c/i2c-dev.c
> > +++ b/drivers/i2c/i2c-dev.c
> > 		...
> > -	}
> > -	mutex_unlock(&adapter->clist_lock);
> > +	if (!dev->bus || strcmp("i2c", dev->bus->name) != 0)
> 
> Please just export i2c_bus_type is you need it, or even verify_client
> (then renamed to i2c_verify_client)? If the bus type check is really
> needed then we'll need it for the 3 v4l drivers I mentioned earlier
> anyway.

Good point.  I didn't like this part much, and that function can
have other uses.  I updated kobj_to_i2c_client() to use it too.


> Alternatively we could write and export an i2c_for_each_client()
> function doing all the required checks so that drivers don't have to
> care. What do you think?

Less good.  We can't know in advance which things they care about.

 
> >			...
> >  
> 
> The rest looks OK... nice cleanup, thanks for doing this.

It seemed appropriate.  :)

Though I was a bit worried it might have bugs in it, since all I had
time to do was code it, and sanity check it with a couple variants of
one new-style config.  (I no longer have those monster "build all I2C
drivers" configs around.)

- Dave
