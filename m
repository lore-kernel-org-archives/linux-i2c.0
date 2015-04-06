From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: davinci: Rework racy ISR
Date: Mon, 06 Apr 2015 19:26:54 +0300
Message-ID: <5522B3CE.4030302@linaro.org>
References: <55003E64.2030701@nokia.com> <550191AB.8000103@linaro.org> <550299D5.5080000@nokia.com> <20150403201530.GG2016@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150403201530.GG2016@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram, Alexander,
On 04/03/2015 11:15 PM, Wolfram Sang wrote:
> On Fri, Mar 13, 2015 at 09:03:33AM +0100, Alexander Sverdlin wrote:
>> Hello!
>>
>> On 12/03/15 14:16, ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>>> There is one big problem in the current design: ISR accesses the controller
>>>>> registers in parallel with i2c_davinci_xfer_msg() in process context. The whole
>>>>> logic is not obvious, many operations are performed in process context while
>>>>> ISR is always enabled and does something asynchronous even while it's not
>>>>> expected. We have faced these races on 4-cores Keystone chip. Some examples:
>>>>>
>>>>> - when non-existing device is accessed first comes NAK IRQ, then ARDY IRQ. After
>>>>>     NAK we already jump out of wait_for_completion_timeout() and depending on how
>>>>>     lucky we are ARDY IRQ will access MDR register in the middle of some other
>>>>>     operation in process context;
>>>>>
>>>>> - STOP condition is triggered in many places in the driver, in ISR, in
>>>>>     i2c_davinci_xfer_msg(), but there is no code which guarantees that STOP will
>>>>>     be really completed. We have seen many STOP conditions simply missing in
>>>>>     back-to-back transfers, when next i2c_davinci_xfer_msg() call simply overwrites
>>>>>     MDR register while STOP is still not generated.
>>>>>
>>>>> So, make the design more robust and obvious:
>>>>> - leave hot path (buffers management) in ISR, remove other registers access from
>>>>>     ISR;
>>>>> - introduce second synchronization point, to make sure that STOP condition is
>>>>>     really generated and it's safe to begin next transfer;
>>>>> - simplify the state machine;
>>>>> - enable IRQs only when they are expected, disable them in ISR when transfer is
>>>>>     completed/failed;
>>>>> - STOP is normally set simultaneously with START condition (in case of last
>>>>>     message); only special case when STOP is additionally generated is received NAK
>>>>>     -- this case is handled separately.
>>> I'm not sure about this change (- It's too significant and definitely will need more review & Tested-by.
>>
>> Maybe you can offer this patch the customers who suddenly cannot access the devices on the bus until reboot...
>> Because it's not a "bus lockup".
>>
>>> We need to be careful with it, especially taking into account DAVINCI_I2C_MDR_RM mode and future
>>> changes like https://lkml.org/lkml/2014/5/1/348.
>>>
>>> May be you can split it?
>>
>> I can may be split it into two patches, but I'm not sure about the result. Each of them will only solve
>> 50% of the problem and then nobody will see a clear benefit applying only one. But what I can offer you is

In my opinion, this one can be split as it fixes few issues at once (see below).

>> to spend the same effort on rebasing the "DAVINCI_I2C_MDR_RM mode" patch you are referring to. I can rebase
>> it and take it into my series if you wish.
> 
> So, shall I take this into i2c/for-next?
> 

As i mentioned before, this patch should get Acked/Tested-by from Davinci community at least
(I understand the issue and that it should be fixed, but personally I don't like the way it's done)
- The of ISR code have not been  changed significantly from the very beginning of Davinci I2C driver's life :(
- As I understand from commits history your patch most probably will break I2C_FUNC_SMBUS_QUICK, but I can't
  verify it (c6c7c72 i2c: davinci: Fix smbus Oops with AIC33 usage).

So I have following propositions:
1) Get rid of obsolete code left after commit 5a0d5f5 i2c-davinci: Fix signal handling bug
because commit 900ef80 'i2c: davinci: don't use interruptible completion" coverts
wait_for_completion_interruptible_timeout() -> wait_for_completion_timeout() [part of this patch]

2) Add i2c_davinci_wait_bus_not_busy() at the end of i2c_davinci_xfer(), so driver will
   wait BF before continue (should fix STP issue)

3) Give a try below diff which could fix NACK -> ARDY issue
--
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 4788a32..a053c55 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -485,9 +485,8 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
        if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
                if (msg->flags & I2C_M_IGNORE_NAK)
                        return msg->len;
-               w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-               w |= DAVINCI_I2C_MDR_STP;
-               davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
+               /* assume STP will be sent from ISR
+                * TODO: msg->flags & I2C_M_IGNORE_NAK ?*/
                return -EREMOTEIO;
        }
        return -EIO;
@@ -581,7 +580,6 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
                case DAVINCI_I2C_IVR_NACK:
                        dev->cmd_err |= DAVINCI_I2C_STR_NACK;
                        dev->buf_len = 0;
-                       complete(&dev->cmd_complete);
                        break;
 
                case DAVINCI_I2C_IVR_ARDY:
@@ -594,8 +592,9 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
                                w |= DAVINCI_I2C_MDR_STP;
                                davinci_i2c_write_reg(dev,
                                                      DAVINCI_I2C_MDR_REG, w);
+                       } else {
+                               complete(&dev->cmd_complete);
                        }
-                       complete(&dev->cmd_complete);
                        break;
 
                case DAVINCI_I2C_IVR_RDR:

4) Clean up ICSTR in i2c_davinci_xfer_msg() [part of this patch], follows
   SPRUH77A - TRM 'OMAP-L138 DSP+ARM Processor'
   23.2.11.1 Configuring the I2C in Master Receiver Mode and Servicing Receive Data via CPU

5) Correct IRQ configuration in i2c_davinci_xfer_msg(), now DAVINCI_I2C_IMR_RRDY and
 DAVINCI_I2C_IMR_XRDY will never be cleared once set.

6) [optional] Enable/disable IRQ in i2c_davinci_xfer_msg() or davinci_xfer_msg() only when 
   driver is ready to handle it.

I'll be glad to help if needed, but the main problem from my side is that I have no HW to test it
(buggy scenario with NACK) and see no way to simulate it.

regards,
-grygorii
