From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] I2C: Add support for new AMD SMBus devices
Date: Thu, 10 Sep 2009 09:55:09 +0800
Message-ID: <20090910015509.GA3147@crane-desktop>
References: <20090811014921.GB29858@crane-desktop> <20090909111026.21e85f54@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090909111026.21e85f54-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 09, 2009 at 11:10:26AM +0200, Jean Delvare wrote:
> This is better, however I still have concerns:
> 
> * Your device ID comparison is fragile. Are you absolutely certain that
>   you know _all_ the SMBus devices that were released by AMD in the
>   past? If anything, I'd rather have a single comparison on the first
>   device ID that _will_ be supported by the i2c-piix4 driver.
> 
> * Are you absolutely certain that AMD will never ever release an
>   incompatible SMBus device in the future? I doubt it. In the past,
>   various vendors have changed their implementations. Intel changed
>   twice (i2c-piix4 -> i2c-i801 -> i2c-isch), AMD once already
>   (i2c-amd756 -> i2c-amd8111), VIA once (i2c-via -> i2c-viapro), nVidia
>   once (i2c-amd756 -> i2c-nforce2), etc. If history repeats itself (and
>   it often does), I wouldn't be surprised to see future AMD SMBus chips
>   not compatible with the i2c-piix4 driver, while with your patch
>   applied, the driver would claim to support them. Binding a driver to
>   an unsupported chip can have unpredictable, potentially bad
>   consequences, and I'd rather have the driver not bind immediately to
>   new supported devices than bind to unsupported ones.
> 
> * With your patch, the i2c-piix4 driver would load automatically on
>   systems which do not need it (all old AMD-based PC systems.) While a
>   minor issue, this is still a waste of boot time and memory for these
>   users. I am not aware of any precedent of this.
> 
> So, all in all, I'd rather simply add the IDs of new supported devices
> as they are released, rather than implement this broad matching
> mechanism.
Thank you for your greate comments. I agree with you. And a new patch will be 
submitted which will use VID DID to check.

-- 
Best Regards,
- Crane
