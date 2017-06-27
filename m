From: Boszormenyi Zoltan <zboszor-v1d7l9VOqKc@public.gmane.org>
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
Date: Tue, 27 Jun 2017 13:52:06 +0200
Message-ID: <655c505d-8b2f-9377-4238-6c10790a8f45@pr.hu>
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
 <20170303101702.GA1669@katana>
 <1490944639.2653.182.camel@users.sourceforge.net>
 <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
 <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
 <20170331150524.GA31555@roeck-us.net>
 <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
 <1491201299.2321.42.camel@users.sourceforge.net>
 <b42d979b-9172-48ba-dba9-a67d9a143bca@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b42d979b-9172-48ba-dba9-a67d9a143bca-v1d7l9VOqKc@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 853122-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, Nehal Shah <nehal-bakulchandra.shah-5C7GfCeVMHo@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Thomas Brandon <tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2017-04-03 09:59 keltezéssel, Boszormenyi Zoltan írta:
> Hi,
> 
> 2017-04-03 08:34 keltezéssel, Paul Menzel írta:
>> Dear Zoltán,
>>
>>
>> Am Samstag, den 01.04.2017, 12:13 +0200 schrieb Boszormenyi Zoltan:
>>
>> […]
>>
>>> and have split the patch into three pieces now (USB quirks, i2c-piix4
>>> and sp5100_tco) and they were sent to the relevant mailing lists.
>>
>> Could you please add me to the receiver list of these patches, so that
>> I can test them? Maybe also Christian (the commit author introducing
>> the regression), Tim (bug reporter), and Nehal from AMD?
>>
>> If you uploaded them to the Kernel.org Bugtracker, that’d also work for
>> me.
> 
> did both.

There's a new set of packages sent to all relevant mailing lists and
also attached to the kernel bugtracker at
https://bugzilla.kernel.org/show_bug.cgi?id=170741

Hopefully this approach will work for everyone.

> 
> Best regards,
> Zoltán Böszörményi
> 
>>
>>
>> Thanks,
>>
>> Paul
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
