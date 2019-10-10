From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: fix master pending state handling
Date: Thu, 10 Oct 2019 15:04:00 -0700
Message-ID: <637d4b8b-5113-b07b-f99f-ce66dbe6948c@linux.intel.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
 <3ea1c0d5-47f1-bf8c-6b2d-2ea8d3f93471@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3ea1c0d5-47f1-bf8c-6b2d-2ea8d3f93471@fb.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tao Ren <taoren@fb.com>, Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, Cedric Le Goater <clg@kaod.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On 10/10/2019 2:20 PM, Tao Ren wrote:
> On 10/9/19 2:20 PM, Jae Hyun Yoo wrote:
[...]
>>   		/*
>>   		 * If a peer master starts a xfer immediately after it queues a
>> -		 * master command, change its state to 'pending' then H/W will
>> -		 * continue the queued master xfer just after completing the
>> -		 * slave mode session.
>> +		 * master command, clear the queued master command and change
>> +		 * its state to 'pending'. To simplify handling of pending
>> +		 * cases, it uses S/W solution instead of H/W command queue
>> +		 * handling.
>>   		 */
>>   		if (unlikely(irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH)) {
>> +			writel(readl(bus->base + ASPEED_I2C_CMD_REG) &
>> +				~ASPEED_I2CD_MASTER_CMDS_MASK,
>> +			       bus->base + ASPEED_I2C_CMD_REG);
> 
> Sorry for the late comments (just noticed this line while testing the patch):
> 
> I assume this line is aimed at stopping the running master commands, but as per
> AST2500 datasheet, it's NOP to write 0 to MASTER_STOP/MASTER_RX/MASTER_TX bits.
> Maybe all we need is writing 1 to MASTER_STOP field?

There could be two pending cases:
1. Master goes to pending before it triggers a command if a slave
    operation is already initiated.
2. Master goes to pending after it triggered a command if a peer
    master immediately sends something just after the master command
    triggering.

Above code is for the latter case. H/W handles the case priority based
so the slave event will be handled first, and then the master command
will be handled when the slave operation is completed. Problem is,
this H/W shares the same buffer for master and slave operations so
it's unreliable. Above code just removes the master command from the
command register to prevent this H/W command handling of pending events.
Instead, it restarts the master command using a call of 
aspeed_i2c_do_start when the slave operation is completed.

Thanks,

Jae
