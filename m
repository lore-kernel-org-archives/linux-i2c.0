From: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: isl29020: ALS driver as misc device
Date: Mon, 26 Apr 2010 11:59:40 +0100
Message-ID: <4BD5721C.5050909@jic23.retrosnub.co.uk>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>	<20100414125136.23181.16788.stgit@localhost.localdomain>	<4BC5C7A8.1040807@cam.ac.uk>	<20100414153234.22765666@lxorguk.ukuu.org.uk>	<4BC5D681.20707@jic23.retrosnub.co.uk>	<20100414175602.44580f3c@lxorguk.ukuu.org.uk>	<20100414170153.GA7494@kroah.com>	<4BC6E5CF.9070302@jic23.retrosnub.co.uk> <20100415121726.1b2a5a87@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100415121726.1b2a5a87-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/15/10 12:17, Alan Cox wrote:
>> lux-> illuminance0_input  (or I guess lux0_input would also work, I can change
>> the iio abi to match this as well).
>>
>> It also occurs to me that we might want to associate the calibration with the
>> particular channel? There's sure to be a dual ALS chip along at some point.
>>
>> Obviously the isl29020 would need updating as well.  Everyone was happy to do
>> that when were writing the ALS subsystem, so I guess that won't have changed!
> 
> I'm happy to make the 29020 comply, and I guess it wouldn't take long for
> someone to run over the others. Just let me know what the sysfs interface
> should look like.

Hi Alan,

I was hoping some others would jump in here with suggestions. Failing that, I'd
go with

illuminance0_input (in milli lux?)
(if this requires a float calculation, could go with the iio approach of having 
illuminance0_raw and illuminance0_scale, where gain can be a float as it's just
a text string anyway).

illuminance0_range 
illuminance0_range_available

For these range, I'd personally prefer to do it via scaling, but we can probably
be flexible here.  Things will get complex if we start having ranges like 3...10 lux.

So illuminance0_calibscale (hence internal scale - obviously this will also effect
illuminance0_scale if you are going the 'raw' output and convert in userspace route).
Clearly, you would also need an illuminance0_calibscale_available interface to tell
you what discrete settings exist.

Jonathan
