From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: LTC1760, ISR Questions
Date: Wed, 9 Apr 2008 12:04:38 +0200
Message-ID: <20080409120438.6e399bf3@hyperion.delvare>
References: <BLU106-W40B1D2DF94BBAC071ED2E2B0F70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <BLU106-W40B1D2DF94BBAC071ED2E2B0F70-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 3 Apr 2008 23:04:02 +0000, badguy development wrote:
> I am developing a driver for the LTC1760 dual battery charger.
> 
>  I have an interrupt occur and I get notification of that.
> 
> however I cannot seem to clear the interrupt from inside the ISR and thus I am ruined.
> 
> 
> 
> I have learned from the research and looking around I have done, that I cannot call just any code in an ISR.
> 
> the code I want to call will read the AlertResponse register of my LTC1760 chip and that will clear the interrupt.
> 
> 
> 
> but I get angry kernel response when I do, below is a brief dump of what I get:
> 
> BUG: scheduling while atomic: swapper/0x00010002/0
> bad: scheduling from the idle thread!
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 17 [#1]
> Modules linked in: i2c_battery swcamera(PF) clcdc(PF) pvr(PF) gecko_devices
> CPU: 0
> PC is at dequeue_task+0xc/0xa8
> LR is at deactivate_task+0x38/0x44
> pc : [<c009b070>]    lr : [<c009b218>]    Tainted: PF
> sp : c0331c6c  ip : c0331c80  fp : c0331c7c
> r10: 00000000  r9 : 00989642  r8 : b0e7aa00
> r7 : c0335f98  r6 : c0331cd8  r5 : 00000001  r4 : c0335f98
> r3 : 00000080  r2 : 00000000  r1 : 00000000  r0 : c0335f98
> Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
> Control: C5387F
> Table: 868E8000  DAC: 00000017
> Process swapper (pid: 0, stack limit = 0xc0330250)
> 
> All the example code I can find regarding ISR, have access to register offsets and can simply clear the interrupt that way.
> I am new to this and am having a hard time finding direction with regards to how to handle linux interrupts.
> 
> I need to send a request command out i2c to this device to clear this interrupt.
> I am not 100% sure about this, but it is what the data sheet has led me to believe.
> 
> I would appreciate any help on this, and perhaps even a reference to what material I should look at to find this answer.

Indeed, there are many things you can't do in interrupt context, and in
particular you cannot sleep, while most i2c bus drivers do sleep, so
reading from or writing to an I2C device is not possible. There are two
ways to work around this:

* Use a workqueue to do the job. The ISR will add a job to the queue
and return, and the job will be run later. Workqueues have their own
context so accessing the I2C device is OK for them. This is explained
in greater detail in LDD3 [1].

* Implement a non-sleeping mode in your i2c bus driver. That's
something new in kernel 2.6.25, so far only the i2c-pxa driver has support
for non-sleeping mode.

> 
> Thanks ahead of time.
> 
> Please CC me at badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org 
> I am still trying to join the list.
> 
> P.S.
>   I accidently clicked send before filling out the Subject, so I scanned the maillist and did not find my message.
> I think perhaps it was rejected due to no subject, if it was not, and I submitted two of them please accept my apologies.

The messages can take a couple hours before they show in the archive.
Your message was not rejected - although messages with no subject are
bad and likely to be ignored by many ;)

[1] http://lwn.net/Kernel/LDD3/

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
