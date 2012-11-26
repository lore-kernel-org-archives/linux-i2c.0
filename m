From: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 26 Nov 2012 13:28:22 +0000
Message-ID: <50B36E76.6010008@pcserviceselectronics.co.uk>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>	<50B20670.5070509@pcserviceselectronics.co.uk>	<CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>	<50B35642.7030104@pcserviceselectronics.co.uk> <CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Viresh Kumar wrote:
> On 26 November 2012 17:15, Paul Carpenter
> <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
>> Unless you know why the bus is stuck, how can you reset reminder this
>> method ONLY works if SCL is high and SDA probably was low and the slave
....

> Hi Paul,
> 
> I completely agree with what you said, and i also feel the need of it now.
> We don't have a solution for SCL stuck low, just by playing with pad values.
> And need some sort of reset of device, etc as mentioned by you earlier.
> 
> What we can do here, is check SCL's value and give an error message for
> SCL stuck low + return error.

Yes best method error to mean  "SCL stuck low or long clock stretch"

> The short circuit mentioned earlier will not happen in our case as we
> are setting gpio flags as OPEN_DRAIN and so we would never be writing
> 1 on SCL pad.

 From an earlier thread comment

 >> +    ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
 >> +            GPIOF_OUT_INIT_HIGH, "i2c-scl");
 >
 >I always get wary of people driving I2C with non-open-drain, especially
 >with stuck busses

I would want to know what "GPIOF_OUT_INIT_HIGH" did as that is
suspiciously driving output high at startup.


-- 
Paul Carpenter          | paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
<http://www.gnuh8.org.uk/>  GNU H8 - compiler & Renesas H8/H8S/H8 Tiny
<http://www.badweb.org.uk/> For those web sites you hate
