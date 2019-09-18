From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Date: Wed, 18 Sep 2019 21:56:11 +0100
Message-ID: <56d35d0e-ca17-56e8-38c6-e26acd527ee5@arm.com>
References: <20190918170952.GT2596@sirena.co.uk>
 <20190918185257.GC1933777@kroah.com>
 <CAHk-=whreYmsU_AQtzDS5gd3yamYJ72gBo+YekYSyJLPQ1Qo-A@mail.gmail.com>
 <20190918190748.GA2014907@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190918190748.GA2014907@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc: broonie@kernel.org, wsa@the-dreams.de, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 09/18/2019 08:07 PM, Greg KH wrote:
> On Wed, Sep 18, 2019 at 12:03:17PM -0700, Linus Torvalds wrote:
>> On Wed, Sep 18, 2019 at 11:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Wed, Sep 18, 2019 at 06:09:52PM +0100, Mark Brown wrote:
>>>>
>>>> After merging the driver-core tree, today's linux-next build
>>>> for arm64 allmodconfig failed like this:
>>>
>>> Wait, I thought Linus said this fixup was now resolved.  What went
>>> wrong?
>>
>> I think this is purely a linux-next build failure.
>>
>> I do full allmodconfig builds between each merge I do, and what
>> happened is that as part of the LED merge, I removed the
>> no-longer-used 'i2c_acpi_find_match_adapter()' to resolve that build
>> warning.
>>
>> Then linux-next presumably merged my tree with the driver-core tree,
>> and that re-instated the use of i2c_acpi_find_match_adapter() - which
>> was now gone.
>>
>> But when *I* merged the driver-core tree, I did the merge fixup
>> correctly to actually re-instate not only the use, but also re-instate
>> the removed function that now had a use again.
>>
>>> Linus, should I submit a fix for this?
>>
>> My tree should be fine, and I really think this is just a temporary
>> linux-next effect from the above. I think linux-next only handled the
>> actual syntactic conflicts, not the semantic conflict of "function had
>> been removed to avoid build error from previous merge, and needed to
>> be brought back"
>>
>> Knock wood.
> 
> I looked at your merge of the driver core tree, and see that the
> "missing" function is now back.
> 
> And I did a test build here and all works for me, so I think this is ok,
> thanks for the fixup.
> 
> greg k-h
> 

Thanks for the fixup ! Apologies for the inconvenience

Suzuki
