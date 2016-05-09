From: Christian Ruppert <christian.ruppert@alitech.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Mon, 9 May 2016 10:50:20 +0200
Message-ID: <57dde84d-8c2c-b24d-da57-ce40fcf493ec@alitech.com>
References: <5707B9B4.6020402@alitech.com>
 <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
 <CAKi4VA+WVwXBM5cP8Q1iQ_YqWF5jvE5XbbLYEb9Jjfo4Lgw3=g@mail.gmail.com>
 <572727D7.6080708@alitech.com>
 <CAKi4VAJ4UMpezFpqro+2=gNQD=tjEN=wVC6kahT3wQQYTOquqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nopam.alitech.com ([202.3.176.31]:52347 "EHLO nopam.alitech.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbcEIIu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 9 May 2016 04:50:28 -0400
In-Reply-To: <CAKi4VAJ4UMpezFpqro+2=gNQD=tjEN=wVC6kahT3wQQYTOquqg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>

Dear Lucas,

On 04.05.2016 16:38, Lucas De Marchi wrote:
> Hi Christian,
> 
> On Mon, May 2, 2016 at 7:11 AM, Christian Ruppert
> <christian.ruppert@alitech.com> wrote:
>> Dear Lucas,
>>
>> On 22.04.2016 17:19, Lucas De Marchi wrote:
>>> CC'ing Christian.
>>>
>>> On Fri, Apr 22, 2016 at 12:08 PM, Lucas De Marchi
>>> <lucas.demarchi@intel.com> wrote:
> [...]
>> Bad  news: Not all transfers seem to take place as they should.
>>            I don't have the time for a deep analysis but a few quick
>>            experiments seem to indicate that the adapter needs to be
>>            disabled while updating TAR to a value different from the
>>            previous one. Disabling the adapter does not seem to be
>>            required if TAR doesn't change from one transfer to the next.
>>            I don't know if there are any conditions under which we can
>>            leave the adapter enabled while changing TAR but at least in
>>            some cases it seems to work.
> 
> :(
> 
> This is unfortunate. If the bus is shared for 2 slave devices we will
> get the slow down back. I wonder if there's a HW version or something
> like that in the registers which can be used to add quirks to tweak the
> behavior.  I'll dig some documentation, but if anyone knows, it'd be
> nice to have it pointed out.

There is such a register (DW_IC_COMP_VERSION) and we used it before for
hold time configuration, see line 374. In my case, the value of the
register is 0x3131372a. We're now just left with the problem to find out
how many (and which) hardware issues there are and in which version they
were fixed exactly...

Greetings,
  Christian
