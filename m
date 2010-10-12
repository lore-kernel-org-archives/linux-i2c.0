From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: skip address detection if provided in board_info
Date: Tue, 12 Oct 2010 16:21:40 +0800
Message-ID: <20101012162140.429b03b3@feng-i7>
References: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20101012092822.6f4e4aa5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101012092822.6f4e4aa5-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Tue, 12 Oct 2010 15:28:22 +0800
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Jacob,
> 
> On Mon, 11 Oct 2010 16:10:35 -0700, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
> wrote:
> > From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > If the address of a given device is already provided by platform
> > init code, e.g. from system firmware, there is no need to call the
> > driver's detect() function for finding the matching address from
> > the driver's address list.
> > 
> > Avoiding such detection might save boot time.
> 
> i2c_detect() is a no-op if adapter->class is 0, and if you have
> platform init data describing the chips on your I2C adapter then you
> certainly don't want to set the adapter class to anything other than
> 0.
> 
> So I'd rather avoid optimizing a case which isn't supposed to happen
> in the first place.

I checked the i2c devices drivers in drivers/hwmon/, most of them set
the class to I2C_CLASS_HWMON, and many i2c adapter drivers also setting
their class to I2C_CLASS_HWMON. So there is still many cases for i2c_detect
get called.

Under drivers/hwmon/, many i2c devices driver provide an list with 4 or more 
addresses, imaging a platform with >= 5 i2c adapters case, so it will take
more than 20 i2c transfers to init one i2c device driver, and in 10 or 20
seconds (if the timeout for a i2c transfer of that adapter driver is 500ms or
1 second). It will be a disaster if we build in all the drivers in drivers/hwmon/.

So can we have a global flag like i2c_skip_autodetect, which is 0 by default,
and could be set in platform init code to prevent the detecting from really
happen, if we are confident the platform code has inited i2c board info
correctly?

Thanks,
Feng

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index bea4c50..7727105 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1493,6 +1493,9 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 	return 0;
 }
 
+int i2c_skip_auto_detect;
+EXPORT_SYMBOL(i2c_skip_auto_detect);
+
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 {
 	const unsigned short *address_list;
@@ -1501,7 +1504,7 @@ static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 	int adap_id = i2c_adapter_id(adapter);
 
 	address_list = driver->address_list;
-	if (!driver->detect || !address_list)
+	if (!driver->detect || !address_list || i2c_skip_auto_detect)
 		return 0;
 
 	/* Set up a temporary client to help detect callback */  

> 
> The only optimization which I think would be valuable is checking the
> class before allocating the temporary i2c_client structure. I'll send
> a patch doing that in a minute.
> 
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core.c |   32 ++++++++++++++++++++++++++++++++
> >  1 files changed, 32 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 6649176..e4f7feb 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1499,6 +1499,31 @@ static int i2c_detect_address(struct
> > i2c_client *temp_client, return 0;
> >  }
