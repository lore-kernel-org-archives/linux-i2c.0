From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] i2c-scmi: remove some bogus NULL checks
Date: Wed, 30 Oct 2013 19:39:33 +0300
Message-ID: <20131030163933.GH26669@mwanda>
References: <20131019084622.GA9312@longonot.mountain>
 <20131030160257.GF3663@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131030160257.GF3663@katana>
Sender: kernel-janitors-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jiang Liu <jiang.liu@huawei.com>, Toshi Kani <toshi.kani@hp.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 30, 2013 at 05:02:58PM +0100, Wolfram Sang wrote:
> > --- a/drivers/i2c/busses/i2c-scmi.c
> > +++ b/drivers/i2c/busses/i2c-scmi.c
> > @@ -223,7 +223,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
> >  		goto out;
> >  
> >  	obj = pkg->package.elements + 1;
> > -	if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
> > +	if (obj->type != ACPI_TYPE_INTEGER) {
> >  		ACPI_ERROR((AE_INFO, "Invalid argument type"));
> >  		result = -EIO;
> >  		goto out;

For obj to be 0 then pkg->package.elements must be -1.  If we're getting
a pointer of -1 then we're already screwed.  Also we already used
pkg->elements without the "+ 1" so we know that's not -1.

The reason for this patch was that some compilers assume pointer math
can't overflow and my checker was complaining.  We use
-fno-strict-overflow in the kernel, but it still seemed worth cleaning.

regards,
dan carpenter

