From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 14:50:55 +0530
Message-ID: <20150415092055.GA3198@sudip-PC>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
 <20150415082746.GI10964@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150415082746.GI10964@mwanda>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Willy Tarreau <willy-859RlTSWH48dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 11:27:46AM +0300, Dan Carpenter wrote:
> Sorry, I still haven't done a proper review.

for almost all your points: it came as i copied the parport_register_dev
from parport_register_device and just added some part leaving everything
else same. I will fix these points in v2 of this patch series.
> 
<snip>
> On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
> Don't print warnings on kmalloc() failure.
> 
> I think kzalloc() is better here.  That way if the ->init_state()
> functions don't set it, then we know it's zeroed out.
yes, i will.
Infact parport_register_device() is using kmalloc for allocating
pardevice and I copied the same code to parport_register_dev()
and had a very tough time to find why I am getting
"tried to init an initialized object" and stackdump, finally after a
coffee break, found it being caused because of not using kzalloc .. :)
> 
<snip>
> > +	tmp->name = name;
> 
> I wonder who frees this name variable.  My concern is that it gets
> freed before we are done using it or something.  (I have not looked at
> the details).
it will be done in free_port() the release callback of parport device.
> 
<snip>
> > +	tmp->dev.parent = &port->ddev;
> > +	devname = kstrdup(name, GFP_KERNEL);
> 
> kstrdup() can fail.
it is actually my mistake. I was looking for various ways I can use in
dev_set_name. This devname and kstrdup is not needed and will be removed
in v2.
> 
<snip>
> > +	}
> 
> I don't understand this test_and_set_bit() condition.  It's weird to me
> that parport_register_dev() succeeds even though we haven't called
> parport_device_proc_register(tmp).

this PARPORT_DEVPROC_REGISTERED flag is cleared in parport_unregister_device()
and is set in parport_register_dev[ice], so when we call
parport_register_device() or parport_register_dev() it will be not set
and the condition will always be true.

regards
sudip
> 
> > +
> 
> regards,
> dan carpenter
