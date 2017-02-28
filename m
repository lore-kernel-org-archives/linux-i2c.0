From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v6 1/6] i2c: designware: Cleaning and comment style fixes.
Date: Tue, 28 Feb 2017 17:07:09 +0200
Message-ID: <91b9343d-e878-d262-41cd-a29979bf54f9@linux.intel.com>
References: <cover.1487009294.git.lolivei@synopsys.com>
 <8a176efc405d4f13d3fc1b5565d2a2b1c931a018.1487009294.git.lolivei@synopsys.com>
 <1487164348.2133.485.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:37117 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbdB1PKU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Feb 2017 10:10:20 -0500
In-Reply-To: <1487164348.2133.485.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

Hi

Sorry the delay.

On 02/15/17 15:12, Andy Shevchenko wrote:
> On Wed, 2017-02-15 at 12:22 +0000, Luis Oliveira wrote:
>> The purpose of this commit is to fix some comments and styling in the
>> existing code due to the need of reuse this code. What is being made
>> here is:
>>
>> - Sorted the headers files
>> - Corrected some comments style (capital letters, lowcase i2c)
>> - Reverse tree in the variables declaration
>> - Add/remove empty lines and tabs where needed
>> - Fix of misspelled word "endianness" and "transferred"
>> - Replaced the return variable "r" with the more standard "ret"
>>
>> The value of this, besides the rules of coding style, is because I
>> will use this code after and it will make my future patch a lot bigger
>> and
>> complicated to review. The work here won't bring any additional work
>> to
>> backported fixes because is just style and reordering.
>>
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Unfortunately this doesn't apply anymore due we had to revert commit
63d0f0a6952a ("i2c: designware: detect when dynamic tar update is 
possible") for v4.10. Could you rebase and resend.

-- 
Jarkko
