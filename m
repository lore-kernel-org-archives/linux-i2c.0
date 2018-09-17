From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
Date: Mon, 17 Sep 2018 10:16:59 -0700
Message-ID: <037b4cf8-5dfa-d554-b126-a2462ba9c803@linux.intel.com>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
 <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
 <20180917163401.GA1082@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917163401.GA1082@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Brendan Higgins <brendanhiggins@google.com>, linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 9/17/2018 9:34 AM, Wolfram Sang wrote:
> 
>> Looks good to me. Thanks! :)
>>
>> Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Does that mean I need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle
> master/slave combined irq events properly" in i2c/for-next? And apply
> this to i2c/for-current?
> 
> (and please quote only relevat parts of a message when replying)
> 

No need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle master/slave
combined irq events properly". This patch should be applied on top of
the patch.

(Will reduce message size when replying. Thanks!)

Jae
