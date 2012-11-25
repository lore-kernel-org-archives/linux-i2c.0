From: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Sun, 25 Nov 2012 11:52:16 +0000
Message-ID: <50B20670.5070509@pcserviceselectronics.co.uk>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Viresh Kumar wrote:
 > Add i2c bus recovery infrastructure to i2c adapters as specified in 
the i2c
 > protocol Rev. 03 section 3.1.16 titled "Bus clear".
 >
 > http://www.nxp.com/documents/user_manual/UM10204.pdf

You should also take note of section 3.1.14 and its notes on Software
Reset -
     "Precautions must be taken to ensure that a device is not
      pulling down the SDA or SCL line after applying the supply
      voltage, since these low levels would block the bus"

 > Sometimes during operation i2c bus hangs and we need to give dummy 
clocks to
 > slave device to start the transfer again. Now we may have capability 
in the bus
 > controller to generate these clocks or platform may have gpio pins 
which can be
 > toggled to generate dummy clocks. This patch supports both.

I may have missed it but misses an I2C check step, but that could be
because I do so much embedded and hardware side as well.

 > This patch also adds in generic bus recovery routines gpio or scl 
line based
 > which can be used by bus controller. In addition controller driver 
may provide
 > its own version of the bus recovery routine.
 >
 > This doesn't support multi-master recovery for now.
 >
 > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
 > ---
 >
 > Hi Wolfram,
 >
 > I am sending V7 before closing our comments completely on V6 (Very 
few are left
 > now :) ), so that you can get an idea of what i am implementing now. It
 > incorporates all your comments leaving:
.....

 > +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
 > +{
 > +    struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 > +    struct device *dev = &adap->dev;
 > +    int ret = 0;

Where is the check that SCL is NOT low (bus fault or device doing clock
stretching)

 > +    ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
 > +            GPIOF_OUT_INIT_HIGH, "i2c-scl");

I always get wary of people driving I2C with non-open-drain, especially
with stuck busses

 > +    if (ret) {
 > +        dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
 > +        return ret;
 > +    }
 > +
 > +    if (!bri->skip_sda_polling) {
 > +        if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
 > +            /* work without sda polling */
 > +            dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
 > +                    bri->sda_gpio);
 > +            bri->skip_sda_polling = true;
 > +        }
 > +    }
 > +
 > +    return ret;
 > +}

.....


 > +static int i2c_generic_recovery(struct i2c_adapter *adap)
 > +{
 > +    struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 > +    unsigned long delay = 1000000; /* 106/KHz for delay in ns */
 > +    int i, val = 0;
 > +
 > +    if (bri->prepare_recovery)
 > +        bri->prepare_recovery(bri);
 > +
 > +    /*
 > +     * By this time SCL is high, as we need to give 9 falling-rising 
edges
 > +     */

In my view that needs to be done by an actual check of the real SCL not
assumption.

 > +    delay = DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
 > +
 > +    for (i = 0; i < RECOVERY_CLK_CNT * 2; i++, val = !val) {
 > +        bri->set_scl(adap, val);
 > +        ndelay(delay);
 > +
 > +        /* break if sda got high, check only when scl line is high */
 > +        if (!bri->skip_sda_polling && val)

Dont use 'val' read the actual SCL line which ensures you you are not
wasting your time because of hardware fault. Possibly saving your GPIO
from being stuck permanently.

 > +            if (unlikely(bri->get_sda(adap)))
 > +                break;
 > +    }
 > +
 > +    if (bri->unprepare_recovery)
 > +        bri->unprepare_recovery(bri);
 > +
 > +    return 0;
 > +}

-- 
Paul Carpenter          | paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
<http://www.gnuh8.org.uk/>  GNU H8 - compiler & Renesas H8/H8S/H8 Tiny
<http://www.badweb.org.uk/> For those web sites you hate
