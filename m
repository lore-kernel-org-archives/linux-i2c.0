From: Christian Ruppert <christian.ruppert@alitech.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Fri, 8 Apr 2016 16:01:24 +0200
Message-ID: <5707B9B4.6020402@alitech.com>
References: <1459478866-3896-1-git-send-email-lucas.de.marchi@gmail.com>
 <57066284.30403@alitech.com> <1460050108.5123.6.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460050108.5123.6.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On 2016-04-07 19:28, De Marchi, Lucas wrote:
> Hi Christian,
> 
> On Thu, 2016-04-07 at 15:37 +0200, Christian Ruppert wrote:
>> Dear Lucas,
>>
>> Sorry for the late reply but I had to put our test environment back
>> together to check this patch. I'll keep it around for a while in case
>> you have further iterations to test.
> 
> np, I'll try to iterate faster on this patch now, too.
> 
>> On Linux-4.6.0-rc2 the behaviour is still the same: The kernel locks up
>> in an irq loop at dwi2c driver probe time. If I don't apply the patch
>> everything works fine and the system boots and talks normally on the i2c
>> bus.
> 
> :(
> 
> I really hoped this would work in your case.
> 
>> One solution might be to add a device-tree (and acpi) flag to tell the
>> driver that it does not need to expect any nastily behaved devices on
>> the bus. If this flag is given, the driver could use the faster
>> disable-interrupt strategy. Without the flag we need to fall back to the
>> conservative disable-i2c-controller strategy.
> 
> I'd like to try some other approaches before that. What if we start with it
> disabled and enable at first use?

I think this might work in our case and be worth a try. When thinking
about it, it might even be cleaner to add a way to specify a list of
reset pins (e.g. through the GPIO reset framework) to trigger before
activating the bus. This would allow for more than one badly behaved
devices on the bus and also render everything more independent of the
probe order.

I'm afraid that the general case (bad device behaviour after the first
transfer) still cannot be covered by this strategy but I'm not sure if I
have a way to test this.

> After that we keep the approach of just
> disabling the interrupts.  I can prep a patch for that.

OK, I'll give it a try when it's ready.

Greetings,
  Christian
