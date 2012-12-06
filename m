From: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 06 Dec 2012 20:30:19 +0000
Message-ID: <50C1005B.7@pcserviceselectronics.co.uk>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org> <CAKohpokjxh0DDZVFy1uN7ejdd_=jkbyVvYCy73jJChMy5dKeGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpokjxh0DDZVFy1uN7ejdd_=jkbyVvYCy73jJChMy5dKeGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Viresh Kumar wrote:
> On 3 December 2012 08:24, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
>> protocol Rev. 03 section 3.1.16 titled "Bus clear".
>>
>> http://www.nxp.com/documents/user_manual/UM10204.pdf
>>
>> Sometimes during operation i2c bus hangs and we need to give dummy clocks to
>> slave device to start the transfer again. Now we may have capability in the bus
>> controller to generate these clocks or platform may have gpio pins which can be
>> toggled to generate dummy clocks. This patch supports both.
>>
>> This patch also adds in generic bus recovery routines gpio or scl line based
>> which can be used by bus controller. In addition controller driver may provide
>> its own version of the bus recovery routine.
>>
>> This doesn't support multi-master recovery for now.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> V7->V8:
>> - Clk rate fixed to 100KHz
>> - Check SCL line to see if it is LOW due to some faults
>> - removed last use of unlikely() in earlier patch
>> - Enhanced comment over skip_sda_polling
> 
> As merge window is shifted for few more days, i am trying another
> time to get this in 3.8 :)
> 
> @Paul/Wolfram: Any more comments ?

OK by me

Reviewed-by: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>

-- 
Paul Carpenter          | paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
<http://www.gnuh8.org.uk/>  GNU H8 - compiler & Renesas H8/H8S/H8 Tiny
<http://www.badweb.org.uk/> For those web sites you hate
