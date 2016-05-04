From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Wed, 4 May 2016 11:38:08 -0300
Message-ID: <CAKi4VAJ4UMpezFpqro+2=gNQD=tjEN=wVC6kahT3wQQYTOquqg@mail.gmail.com>
References: <5707B9B4.6020402@alitech.com> <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
 <CAKi4VA+WVwXBM5cP8Q1iQ_YqWF5jvE5XbbLYEb9Jjfo4Lgw3=g@mail.gmail.com> <572727D7.6080708@alitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33261 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbcEDOi2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 4 May 2016 10:38:28 -0400
In-Reply-To: <572727D7.6080708@alitech.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Ruppert <christian.ruppert@alitech.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>

Hi Christian,

On Mon, May 2, 2016 at 7:11 AM, Christian Ruppert
<christian.ruppert@alitech.com> wrote:
> Dear Lucas,
>
> On 22.04.2016 17:19, Lucas De Marchi wrote:
>> CC'ing Christian.
>>
>> On Fri, Apr 22, 2016 at 12:08 PM, Lucas De Marchi
>> <lucas.demarchi@intel.com> wrote:
>>> Disabling the adapter after each transfer is pretty bad for sensors and
>>> other devices doing small transfers at a high rate. It slows down the
>>> transfer rate a lot since each of them have to wait the adapter to be
>>> enabled again.
>>>
>>> During the transfer init we check the status register for no activity
>>> and TX buffer being empty since otherwise we can't change IC_TAR
>>> dynamically.
>>>
>>> When a transfer fails the adapter will still be disabled - this is a
>>> conservative approach. When transfers succeed, the adapter is left
>>> enabled and it's configured so to disable interrupts.
>>
>> Christian, this is the updated patch. Now adapter starts disabled and
>> is disabled when there's a failed transfer. I hope this can work with
>> your hardware.
>
> Good news: The system now boots without deadlocks.

:). Thanks for testing this.

>
> Bad  news: Not all transfers seem to take place as they should.
>            I don't have the time for a deep analysis but a few quick
>            experiments seem to indicate that the adapter needs to be
>            disabled while updating TAR to a value different from the
>            previous one. Disabling the adapter does not seem to be
>            required if TAR doesn't change from one transfer to the next.
>            I don't know if there are any conditions under which we can
>            leave the adapter enabled while changing TAR but at least in
>            some cases it seems to work.

:(

This is unfortunate. If the bus is shared for 2 slave devices we will
get the slow down back. I wonder if there's a HW version or something
like that in the registers which can be used to add quirks to tweak the
behavior.  I'll dig some documentation, but if anyone knows, it'd be
nice to have it pointed out.

Lucas De Marchi
