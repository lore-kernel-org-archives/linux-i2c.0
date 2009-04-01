From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v2] powerpc: i2c-mpc: make I2C bus speed configurable
Date: Wed, 01 Apr 2009 17:51:48 +0200
Message-ID: <49D38D94.3010703@grandegger.com>
References: <49D36885.9070806@grandegger.com>	 <fa686aa40904010644t1c111c05ka7349869eb155429@mail.gmail.com> <fa686aa40904010647o57b59845p54a9c1e1535e4453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa686aa40904010647o57b59845p54a9c1e1535e4453-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linuxppc-dev <Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, devicetree-discuss <devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:
> On Wed, Apr 1, 2009 at 7:44 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Wed, Apr 1, 2009 at 7:13 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>>> This patch makes the I2C bus speed configurable by using the I2C node
>>> property "clock-frequency". If the property is not defined, the old
>>> fixed clock settings will be used for backward compatibility.
>> I mostly like this patch.  However, as I mentioned in my other reply,
>> I'm going to NAK it because the divisor tables are not common code and
>> do not belong in common code files.
>>
>> Other than that, I like this version of the patch and I think it is
>> almost finished.  More comments below.

Looks good now, indeed.

> Oh, and you should look in MAINTAINERS and cc this patch to Ben Dooks
> and the linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org mailing list.

Right, and I need to separate I2C and PowerPC related patches. And it
will require another round but some acked-by lines will help.

>>> -static void mpc_i2c_setclock(struct mpc_i2c *i2c)
>>> -{
>>> -       /* Set clock and filters */
>>> -       if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
>>> -               writeb(0x31, i2c->base + MPC_I2C_FDR);
>>> -               writeb(0x10, i2c->base + MPC_I2C_DFSRR);
>>> -       } else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
>>> -               writeb(0x3f, i2c->base + MPC_I2C_FDR);
>>> -       else
>>> -               writel(0x1031, i2c->base + MPC_I2C_FDR);
>>> +static void mpc_i2c_setclock_52xx(struct device_node *node,
>>> +                                 struct mpc_i2c *i2c,
>>> +                                 u32 clock, u32 prescaler)
>>> +{
>>> +       int fdr = mpc52xx_i2c_get_fdr(node, clock, prescaler);
>>> +
>>> +       if (fdr < 0)
>>> +               fdr = 0x3f; /* backward compatibility */
>>> +       writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>>> +       dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
>>> +}
>>> +
>>> +static void mpc_i2c_setclock_8xxx(struct device_node *node,
>>> +                                 struct mpc_i2c *i2c,
>>> +                                 u32 clock, u32 prescaler)
>>> +{
>>> +       int fdr = fsl_i2c_get_fdr(node, clock, prescaler);
>>> +
>>> +       if (fdr < 0)
>>> +               fdr = 0x1031; /* backward compatibility */
>>> +       writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>>> +       writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
>>> +       dev_info(i2c->dev, "clock %d Hz (dfsrr=%d fdr=%d)\n",
>>> +                clock, fdr >> 8, fdr & 0xff);
>>>  }
>> Very neat and tidy indeed.  I like this.

Yep.

>>> Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
>>> ===================================================================
>>> --- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c        2009-03-31 21:27:52.000000000 +0200
>>> +++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c     2009-04-01 12:09:18.796719327 +0200
>>> @@ -39,7 +39,7 @@
>>>  #include <sysdev/fsl_soc.h>
>>>  #include <mm/mmu_decl.h>
>>>  #include <asm/cpm2.h>
>>> -
>>> +#define DEBUG
>>  ^^^^^^^^^^^^^^^^^^^^^^^  oops?

Will fix.

Wolfgang.
