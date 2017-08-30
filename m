From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Round down ACPI provided clk to nearest
 supported clk
Date: Wed, 30 Aug 2017 10:37:33 +0300
Message-ID: <6757ad09-e78d-8d36-3ae7-e2377971a0d4@linux.intel.com>
References: <20170829120835.17276-1-hdegoede@redhat.com>
 <1504009379.25945.142.camel@linux.intel.com>
 <078c7214-230e-2a68-734b-2a01003ee378@redhat.com>
 <20170829201826.htdia6olxs3j5k66@ninjato>
 <3cc3df29-b2b5-4a2a-fce4-a9d2302fee54@redhat.com>
 <20170829210048.mqcyep22tqn7t65l@ninjato>
 <f05a083c-c8d1-352f-d084-1ccf5e37e14c@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32282 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdH3Hqe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Aug 2017 03:46:34 -0400
In-Reply-To: <f05a083c-c8d1-352f-d084-1ccf5e37e14c@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa@the-dreams.de>, Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org

On 08/30/2017 04:23 AM, Phil Reid wrote:
> On 30/08/2017 05:00, Wolfram Sang wrote:
>> I don't know enough about real-world ACPI tables to suggest a best
>> practice here. I just wanted to add that busses < 100 kHz are legal from
>> how I read the specs.
>>
>> Oh well, Jarkko liked the patch, so let's all sleep over this patch and
>> if nothing else comes up, I'll apply it tomorrow or so...
>>
> 
> My understanding is 100k is what the client must support.
> But sometimes buses need to be run slower.
> Particularly when using range extenders.
> 
> eg: I have an i2c bus running over a 10m cable that needs to run at 
> about 40k
> to be reliable.
> 
I acked the patch because I see it as a possibility for a regression if 
we blindly accept slower than 100 kHz speed from ACPI without validating 
does that result working setup and timing parameters.

It is better to have an another patch explicitly adding support for
< 100 kHz speeds when needed.

-- 
Jarkko
