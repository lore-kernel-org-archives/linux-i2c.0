From: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: i2c-designware-core: KBUILD_MODNAME undeclared [was: Build regressions/improvements
  in v3.6-rc1]
Date: Fri, 31 Aug 2012 15:18:02 +0200
Message-ID: <5040B98A.8090304@suse.cz>
References: <1344072256-13170-1-git-send-email-geert@linux-m68k.org> <502C0022.2020106@suse.cz> <20120831144429.554345d0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120831144429.554345d0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>, linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jbaron-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 08/31/2012 02:44 PM, Jean Delvare wrote:
> Hi Jiri, Geert,
> 
> On Wed, 15 Aug 2012 22:01:38 +0200, Jiri Slaby wrote:
>> On 08/04/2012 11:24 AM, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v3.6-rc1[1] compared to v3.5[2].
>> ...
>>>   + drivers/i2c/busses/i2c-designware-core.c: error: 'KBUILD_MODNAME' undeclared (first use in this function):
>>
>> This is a real problem we are facing here. It happens on PPC when all
>> I2C_DESIGNWARE_PLATFORM, I2C_DESIGNWARE_PCI and DYNAMIC_DEBUG are set.
>>
>> It's because i2c-designware-core.c is used in two modules
>> (i2c-designware-platform and i2c-designware-pci) and KBUILD_MODNAME is
>> not defined for those because (scripts/Makefile.lib):
>> # $(modname_flags) #defines KBUILD_MODNAME as the name of the module
>> # it will end up in (or would, if it gets compiled in)
>> # Note: Files that end up in two or more modules are compiled
>> #       without the KBUILD_MODNAME definition. The reason is
>> #       that any made-up name would differ in different configs.
>>
>> But DYNAMIC_DEBUG needs KBUILD_MODNAME for dev_dbg used in that source.
>>
>> Any ideas? Why is it not a separate module for example?
> 
> It should be. Axel Lin has posted a patch which does that and it should
> fix your problem:
> https://lkml.org/lkml/2012/6/13/233
> 
> Please test and confirm it does the right thing. I'll push the patch
> upstream if it does.

Yes, it does.

thanks,
-- 
js
suse labs
