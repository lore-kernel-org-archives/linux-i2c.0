From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] i2c-dev: don't get i2c adapter via i2c_dev
Date: Wed, 6 Jul 2016 10:07:22 -0700
Message-ID: <20160706170722.GR2671@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <c2ac0349b818d3f3787b939d5eb83e3c80fc205d.1467772840.git.viresh.kumar@linaro.org>
 <20160706190459.59c6c504@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34585 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbcGFRHY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2016 13:07:24 -0400
Received: by mail-pa0-f41.google.com with SMTP id bz2so78121427pad.1
        for <linux-i2c@vger.kernel.org>; Wed, 06 Jul 2016 10:07:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160706190459.59c6c504@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

Hi Jean,

Thanks for the explanation.

On 06-07-16, 19:04, Jean Delvare wrote:
> Hi Viresh,
> 
> A bit of background: at some point in time, the i2c adapter number (as
> represented internally by the kernel) could be different from the i2c
> device node number (as seen by user-space.) I put an end to this
> madness years ago, but it seems some legacy code from that time
> survived in i2c-dev.
> 
> On Tue,  5 Jul 2016 19:57:06 -0700, Viresh Kumar wrote:
> > There is no code protecting i2c_dev to be freed after it is returned
> > from i2c_dev_get_by_minor() and using it to access the value which we
> > already have (minor) isn't safe really.
> 
> I agree that i2c_dev_get_by_minor() looks racy by nature. It is
> possible that i2c_dev_get_by_minor() can be removed altogether. There
> are 2 other calling locations beyond the one you want to remove. If one
> can be removed then I suspect others can be removed as well (maybe with
> some more work though.)
> 
> If i2c_dev_get_by_minor() needs to stay for whatever reason, then my
> next worry is that struct i2c_dev carries an unaccounted reference to
> an i2c_adapter. This looks seriously broken. i2c_dev->adap should only
> be set on open, and cleared on close.
> 
> > Avoid using it and get the adapter directly from 'minor'.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/i2c/i2c-dev.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> > index 6ecfd76270f2..66f323fd3982 100644
> > --- a/drivers/i2c/i2c-dev.c
> > +++ b/drivers/i2c/i2c-dev.c
> > @@ -485,13 +485,8 @@ static int i2cdev_open(struct inode *inode, struct file *file)
> >  	unsigned int minor = iminor(inode);
> >  	struct i2c_client *client;
> >  	struct i2c_adapter *adap;
> > -	struct i2c_dev *i2c_dev;
> > -
> > -	i2c_dev = i2c_dev_get_by_minor(minor);
> > -	if (!i2c_dev)
> > -		return -ENODEV;
> >  
> > -	adap = i2c_get_adapter(i2c_dev->adap->nr);
> > +	adap = i2c_get_adapter(minor);
> >  	if (!adap)
> >  		return -ENODEV;
> >  
> 
> This is the most simple fix to your immediate problem. However it
> doesn't address the big design issue.

Yeah, I was just looking to fix the file operation paths for my
particular problem and didn't try to do a core wide fix as I had
little knowledge of the I2C subsystem :(

-- 
viresh
