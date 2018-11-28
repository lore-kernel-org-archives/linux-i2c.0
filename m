From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c-next v9 1/5] dt-bindings: i2c: Add 'bus-timeout-ms'
 and '#retries' properties as common optional
Date: Wed, 28 Nov 2018 16:36:09 -0600
Message-ID: <5dde6770-ce7a-720a-f1db-56d9ef044a99@linux.intel.com>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
 <20181030210917.32711-2-jae.hyun.yoo@linux.intel.com>
 <20181128215458.GB1666@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128215458.GB1666@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Brendan Higgins <brendanhiggins@google.com>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On 11/28/2018 3:54 PM, Wolfram Sang wrote:
> On Tue, Oct 30, 2018 at 02:09:12PM -0700, Jae Hyun Yoo wrote:
>> This commit adds 'bus-timeout-ms' and '#retries' properties as
>> common optional properties that can be used for setting 'timeout'
>> and 'retries' values of 'struct i2c_adapter'. With this patch, the
>> bus timeout value and the master transfer retries count can be set
>> through these properties at the registration time of an adapter.
>> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
>> on cdev at runtime too.
>>
>> These properties may not be supported by all drivers. However, if
>> a driver wants to support one of them, it should adapt the
>> bindings in this document.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Definately NACK on the #retries part. This is purely a configuration
> thing. Besides that it is kind of ancient cruft, too. I don't recommend
> it, at all.
> 
> On the timeout thing, I am still not fully convinced that this is a HW
> description. I said that before. But maybe I need to understand your
> problem case better.
> 

Okay, I got it. I'll leave those as configuration things. Will remove
this part in the next version.

Thanks for your comment.

Jae
