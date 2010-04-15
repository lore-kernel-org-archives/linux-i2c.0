From: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: isl29020: ALS driver as misc device
Date: Thu, 15 Apr 2010 11:09:19 +0100
Message-ID: <4BC6E5CF.9070302@jic23.retrosnub.co.uk>
References: <20100414124913.23181.75903.stgit@localhost.localdomain> <20100414125136.23181.16788.stgit@localhost.localdomain> <4BC5C7A8.1040807@cam.ac.uk> <20100414153234.22765666@lxorguk.ukuu.org.uk> <4BC5D681.20707@jic23.retrosnub.co.uk> <20100414175602.44580f3c@lxorguk.ukuu.org.uk> <20100414170153.GA7494@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100414170153.GA7494-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/14/10 18:01, Greg KH wrote:
> On Wed, Apr 14, 2010 at 05:56:02PM +0100, Alan Cox wrote:
>> And this adds the isl29020 as a misc device per discussions
>>
>> isl29020: ambient light sensor
>>
>> From: Kalhan Trisal <kalhan.trisal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> The LS driver will read the latest Lux measurement based upon the
>> light brightness and will report the LUX output through sysfs interface.
> 
> Please document this sysfs interface with an addition to the
> Documentatin/ABI/ directory.
As documenting this abi (which indeed should be done) is going to set
a precedence, perhaps this is a good time to discuss what this naming could
be.

In cleaning up the IIO abi Greg suggested that we match existing similar
abi's a closely as possible, which where possible makes a great deal of sense
(shared userspace code is possible and it makes everything a bit more predictable
for driver writers... particularly as I expect someone will sooner or later
make a combined hwmon and als chip).

The obvious similarity here is with hwmon.
So perhaps going with naming as

lux-> illuminance0_input  (or I guess lux0_input would also work, I can change
the iio abi to match this as well).

It also occurs to me that we might want to associate the calibration with the
particular channel? There's sure to be a dual ALS chip along at some point.

Obviously the isl29020 would need updating as well.  Everyone was happy to do
that when were writing the ALS subsystem, so I guess that won't have changed!

Jonathan
