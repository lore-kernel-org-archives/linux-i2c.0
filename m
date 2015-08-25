From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC] i2c: Revert back to old device naming for ACPI enumerated
 I2C slaves
Date: Tue, 25 Aug 2015 17:50:08 +0300
Message-ID: <55DC80A0.6010506@linux.intel.com>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com> <20150825050306.GB21569@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150825050306.GB21569-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dustin Byford <dustin-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/25/2015 08:03 AM, Dustin Byford wrote:
> On Mon Aug 24 13:52, Jarkko Nikula wrote:
>
>> I don't know how common ACPI enumerated I2C hwmon devices are but I guess
>> they exists since Dustin notices this issue and wrote "With that change,
>> /sys/bus/i2c/devices/i2c-0-004a, for example, became
>> /sys/bus/i2c/devices/i2c-PNPXXXX:xx".
>
> I wouldn't take my particular use case as evidence they are common, or
> even they really exist.  I got here because I loaded a hwmon driver
> using the _DSD/PRP0001 mechanism in ACPI.  In that case, those devices
> have never worked with 'sensors'  Therefore, in that context, this
> change is just fixing a bug.
>
So does this then fall more into new use case rather than being a 
regression as such?

What I'm trying to understand what kind of regression we actually do 
have here? Is it about listing the devices or does it also cease to show 
for instance temperature sensor readings?

If it requires to add a match table to existing driver in order to 
trigger this then at least stable tree is not worry here.

-- 
Jarkko
