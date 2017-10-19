From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Don't set SCL timings and speed mode
 when in slave mode
Date: Thu, 19 Oct 2017 12:32:15 +0300
Message-ID: <74ce49f5-8d4d-786c-cf57-24909356e5f5@linux.intel.com>
References: <20170823134612.26117-1-jarkko.nikula@linux.intel.com>
 <20171005111825.kbfb4gcvq26wexnq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35799 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbdJSJcS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 19 Oct 2017 05:32:18 -0400
In-Reply-To: <20171005111825.kbfb4gcvq26wexnq@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Luis

On 10/05/2017 02:18 PM, Wolfram Sang wrote:
> On Wed, Aug 23, 2017 at 04:46:12PM +0300, Jarkko Nikula wrote:
>> According to data sheet SCL timing parameters and DW_IC_CON SPEED mode
>> bits are not used when operating in slave mode.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>> I've done quick testing with i2c-slave-eeprom and i2cdump over together
>> hooked busses without issues. Would like to hear tested by or comment
>> from Luis though. Patch is not urgent so can wait after vacation etc.
> 
> Luis?
> 
Do you have possibility test my patch it doesn't break anything?

-- 
Jarkko
