From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: i2c-davinci.c: CPU FREQ causes lock up due to xfr_complete
Date: Wed, 30 Jul 2014 11:48:54 +0530
Message-ID: <53D88E4E.3030108@ti.com>
References: <CADL8D3YchqfT+ikKTCkLNLmwm2HYKDzZy-g4T+mJLYBJ1rC72Q@mail.gmail.com>	<2588C357BB271A4CA8E86BCFF043FA920C4ACE9D@EFJDFWMB01.EFJDFW.local>	<CADL8D3aQ4idMNYZn-sK=8x9+NrVj=4p58C+ir8ZAngDavGB3-A@mail.gmail.com>	<CADL8D3a2gjbGZibENYNfvWrvGun82ZDm7A+i8NJRBKdRvMvgdQ@mail.gmail.com> <53D7DA44.2070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53D7DA44.2070108-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Jon Cormier <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>, Brian Niebuhr <BNiebuhr-0skhLfht8co@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Tim Iskander <tim.iskander-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >> linux-i2c" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 29 July 2014 11:00 PM, Grygorii Strashko wrote:
> Hi Jon,
> 
> On 07/29/2014 06:53 PM, Jon Cormier wrote:
>> A slimmer patch suggested by Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> 
> 
> Ok. The problem seems to be deeper than at first look.
> You have sequence (in Mainline kernel):
> cpufreq:
>  |- notify CPUFREQ_PRECHANGE
>     |- i2c-davinci will lock & put I2C in reset
>  |- cpufreq_driver->target_index
>     |- davinci_target()
>        |- pdata->set_voltage() - It will try to use I2C to set new voltage,
>        while I2C is in reset or locked! Bug!
>  |- notify CPUFREQ_POSTCHANGE
>     |- i2c-davinci will re-enable I2C and adjust I2C clock

Good find. I really wonder how this escaped so far. I can swear cpufreq
transitions were tested multiple times. From the description it looks
like this should hit every single time there is a voltage adjustment.

On DA850 which is the only DaVinci implementing cpufreq, I2C0 input
frequency will remain constant across cpufreq transitions since it
derives from PLL0 AUXCLK which is used pre-multipler/divider. It remains
fixed.

The code seems to have been added for I2C1 which does have a fixed ratio
with cpu clock.

PMIC should usually be put on I2C0 to help prevent these kind of issues.

> I see few possible ways to solve it:
> 1) use CLK notifier instead of CPUfreq notifiers

This will require common clock framework, right? We dont have that on
mach-davinci.

> 2) do smth similar to "61c7cff8 i2c: S3C24XX I2C frequency scaling support"
>   + "9bcd04bf i2c: s3c2410: grab adapter lock while changing i2c clock"

This looks promising. Although I wonder if delta_f will always remain
zero in s3c24xx_i2c_cpufreq_transition() when the CPUFREQ_PRECHANGE call
is made - because clock tree is not updated yet?

> 3) update I2C clock in CPUFREQ_POSTCHANGE - may be unsafe

Well, even now the I2C clock is only getting updated in POSTCHANGE,
right? Also, resetting I2C in PRECHANGE seems excessive. It is only
required when changing the prescalar. So you can do:

	} else if (val == CPUFREQ_POSTCHANGE) {
		davinci_i2c_reset_ctrl(dev, 0);
		i2c_davinci_calc_clk_dividers(dev);
		davinci_i2c_reset_ctrl(dev, 1);
	}

So this along with the i2c_lock_adapter() a la
s3c24xx_i2c_cpufreq_transition() should be the right fix, I guess.

Thanks,
Sekhar
