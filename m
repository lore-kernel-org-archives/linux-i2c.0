From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 4/7] i2c: fsi: Add abort and hardware reset procedures
Date: Wed, 27 Jun 2018 08:48:33 -0500
Message-ID: <3dc50e6b-6985-1920-4f8c-dc7698e2f692@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023849.op4rimmsnlv4rgwg@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626023849.op4rimmsnlv4rgwg@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 06/25/2018 09:38 PM, Wolfram Sang wrote:
> On Wed, Jun 13, 2018 at 02:36:16PM -0500, Eddie James wrote:
>> Add abort procedure for failed transfers. Add engine and bus reset
>> procedures to recover from as many faults as possible.
> I think this is a way too aggressive recovery. Your are doing the 9
> pulse toggles basically on any error while this is only when the device
> keeps SDA low and you want to recover from that. If SDA is not stuck
> low, sending a STOP should do. Or do you have a known case where this is
> not going to work?

It is aggressive, but I don't see the harm in doing this on every error. 
There are some other error conditions with this hardware which may 
require the clock toggling, such as "bus arbitration lost." I think this 
is the safest option for this hardware, and this routine has been tested 
for many years.

>
> Also, you implement the pulse toggling manually. Can't you just populate
> {get|set}_{scl|sda} and use the generic routine we have in the core?

I see that the generic implementation breaks the loop if it sees the 
clock isn't high after setting it, or if SDA goes high. I think it's 
safer to finish the reset for our hardware. Plus, we actually have 
different registers for setting 0 or 1 to the clock/data, so we save 
some cpu cycles by doing it directly instead of implementing set_scl/sda 
and having to check val every time :)

If you feel very strongly that this recovery procedure needs to be 
reduced, then I will work on that and have to do some extensive testing.

Thanks!
Eddie

>
