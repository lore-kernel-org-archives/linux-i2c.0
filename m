From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/3] iio: ak8975: Added autodetect feature for ACPI
Date: Thu, 18 Dec 2014 09:30:12 -0800
Message-ID: <1418923812.4459.8.camel@spandruv-desktop.jf.intel.com>
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1418678363-22437-4-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <549300A5.5080904@metafoo.de>
	 <1418921521.740.282.camel@spandruv-desktop.jf.intel.com>
	 <54930965.3030008@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54930965.3030008-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2014-12-18 at 18:05 +0100, Lars-Peter Clausen wrote: 
> On 12/18/2014 05:52 PM, Srinivas Pandruvada wrote:
> > On Thu, 2014-12-18 at 17:28 +0100, Lars-Peter Clausen wrote:
> >> Added I2C to Cc.
> >>
> >> On 12/15/2014 10:19 PM, Srinivas Pandruvada wrote:
> >>> Using i2c auto detect feature and auto device creation feature,
> >>> enumerate ak8975 device, by checking their presence.
> >>> This is needed because when this device sits behind an i2c mux, there
> >>> is no way to define i2c mux in ACPI. This will enable ak8975 on
> >>> windows based tablets/laptops running Linux when connected via a mux.
> >>> Since DT model already can define an i2c mux and devices connected to
> >>> it, this feature is only enabled for ACPI.
> >>>
> >>
> >> This is quite a bit of a hack.
> > Why?
> > Auto detect is standard feature of i2c devices. This is using standard
> > auto detect feature provided by the framework.
> 
> Auto detect is ugly, slow and unreliable, it's kind of like the last straw 
> if nothing else works.
That is true here. You can't enumerate this device by ACPI. As discussed
before we created i2c mux in inv6050 so that we can use AK8975 in bypass
mode. I added some API to create i2c device on this mux, which Wolfram
didn't like. He wanted to enumerate using existing mechanisms. 
> 
> Autodetect will be executed for every adapter with every device that 
> supports auto detection, so you want to keep the amount of devices that do 
> auto detection to a minimum in order to avoid both false positives and 
> reduce boot time.
> 
> 
> >>   Did they decide to not include the device in
> >> the ACPI description at all or is there a special id for INV6050+AK8975?
> > This device needs has one combined id. Windows has a singe driver
> > processing both as a combo device.
> 
> Ok, then use the combined id to instantiate INV6050+AK8975.
No. The i2c address address is already consumed by INV6050 driver (which
is valid for INV6050 not AK8975).

> 
> - Lars
> 
