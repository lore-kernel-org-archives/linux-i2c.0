From: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery
 function
Date: Tue, 28 Feb 2012 15:05:34 +0100
Message-ID: <4F4CDF2E.8080704@st.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com> <351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com> <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com> <4F4B3072.6050903@nvidia.com> <CAM=Q2cs-nCuSmkBFtv4odbqoRJcPkXk4Rz-H=9S6RDG3Z8kcEQ@mail.gmail.com> <4F4B569F.3080607@st.com> <4F4B5A9A.4050303@st.com>,<CAOh2x=nfNGpBmHVd1bPT9+AezDMEjaC4ktj4hX9=yWg2_k7r3Q@mail.gmail.com> <4E01B0DA4B09044DB320A047A7063F8DCA93DAA13E@SAFEX1MAIL4.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E01B0DA4B09044DB320A047A7063F8DCA93DAA13E-+EwDPpWUVoSs+H57zxxw29BPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>
Cc: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Giuseppe BARBA <giuseppe.barba-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Salvatore,

Il 28/02/2012 14:55, Salvatore DE DOMINICIS ha scritto:
> Hi Viresh,
>
>> From: viresh kumar [viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> Sent: Tuesday, February 28, 2012 14:23
>> To: Viresh KUMAR
>> Cc: Rajeev KUMAR; Shubhrajyoti Datta; Laxman Dewangan; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; Armando VISCONTI; Shiraz HASHIM; Vipin KUMAR; Deepak SIKRI; Vipul Kumar SAMAR; Amit VIRDI; Pratyush ANAND; Bhupesh SHARMA; Bhavna YADAV; Vincenzo FRASCINO; Mirko GARDI; Salvatore DE DOMINICIS; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery function
>>
>> On 2/27/12, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wrote:
>>
>>> we can give generalized function inside i2c framework for this, so that
>>> multiple
>>> drivers can use it.
>>>
>>> Secondly there are drivers/devices where control of pins is available. For
>>> them
>>> we can provide driver hooks.
>>>
>>> I would try to provide a patch for this ASAP. Other suggestions are welcome.
>>>
>> Here we go, please provide your feedbacks.:
>>
>> From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
>> Date: Tue, 28 Feb 2012 18:26:31 +0530
>> Subject: [PATCH] i2c/adapter: Add bus recovery infrastructure
>>
>> Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
>> protocol Rev. 03 section 3.16 titled "Bus clear".
>>
>> Sometimes during operation i2c bus hangs and we need to give dummy clocks to
>> slave device to start the transfer again. Now we may have capability in the bus
>> controller to generate these clocks or platform may have gpio pins which can be
>> toggled to generate dummy clocks.
>>
>> This patch also adds in generic bus recovery routines gpio or scl line based
>> which can be used by bus controller. In addition controller driver may provide
>> its own version of the bus recovery routine.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
>> ---
>> drivers/i2c/i2c-core.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++
>> include/linux/i2c.h    |   22 ++++++++++++++++++
>> 2 files changed, 78 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index e9c1893..c9f0daf 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -26,7 +26,9 @@
>>
>> #include <linux/module.h>
>> #include <linux/kernel.h>
>> +#include <linux/delay.h>
>> #include <linux/errno.h>
>> +#include <linux/gpio.h>
>> #include <linux/slab.h>
>> #include <linux/i2c.h>
>> #include <linux/init.h>
>> @@ -103,6 +105,47 @@ static int i2c_device_uevent(struct device *dev,
>> struct kobj_uevent_env *env)
>> #define i2c_device_uevent      NULL
>> #endif /* CONFIG_HOTPLUG */
>>
>> +/* i2c bus recovery routines */
>> +static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
>> +{
>> +       int tmp, val = 1;
>> +       unsigned long delay = 1000000;
>> +
> Why delay is fixed to this value? This seems to me that this value is dependant on i2c clock speed,
> e.g. 100kHz, 400kHz, have different periods and thus need different delay times,
> am I correct?

This is not a fixed value, delay is only initialized here. (look below)
>
>> +       tmp = gpio_request_one(adap->scl_gpio, GPIOF_DIR_OUT |
>> +                       GPIOF_INIT_LOW, "i2c-bus-recover");
>> +       if (tmp < 0) {
>> +               dev_warn(&adap->dev, "gpio request one fail: %d\n",
>> +                               adap->scl_gpio);
>> +               return tmp;
>> +       }
>> +
>> +       delay /= adap->clock_rate * 2;

It is dynamically calculated here through clock_rate.
>> +
>> +       for (tmp = 0; tmp < adap->clock_cnt * 2; tmp++, val = !val) {
>> +               ndelay(delay);
>> +               gpio_set_value(adap->scl_gpio, val);
>> +       }
>> +
>> +       gpio_free(adap->clock_cnt);
>> +
>> +       return 0;
>> +}
>> +
>
BR,

Vincenzo
