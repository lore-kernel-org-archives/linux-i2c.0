From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
Date: Fri, 13 Jul 2018 13:37:17 -0700
Message-ID: <0840cfe8-e18a-ae7c-5593-fc43b9b47291@linux.intel.com>
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g47nBCbF0mcYqEnQkDpz0Dhh0F0S1-wEL_yBHgs1b3yE5w@mail.gmail.com>
 <59538d26-f025-28da-63df-f675e80fd68b@linux.intel.com>
 <20180713203327.47yq4gucidbzn2hd@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713203327.47yq4gucidbzn2hd@katana>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, james.feist@linux.intel.com, vernon.mauery@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On 7/13/2018 1:33 PM, Wolfram Sang wrote:
> 
>> BTW, to whom should I ask applying this patch? Should I send v2 after
>> adding your reviewed-by tag?
> 
> Not needed, thanks. I use 'patchwork' and this tool collects all the
> tags for me. If I see a patch reviewed by a driver maintainer, I'll pick
> it up in the next queue.
> 

Oh, I see. Thanks a lot Wolfram!
