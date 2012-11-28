From: wfp5p-A/mCt7huS1Rvw44tLj6iNJvpjmsXDcsSh13vi7wywA4@public.gmane.org (Bill Pemberton)
Subject: Re: [PATCH 16/16] i2c: SMBus: remove __dev* attributes
Date: Wed, 28 Nov 2012 08:54:48 -0500
Message-ID: <20121128135448.5319580134@viridian.itc.virginia.edu>
References: <20121128142349.629db0c0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128142349.629db0c0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare writes:
> 
> Hi Bill,
> 
> On Tue, 27 Nov 2012 15:59:53 -0500, Bill Pemberton wrote:
> > diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> > index 1e73638..6c5a732 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -841,13 +841,13 @@ struct dmi_onboard_device_info {
> >  	const char *i2c_type;
> >  };
> >  
> > -static struct dmi_onboard_device_info __devinitdata dmi_devices[] = {
> > +static struct dmi_onboard_device_info dmi_devices[] = {
> >  	{ "Syleus", DMI_DEV_TYPE_OTHER, 0x73, "fscsyl" },
> >  	{ "Hermes", DMI_DEV_TYPE_OTHER, 0x73, "fscher" },
> >  	{ "Hades",  DMI_DEV_TYPE_OTHER, 0x73, "fschds" },
> >  };
> 
> If I remember correctly, the only reason why this wasn't declared const
> was because this was not compatible with __devinitdata. Now that
> __devinitdata is gone, the leading "static" should become "static
> const". Same goes for the 4 other occurrences in this patch, and I
> suppose, many other cases in other subsystems.
> 

Ok, do you want it resent with that change included? (along with the
checkpatch changes, of course).

-- 
Bill
