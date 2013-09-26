From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-dev: Create 'name' attribute automatically
Date: Thu, 26 Sep 2013 03:37:08 -0700
Message-ID: <52440E54.5080401@roeck-us.net>
References: <1377966619-20197-1-git-send-email-linux@roeck-us.net> <20130925202035.GB4290@katana> <20130925211104.GA2784@roeck-us.net> <20130926082835.GA3057@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130926082835.GA3057@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/26/2013 01:28 AM, Wolfram Sang wrote:
> Hi,
>
>>> What race condition?
>>>
>>
>> Userspace trying to access the name attribute before it is created.
>> See http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
>
> Thanks!
>
>>> Have you tried this with two instances? I don't think it will work since
>>> class_register modifies the class struct.
>>>
>> Half a dozen instances, actually. Unless I am missing something, seems to be
>
> My bad. Sorry for the noise.
>
>> Anyway, the patch is obsolete; one is supposed to use class->dev_groups now.
>
> Are you willing to update the patch?
>

Sure. Give me a couple of days.

Thanks,
Guenter
