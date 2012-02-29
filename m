From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery
 function
Date: Wed, 29 Feb 2012 17:28:17 +0530
Message-ID: <4F4E12D9.90909@st.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com> <351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com> <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com> <4F4B3072.6050903@nvidia.com> <CAM=Q2cs-nCuSmkBFtv4odbqoRJcPkXk4Rz-H=9S6RDG3Z8kcEQ@mail.gmail.com> <4F4B569F.3080607@st.com>	<4F4B5A9A.4050303@st.com> <CAOh2x=nfNGpBmHVd1bPT9+AezDMEjaC4ktj4hX9=yWg2_k7r3Q@mail.gmail.com> <4F4E118B.2030403@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4E118B.2030403-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2/29/2012 5:22 PM, Laxman Dewangan wrote:
> On Tuesday 28 February 2012 06:53 PM, viresh kumar wrote:

>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c

>> +static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
>> +{
>> +	int tmp, val = 1;
>> +	unsigned long delay = 1000000;
>> +
>> +	tmp = gpio_request_one(adap->scl_gpio, GPIOF_DIR_OUT |
>> +			GPIOF_INIT_LOW, "i2c-bus-recover");
> 
> Should rename tmp to ret or status. tmp does not looks appropriate.
> 

Ok.

>> +	if (tmp<  0) {
>> +		dev_warn(&adap->dev, "gpio request one fail: %d\n",
>> +				adap->scl_gpio);
>> +		return tmp;
>> +	}
>> +
>> +	delay /= adap->clock_rate * 2;
> Here delay is turning as micor sec and function used as the nano sec.

clock_rate is in KHz, mentioned in comment of clock_rate.
Makes sense now or am i missing something?

>> +
>> +	for (tmp = 0; tmp<  adap->clock_cnt * 2; tmp++, val = !val) {
>> +		ndelay(delay);
> should be udelay()?

Please add blank lines before and after your comment. That makes
it more readable.

>> +		gpio_set_value(adap->scl_gpio, val);
> 
> I think it should check for the sda line for coming out of the loop. 
> There may be possibility that we may not need 9 clock pulses.
> 

I asked this in another mail, how to be sure that it will work.


>> +	u8 scl_gpio;
> gpio can be more than 256. better to use int.
> Take scl_gpio_flag and use in the gpio_request_one.

Ok.

-- 
viresh
