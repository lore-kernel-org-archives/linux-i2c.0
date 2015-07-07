From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: add SMBus Host Notify support
Date: Tue, 7 Jul 2015 19:40:29 +0200
Message-ID: <20150707194029.3348bddb@endymion.delvare>
References: <1435085899-11017-1-git-send-email-benjamin.tissoires@redhat.com>
	<1435085899-11017-2-git-send-email-benjamin.tissoires@redhat.com>
	<20150629150035.4c027502@endymion.delvare>
	<20150707142333.GC18484@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150707142333.GC18484-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 7 Jul 2015 10:23:33 -0400, Benjamin Tissoires wrote:
> Hi Jean,
> 
> On Jun 29 2015 or thereabouts, Jean Delvare wrote:
> > Hi Benjamin,
> > 
> > On Tue, 23 Jun 2015 14:58:18 -0400, Benjamin Tissoires wrote:
> > > SMBus Host Notify allows a slave device to act as a master on a bus to
> > > notify the host of an interrupt. The functionality is directly implemented
> > > in the firmware so we just export a toggle function and rely on the
> > > adapter to actually support this.
> > 
> > Why does it need to be toggled? I mean, if the controller supports it,
> > why don't we just enable the feature all the time?
> 
> That is definitively a solution. I however had once a problem with
> suspend/resume where i2c_i801 was not able to reset the Host Notify
> feature, but that was maybe a side effect of unloading/reloading the
> module tons of times during the session.
> 
> I will work on that and submit a v2 this week.
> 
> I still wonder if you think we should expose a KConfig parameter for
> this or not. I would prefer not to (because it is handled in hardware
> and people might screw up their input drivers), but I'd prefer have your
> opinion on this first.

What would the Kconfig option do exactly? As a general rule, the fewer
Kconfig options the better. We already have I2C_SMBUS for the SMBus
protocol specifics and Host Notify is one of these.

> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  Documentation/i2c/smbus-protocol |  4 ++++
> > >  drivers/i2c/i2c-core.c           | 26 ++++++++++++++++++++++++++
> > >  include/linux/i2c.h              |  8 ++++++++
> > >  include/uapi/linux/i2c.h         |  1 +
> > >  4 files changed, 39 insertions(+)
> > > 
> > > diff --git a/Documentation/i2c/smbus-protocol b/Documentation/i2c/smbus-protocol
> > > index 6012b12..af4e4b9 100644
> > > --- a/Documentation/i2c/smbus-protocol
> > > +++ b/Documentation/i2c/smbus-protocol
> > > @@ -199,6 +199,10 @@ alerting device's address.
> > >  
> > >  [S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
> > >  
> > > +I2C drivers for devices which can trigger SMBus Host Notify should call
> > > +i2c_smbus_toggle_host_notify() to enable SMBUS Host Notify on the adapter
> > > +and implement the optional alert() callback.
> > > +
> > >  
> > >  Packet Error Checking (PEC)
> > >  ===========================
> > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > index 987c124..eaaf5b0 100644
> > > --- a/drivers/i2c/i2c-core.c
> > > +++ b/drivers/i2c/i2c-core.c
> > > @@ -2959,6 +2959,32 @@ int i2c_slave_unregister(struct i2c_client *client)
> > >  EXPORT_SYMBOL_GPL(i2c_slave_unregister);
> > >  #endif
> > >  
> > > +int i2c_smbus_toggle_host_notify(struct i2c_client *client, bool state)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!client)
> > > +		return -EINVAL;
> > > +
> > > +	if (!(client->flags & I2C_CLIENT_TEN)) {
> > > +		/* Enforce stricter address checking */
> > > +		ret = i2c_check_addr_validity(client->addr);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (!client->adapter->algo->toggle_smbus_host_notify)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	i2c_lock_adapter(client->adapter);
> > > +	ret = client->adapter->algo->toggle_smbus_host_notify(client->adapter,
> > > +							      state);
> > > +	i2c_unlock_adapter(client->adapter);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(i2c_smbus_toggle_host_notify);
> > > +
> > 
> > As this is an SMBus feature, can't it go to drivers/i2c/i2c-smbus.c?
> 
> I asked myself this question, and I figured it was not possible because
> i2c-smbus consists in the smbus_alert i2c driver.
> 
> After re-reading the code, I see now that it could definitively goes
> there too. However, if we choose not to expose the toggle to the
> drivers, then there will be no need to make deep changes in i2c-smbus
> :).

The smbus_alert i2c driver was just the most simple way to implement
the SMBus Alert feature. It's not an actual device driver, nothing to
be afraid of.

> (...)
> Thanks for the review!

You're welcome. I wish I could do more but -ENOTIME :/

-- 
Jean Delvare
SUSE L3 Support
