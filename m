From: Richard Retanubun <richardretanubun-4VtgCsEi+FIybS5Ee8rs3A@public.gmane.org>
Subject: Question on i2c->real_clk when MPC_I2C_CLOCK_PRESERVE is set
Date: Fri, 3 Feb 2012 10:44:24 -0500
Message-ID: <4F2C00D8.4080207@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: albrecht.dress-KvP5wT2u2U0@public.gmane.org
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Albrecht,

I am working on an MPC8360e platfrom and linux-3.0.0
I am seeing some stability issue with i2c and have some questions.

In git commit "powerpc/5200/i2c: improve i2c bus error recovery"
0c2daaafcdec726e89cbccca61d576de8429c537

The concept of i2c->real_clk is introduced to better optimize mpc_i2c_fixup().
Unless I am mistaken, in the current implementation, when MPC_I2C_CLOCK_PRESERVE is set,
i2c->real_clk is never initialized.

So lets presume that its value is likely 0.

That makes mpc_i2c_fixup() look like this:

int k;
u32 delay_val = 1000000 / i2c->real_clk + 1; /* delay_val = 1000000 */

if (delay_val < 2)
	delay_val = 2;

for (k = 9; k; k--) {
	writeccr(i2c, 0);
	writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
	udelay(delay_val); /* 1000000us = 1 sec */
	writeccr(i2c, CCR_MEN);
	udelay(delay_val << 1); /* 2000000 = 2 sec */
}

Which I think is not the intended value, no?

I tried to see if I can populate i2c->real_clk using the preserved values inside fdr and dfsrr
but I don't think that's possible without a lookup table (or another dts binding)

The other thought I have to in addition of a mininum delay_val of 2, we can also add a maximum limit
for delay_val (of 30us ? to maintain the delay of the previous version)

As an aside, uboot seems to have a way to figure out the correct values of fdr and dfsrr without lookup
/drivers/i2c/fsl-i2c.c::set_i2c_bus_speed(). This will prevent needing to use MPC_I2C_CLOCK_PRESERVE
and get i2c->real_clk calculated properly.

Thanks for your time.

-- 
Richard Retanubun
