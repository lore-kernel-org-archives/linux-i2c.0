From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: Re: [PATCH v6] i2c-gpio: add devicetree support
Date: Fri, 25 Feb 2011 10:04:59 +0800
Message-ID: <4D670E4B.6000407@wytron.com.tw>
References: <20110223011232.GC15795@trinity.fluff.org> <1298520013-3630-1-git-send-email-thomas@wytron.com.tw> <20110224162210.GC17735@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110224162210.GC17735-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Grant,

On 02/25/2011 12:22 AM, Grant Likely wrote:
>> +Required properties:
>> +- compatible : should be "i2c-gpio".
>> +- gpios : should specify GPIOs used for SDA and SCL lines, in that order.
>> +Optional properties:
>> +- sda-is-open-drain : present if SDA gpio is open-drain.
>> +- scl-is-open-drain : present if SCL gpio is open-drain.
>> +- scl-is-output-only : present if the output driver for SCL cannot be
>> +	turned off. this will prevent clock stretching from working.
>> +- speed-hz : SCL frequency.
>
> Hi Thomas,
>
> One nitpick; I just looked, and other i2c controllers are already
> using 'clock-frequency' instead of 'speed-hz' for the speed of the
> bus.  I'd like to see this patch use the same terminology.

I studied 'clock-frequency' usage of existing i2c drivers before working 
on this patch.

i2c-ibm_iic.c, i2c-mpc.c, i2c-ocores.c : use as bus clock frequency 
input to the core.

i2c-cpm.c : use as i2c SCL output frequency.

Most other non-i2c drivers use clock-frequency as bus clock frequency 
input, too.

I think the SCL freq usage in i2c-cpm.c is confusing. So I would suggest 
we borrow 'speed-hz' from spi subsystem, which means the clock freq 
output on the peripheral bus.

Best regards,
Thomas
