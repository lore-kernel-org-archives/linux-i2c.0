From: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2.6.35.4] irq: irq and pci_ids patch for Intel
Date: Sat, 25 Sep 2010 08:13:36 -0700
Message-ID: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AEA5258E@orsmsx501.amr.corp.intel.com>
References: <201009241606.11840.seth.heasley@intel.com>
 <20100925133039.75e9ac71@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100925133039.75e9ac71-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org" <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>> --- linux-2.6.35.4/drivers/i2c/busses/Kconfig.orig	2010-09-24
>14:59:23.000000000 -0700
>> +++ linux-2.6.35.4/drivers/i2c/busses/Kconfig	2010-09-24
>14:59:42.000000000 -0700
>> @@ -95,7 +95,7 @@
>>  	    ESB2
>>  	    ICH8
>>  	    ICH9
>> -	    Tolapai
>> +	    EP80579
>>  	    ICH10
>>  	    3400/5 Series (PCH)
>
>How did this become "5_3400_SERIES" in the symbol names? Shouldn't it
>be 3400_5_SERIES instead?

The way I did it here is consistent with the approved branding submitted for pci.ids.  So perhaps changing the 3400/5 Series to "5 Series/3400 Series" would make sense.

>
>>  	    Cougar Point (PCH)
>> --- linux-2.6.35.4/drivers/i2c/busses/i2c-i801.c.orig	2010-09-24
>14:57:55.000000000 -0700
>> +++ linux-2.6.35.4/drivers/i2c/busses/i2c-i801.c	2010-09-24
>14:59:13.000000000 -0700
>> @@ -38,7 +38,7 @@
>>    82801G   (ICH7)       0x27da     32     hard     yes     yes
>yes
>>    82801H   (ICH8)       0x283e     32     hard     yes     yes
>yes
>>    82801I   (ICH9)       0x2930     32     hard     yes     yes
>yes
>> -  Tolapai               0x5032     32     hard     yes     yes
>yes
>> +  EP80579               0x5032     32     hard     yes     yes
>yes
>
>Maybe keep "Tolapai" inside parentheses, as people may know the
>platform by that name by now?

That'd be fine with me.

-Seth
