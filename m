From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v7 05/10] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Fri, 23 Jun 2017 14:19:23 +0200
Message-ID: <20170623121923.GN26073@mail.corp.redhat.com>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-6-git-send-email-preid@electromag.com.au>
 <20170619152811.svoxmxybyoy6l4hc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdFWMTd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Jun 2017 08:19:33 -0400
Content-Disposition: inline
In-Reply-To: <20170619152811.svoxmxybyoy6l4hc@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Reid <preid@electromag.com.au>, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Jun 19 2017 or thereabouts, Wolfram Sang wrote:
> On Thu, Jun 15, 2017 at 09:59:33PM +0800, Phil Reid wrote:
> > Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
> > so the the smbalert driver can be registered.
> > 
> > Signed-off-by: Phil Reid <preid@electromag.com.au>
> 
> CCing Benjamin
> 
> > ---
> >  drivers/i2c/i2c-core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index d2402bb..626471b 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/gpio.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/i2c.h>
> > +#include <linux/i2c-smbus.h>
> >  #include <linux/idr.h>
> >  #include <linux/init.h>
> >  #include <linux/irqflags.h>
> > @@ -2045,6 +2046,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
> >  		dev_warn(&adap->dev,
> >  			 "Failed to create compatibility class link\n");
> >  #endif
> > +	res = of_i2c_setup_smbus_alert(adap);
> > +	if (res)
> > +		goto out_list;

See my concerns in patch 4/10.

In addition, shouldn't this be placed before device_register() for the
least? pm_runtime_enable() would require a matching pm_runtime_disable(),
and device_register() some unregistering behavior too.

Cheers,
Benjamin

> >  
> >  	i2c_init_recovery(adap);
> >  
> > -- 
> > 1.8.3.1
> > 
