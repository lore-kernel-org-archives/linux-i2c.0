From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c-next v4 2/3] i2c: aspeed: Add 'timeout' DT property
 reading code
Date: Wed, 3 Oct 2018 10:10:23 -0700
Message-ID: <9951c217-70c1-81cf-a43d-baf6bb02beb9@linux.intel.com>
References: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
 <20181001202748.8030-3-jae.hyun.yoo@linux.intel.com>
 <CACPK8XeuFm_GYFhe-KimOHV7y7PBdFjhMGG+QAmfNrfOcb488A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XeuFm_GYFhe-KimOHV7y7PBdFjhMGG+QAmfNrfOcb488A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, devicetree <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Joel,

On 10/3/2018 12:49 AM, Joel Stanley wrote:
> Hello Jae,
> 
> On Mon, 1 Oct 2018 at 22:28, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>> @@ -918,6 +919,11 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>>                  bus->bus_frequency = 100000;
>>          }
>>
>> +       ret = of_property_read_u32(pdev->dev.of_node, "timeout",
>> +                                  &timeout_ms);
>> +       if (ret)
>> +               timeout_ms = 0; /* then adap.timeout will be set by i2c-core */
> 
> Is it possible to implement the parsing of this property in the i2c
> core instead?
> 

Yes, that's possible but I'm not sure that could be acceptable or not.
Let me try.

Thanks,
Jae
