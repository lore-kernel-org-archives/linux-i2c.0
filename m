From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: davinci: Rework racy ISR
Date: Fri, 13 Mar 2015 09:03:33 +0100
Message-ID: <550299D5.5080000@nokia.com>
References: <55003E64.2030701@nokia.com> <550191AB.8000103@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550191AB.8000103-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello!

On 12/03/15 14:16, ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> There is one big problem in the current design: ISR accesses the controller
>> > registers in parallel with i2c_davinci_xfer_msg() in process context. The whole
>> > logic is not obvious, many operations are performed in process context while
>> > ISR is always enabled and does something asynchronous even while it's not
>> > expected. We have faced these races on 4-cores Keystone chip. Some examples:
>> > 
>> > - when non-existing device is accessed first comes NAK IRQ, then ARDY IRQ. After
>> >    NAK we already jump out of wait_for_completion_timeout() and depending on how
>> >    lucky we are ARDY IRQ will access MDR register in the middle of some other
>> >    operation in process context;
>> > 
>> > - STOP condition is triggered in many places in the driver, in ISR, in
>> >    i2c_davinci_xfer_msg(), but there is no code which guarantees that STOP will
>> >    be really completed. We have seen many STOP conditions simply missing in
>> >    back-to-back transfers, when next i2c_davinci_xfer_msg() call simply overwrites
>> >    MDR register while STOP is still not generated.
>> > 
>> > So, make the design more robust and obvious:
>> > - leave hot path (buffers management) in ISR, remove other registers access from
>> >    ISR;
>> > - introduce second synchronization point, to make sure that STOP condition is
>> >    really generated and it's safe to begin next transfer;
>> > - simplify the state machine;
>> > - enable IRQs only when they are expected, disable them in ISR when transfer is
>> >    completed/failed;
>> > - STOP is normally set simultaneously with START condition (in case of last
>> >    message); only special case when STOP is additionally generated is received NAK
>> >    -- this case is handled separately.
> I'm not sure about this change (- It's too significant and definitely will need more review & Tested-by.

Maybe you can offer this patch the customers who suddenly cannot access the devices on the bus until reboot...
Because it's not a "bus lockup". 

> We need to be careful with it, especially taking into account DAVINCI_I2C_MDR_RM mode and future
> changes like https://lkml.org/lkml/2014/5/1/348.
> 
> May be you can split it?

I can may be split it into two patches, but I'm not sure about the result. Each of them will only solve
50% of the problem and then nobody will see a clear benefit applying only one. But what I can offer you is
to spend the same effort on rebasing the "DAVINCI_I2C_MDR_RM mode" patch you are referring to. I can rebase
it and take it into my series if you wish.
 
>> > 
>> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> > ---
>> >   drivers/i2c/busses/i2c-davinci.c |  219 ++++++++++++++++---------------------
>> >   1 files changed, 95 insertions(+), 124 deletions(-)

-- 
Best regards,
Alexander Sverdlin.
