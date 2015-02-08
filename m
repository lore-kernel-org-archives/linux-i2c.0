From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v9 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 8 Feb 2015 09:56:18 -0800
Message-ID: <54D7A342.5030200@broadcom.com>
References: <rjui@broadcom.com> <1423373126-30024-1-git-send-email-rjui@broadcom.com> <1423373126-30024-3-git-send-email-rjui@broadcom.com> <20150208162937.GB6033@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150208162937.GB6033@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 2/8/2015 8:29 AM, Wolfram Sang wrote:
> On Sat, Feb 07, 2015 at 09:25:25PM -0800, Ray Jui wrote:
>> Add initial support to the Broadcom iProc I2C controller found in the
>> iProc family of SoCs.
>>
>> The iProc I2C controller has separate internal TX and RX FIFOs, each has
>> a size of 64 bytes. The iProc I2C controller supports two bus speeds
>> including standard mode (100kHz) and fast mode (400kHz)
>>
>> Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> 
> Looks good. What kind of tests have you done with exactly this version of the
> driver (not earlier ones)?
> 
I did build test and ran i2cdetect on Cygnus BCM958300K combo board with
the 3.19 rc7 kernel, and then I back ported this driver to our 3.10
version of the production kernel (where we have complete audio driver
support), to run some audio playback tests, which involves using the
wolfson codec (through i2c). The only line I added when back porting to
the 3.10 kernel is of_i2c_register_devices at the end of probe.

Thanks,

Ray
