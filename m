From: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] PXA3xx: Add support for power i2c bus
Date: Fri, 15 Aug 2008 10:11:42 +0800
Message-ID: <f17812d70808141911p3d4db387sd797b57a35f150cb@mail.gmail.com>
References: <48A3F2EB.8030809@compulab.co.il>
	<20080814103956.GB4610@flint.arm.linux.org.uk>
	<48A41921.7020306@compulab.co.il> <20080814130709.GH2716@fluff.org.uk>
	<48A43671.6000302@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48A43671.6000302-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, ARM Linux <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 14, 2008 at 9:43 PM, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> wrote:
>
> Ben Dooks wrote:
>> On Thu, Aug 14, 2008 at 02:38:09PM +0300, Mike Rapoport wrote:
>>
>> Not very nice, how about making the i2c structure have pointers
>> to each of the registers which can be setup at probe time. Or even
>> just have a multiplier in the structure, as these all look to be reg/2
>> in the case of pxa3xx and adap.nr == 1...
>>
>> Note, adap.nr shouldn't really be used to differentiate, use the
>> platform device number
>>
>> +#define _IDBR(i2c)   ((i2c)->reg_base + (0x4 << (i2c)->reg_shift))
>> +#define _ICR(i2c)    ((i2c)->reg_base + (0x8 << (i2c)->reg_shift))
>> etc.
>>
>> then do in the probe:
>>
>>       i2c->reg_shift = (cpu_is_pxa3xx() && <is_power_i2c>) ? 0 : 1;
>>
>
> This is really much nicer. The fixed patch follows:
>
> Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

Looks much better now.

You may use INIT_CLK() for the dummy I2C clk for consistency with
other CLK definitions.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
