From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
Date: Mon, 24 Sep 2018 15:15:46 -0700
Message-ID: <2c8563fd-0641-5237-0026-f559c480ad91@linux.intel.com>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
 <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
 <20180924215850.GD18592@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924215850.GD18592@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 9/24/2018 2:58 PM, Wolfram Sang wrote:
> On Tue, Sep 18, 2018 at 11:02:54AM -0700, Jae Hyun Yoo wrote:
>> On 9/10/2018 2:45 PM, Jae Hyun Yoo wrote:
>>> +- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds when
>>> +			  multi-master is set, defaults to 100 ms when not
>>> +			  specified.
>>
>> Will change it to 'aspeed,idle-wait-timeout-ms' as it's a non standard
>> property.
> 
> No need. This binding is not a HW description, so not a DT property in
> my book. I still don't understand: Your IP core in master mode does not
> have a BUSY bit or similar which detects when a START was detected and
> clears after a STOP?
> 

Okay, I'll keep this property as it is then.

Aspeed IP has the BUSY bit on the I2CD14 register and we are already
using the bit in the current code for single-master use cases.
Due to the bit doesn't cover well multi-master use cases so we need to
improve the current busy checking logic using the 'Transfer Mode State
Machine' bit fields on the same register through this patch set.

Thanks for the review!

Jae
