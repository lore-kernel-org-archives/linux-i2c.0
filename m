From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c-next v6 1/5] dt-bindings: i2c: Add 'timeout-ms' and
 '#retries' properties as common optional
Date: Fri, 5 Oct 2018 13:43:55 -0700
Message-ID: <842d268d-9e38-3c81-1b66-a0527206092b@linux.intel.com>
References: <20181004204322.20665-1-jae.hyun.yoo@linux.intel.com>
 <20181004204322.20665-2-jae.hyun.yoo@linux.intel.com>
 <20181005203930.GA12987@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005203930.GA12987@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Rob,

On 10/5/2018 1:39 PM, Rob Herring wrote:
> On Thu, Oct 04, 2018 at 01:43:18PM -0700, Jae Hyun Yoo wrote:
>> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
>> @@ -80,6 +80,12 @@ wants to support one of the below features, it should adapt the bindings below.
>>   	Names of map programmable addresses.
>>   	It can contain any map needing another address than default one.
>>   
>> +- timeout-ms
> 
> bus-timeout-ms in case we have some other timeout needed.
> 

Agreed. I'll change it like you suggested.

Thanks,
Jae
