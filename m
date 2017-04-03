From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
Date: Mon, 3 Apr 2017 09:59:06 +0200
Message-ID: <b42d979b-9172-48ba-dba9-a67d9a143bca@pr.hu>
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
 <20170303101702.GA1669@katana>
 <1490944639.2653.182.camel@users.sourceforge.net>
 <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
 <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
 <20170331150524.GA31555@roeck-us.net>
 <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
 <1491201299.2321.42.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:42624 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751507AbdDCH7X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 3 Apr 2017 03:59:23 -0400
In-Reply-To: <1491201299.2321.42.camel@users.sourceforge.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>, Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Christian Fetzer <fetzer.ch@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, 853122@bugs.debian.org, Wim Van Sebroeck <wim@iguana.be>, Tim Small <tim@seoss.co.uk>, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>, linux-kernel@vger.kernel.org

Hi,

2017-04-03 08:34 keltezéssel, Paul Menzel írta:
> Dear Zoltán,
>
>
> Am Samstag, den 01.04.2017, 12:13 +0200 schrieb Boszormenyi Zoltan:
>
> […]
>
>> and have split the patch into three pieces now (USB quirks, i2c-piix4
>> and sp5100_tco) and they were sent to the relevant mailing lists.
>
> Could you please add me to the receiver list of these patches, so that
> I can test them? Maybe also Christian (the commit author introducing
> the regression), Tim (bug reporter), and Nehal from AMD?
>
> If you uploaded them to the Kernel.org Bugtracker, that’d also work for
> me.

did both.

Best regards,
Zoltán Böszörményi

>
>
> Thanks,
>
> Paul
>
