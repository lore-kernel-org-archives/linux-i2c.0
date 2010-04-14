From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: isl29020: ALS driver as misc device
Date: Wed, 14 Apr 2010 10:01:53 -0700
Message-ID: <20100414170153.GA7494@kroah.com>
References: <20100414124913.23181.75903.stgit@localhost.localdomain> <20100414125136.23181.16788.stgit@localhost.localdomain> <4BC5C7A8.1040807@cam.ac.uk> <20100414153234.22765666@lxorguk.ukuu.org.uk> <4BC5D681.20707@jic23.retrosnub.co.uk> <20100414175602.44580f3c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100414175602.44580f3c-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 14, 2010 at 05:56:02PM +0100, Alan Cox wrote:
> And this adds the isl29020 as a misc device per discussions
> 
> isl29020: ambient light sensor
> 
> From: Kalhan Trisal <kalhan.trisal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The LS driver will read the latest Lux measurement based upon the
> light brightness and will report the LUX output through sysfs interface.

Please document this sysfs interface with an addition to the
Documentatin/ABI/ directory.

thanks,

greg k-h
