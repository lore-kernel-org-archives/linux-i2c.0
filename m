From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 7 Oct 2009 07:48:50 -0600
Message-ID: <fa686aa40910070648w111ad8c4t77e48d5e1f7db51e@mail.gmail.com>
References: <20091007115017.6941faa7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091007115017.6941faa7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 7, 2009 at 3:50 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Grant,
>
> Driver ds1682 needs a new home, as drivers/i2c/chips will be gone soon.
> Do you have a preference for where it should go?
>
> As the device includes an EEPROM, the driver could go in
> drivers/misc/eeprom, but OTOH the EEPROM in question is so small that
> this can hardly be considered the main feature of the driver. So maybe
> just drivers/misc?

drivers/misc works for me.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
