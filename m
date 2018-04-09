From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
Date: Mon, 9 Apr 2018 11:29:17 -0700
Message-ID: <20180409182917.GA20731@roeck-us.net>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <20180408073435.i5nq2ngx2fslaz6a@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408073435.i5nq2ngx2fslaz6a@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 08, 2018 at 09:34:36AM +0200, Wolfram Sang wrote:
> Hi,
> 
> On Mon, Mar 19, 2018 at 09:10:58AM -0700, Guenter Roeck wrote:
> > Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
> > I2C device id") added a function to return the standard I2C device ID.
> > Use that function to verify the device ID of a given device.
> 
> I am very open to these patches, just...
> 
> > 
> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > RFC:
> > - Compile tested only
> 
> ... I would really like to have them tested. After that happened, Peter
> and I can figure out who should apply them for seamless upstreaming.
> 

Patch 2/2 was for real HW. I don't have access to such HW right now.
Guess we'll have to wait until someone does, unless Adrian is willing
to test it.

> > - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
> >   against all parts from a given manufacturer ?
> 
> Can't we just add it when we need it?
> 
Perfectly fine with me.

> > +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
> > +			real_id.manufacturer_id, real_id.part_id,
> > +			real_id.die_revision);
> > +		return -ENODEV;
> 
> I wonder about the ERR loglevel. ENODEV is not an error, I'd think?
> 
2d74187d5b4e, where this is derived from, uses dev_warn() instead,
so that may be a better choice.

Thanks,
Guenter

> Regards,
> 
>    Wolfram
> 
