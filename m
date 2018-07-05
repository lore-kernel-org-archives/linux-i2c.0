From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 4/7] i2c: fsi: Add abort and hardware reset procedures
Date: Thu, 5 Jul 2018 13:50:10 -0500
Message-ID: <18b756ef-03d3-8103-3b52-c7bc220d4195@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023849.op4rimmsnlv4rgwg@ninjato>
 <3dc50e6b-6985-1920-4f8c-dc7698e2f692@linux.vnet.ibm.com>
 <20180702181511.mv2fuiwjjdhyp43v@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702181511.mv2fuiwjjdhyp43v@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 07/02/2018 01:15 PM, Wolfram Sang wrote:
> Hi Eddie,
>
>>> I think this is a way too aggressive recovery. Your are doing the 9
>>> pulse toggles basically on any error while this is only when the device
>>> keeps SDA low and you want to recover from that. If SDA is not stuck
>>> low, sending a STOP should do. Or do you have a known case where this is
>>> not going to work?
>> It is aggressive, but I don't see the harm in doing this on every error.
> Well, as it happens, I just fixed such a case. Please check these patch
> series and elinux wiki pages:
>
> ===
>
> (new fault injector)
> [PATCH v2 0/2] i2c: gpio: fault-injector: add new injector
>
> (actual recovery fix)
> [PATCH 0/2] i2c: recovery: make sure pulses are not misinterpreted
>
> ===
>
> And here is the new elinux wiki page to describe my findings:
>
> https://elinux.org/Tests:I2C-bus-recovery-write-byte-fix
>
> Also, the previous pages have been updated to reflect the latest status:
>
> https://elinux.org/Tests:I2C-fault-injection
> https://elinux.org/Tests:I2C-bus-recovery
>
> To sum it up: This is a proven case where uncontrolled bus recovery can
> result into a bogus write!
>
>> There are some other error conditions with this hardware which may require
>> the clock toggling, such as "bus arbitration lost." I think this is the
> Why is that? In my understanding, recovery is *only* needed when SDA is
> stuck low. If SDA is high, sending STOP should do. If not, it needs to
> be researched why.
>
>> safest option for this hardware, and this routine has been tested for many
>> years.
> I remember having a similar argument with Joakim Tjernlund a while ago.
> I recently re-read our argument, yet I still keep my position: I don't
> want to do $random things to recover, just a tested and well understood
> procedure. And in that thread, I was never given a test case.
>
>>> Also, you implement the pulse toggling manually. Can't you just populate
>>> {get|set}_{scl|sda} and use the generic routine we have in the core?
>> I see that the generic implementation breaks the loop if it sees the clock
>> isn't high after setting it, or if SDA goes high. I think it's safer to
>> finish the reset for our hardware. Plus, we actually have different
> Why do you think it is safer? What is the test case for that? I think
> one really should do check SDA! See above, you might trigger a write
> otherwise. If this breaks something for you, I am looking forward to
> discuss it.
>
>> registers for setting 0 or 1 to the clock/data, so we save some cpu cycles
>> by doing it directly instead of implementing set_scl/sda and having to check
>> val every time :)
> Correctness comes above all here. And I am afraid your implementation is
> not correct.
>
>> If you feel very strongly that this recovery procedure needs to be reduced,
>> then I will work on that and have to do some extensive testing.
> I am open for discussion, yet I also feel strong about it. The reason
> why the recovery procedure is moved into the core is to have one working
> and understood bit-banging algorithm which all drivers can rely on. If
> all drivers implement their custom version, they might miss gory details
> like the above write_byte fix.
>
> I do understand this might cause testing effort for you, I am sorry for
> the delay it causes. However, my goal as a maintainer is to have a
> reliable recovery mechanism, for your driver as well as for all drivers.
>
> I hope this is understandable. BTW if you want this driver upstream
> soon, then it may be an idea to resend it without any bus recovery and
> then we can work on it incrementally.

Thanks for the details. I have sent up a new series which will only do 
the bus reset if SDA is low. With our current hardware configuration, 
this *should* be sufficient to recover all the possible errors. However, 
there are configurations where it will not be enough, in which case 
getting the data line stuck high or clock line stuck either high or low 
can occur, necessitating the full reset. But since I can't demonstrate 
those at the moment, I can't argue to include that now :)

Thanks again,
Eddie

>
> Kind regards and thanks,
>
>     Wolfram
