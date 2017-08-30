From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH] i2c: designware: Round down ACPI provided clk to nearest
 supported clk
Date: Wed, 30 Aug 2017 09:23:07 +0800
Message-ID: <f05a083c-c8d1-352f-d084-1ccf5e37e14c@electromag.com.au>
References: <20170829120835.17276-1-hdegoede@redhat.com>
 <1504009379.25945.142.camel@linux.intel.com>
 <078c7214-230e-2a68-734b-2a01003ee378@redhat.com>
 <20170829201826.htdia6olxs3j5k66@ninjato>
 <3cc3df29-b2b5-4a2a-fce4-a9d2302fee54@redhat.com>
 <20170829210048.mqcyep22tqn7t65l@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:37293 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751240AbdH3BXN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Aug 2017 21:23:13 -0400
In-Reply-To: <20170829210048.mqcyep22tqn7t65l@ninjato>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org

On 30/08/2017 05:00, Wolfram Sang wrote:
> 
>> The speed comes from an ACPI entry describing an i2c client,
>> any compliant i2c client must at least support 100KHz, right ?
> 
> Well, due to flaky board design, you may not be able to utilize the max
> speed because of interferences etc even if the devices would support it.
> Such knowledge of flaky boards could be encoded in the ACPI tables, or?
> But probably not in the client device, hmmm...
> 
>> Alternatively I could wrap the entire round-down for loop in
>> an if (acpi_speed) {} block.
> 
> I don't know enough about real-world ACPI tables to suggest a best
> practice here. I just wanted to add that busses < 100 kHz are legal from
> how I read the specs.
> 
> Oh well, Jarkko liked the patch, so let's all sleep over this patch and
> if nothing else comes up, I'll apply it tomorrow or so...
> 

My understanding is 100k is what the client must support.
But sometimes buses need to be run slower.
Particularly when using range extenders.

eg: I have an i2c bus running over a 10m cable that needs to run at about 40k
to be reliable.


-- 
Regards
Phil Reid
