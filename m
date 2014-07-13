From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: stub: Add support for SMBus block commands
Date: Sun, 13 Jul 2014 08:46:41 -0700
Message-ID: <53C2A9E1.2080807@roeck-us.net>
References: <1404742983-27303-1-git-send-email-linux@roeck-us.net>	<20140708215453.0677d3ed@endymion.delvare>	<53BC4F15.9030608@roeck-us.net>	<20140712112019.618d8a03@endymion.delvare>	<53C14ECD.7050105@roeck-us.net>	<20140713092127.4bedfa18@endymion.delvare>	<53C2A016.2070906@roeck-us.net> <20140713171343.0a4ba58d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140713171343.0a4ba58d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07/13/2014 08:13 AM, Jean Delvare wrote:
> On Sun, 13 Jul 2014 08:04:54 -0700, Guenter Roeck wrote:
>> On 07/13/2014 12:21 AM, Jean Delvare wrote:
>>> Hi Guenter,
>>>
>>> On Sat, 12 Jul 2014 08:05:49 -0700, Guenter Roeck wrote:
>>>> Any idea how we could inject errors ? Error path testing would be quite useful.
>>>
>>> Good idea. This should probably be done with a sysfs attribute so that
>>> it can be turned on and off as desired. Off by default, of course. Some
>>> other subsystems already support error injection, you could check how
>>> they are doing it, do that we do not diverge needlessly.
>>>
>>> Do you think there is any value in failing with different error codes,
>>> or just -EIO is enough?
>>
>> How about writing the error code to return into the attribute ?
>> Write anything negative, and it is returned as error. Write 0,
>> and the driver works as normal.
>
> This is smart, I like it :)
>
>>> Do you think it should fail all the time when error injection is
>>> enabled, or is there a value in having only a certain % of commands
>>> fail?
>>
>> For my purposes I would want it to fail reliably. We could add some fanciness,
>> though: Provide a second attribute which specifies how many operations should
>> pass before the first failure.
>
> Let's start simple and just implement what you need.
>

I would actually benefit from both. The ability to return an error unconditionally
lets me test the first error path. The ability to return an error starting with the
n-th transfer lets me test the n-th error path.

Guenter
