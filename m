From: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery
 function
Date: Mon, 27 Feb 2012 14:11:51 +0530
Message-ID: <4F4B41CF.7080603@st.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com> <351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com> <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com> <4F4B3072.6050903@nvidia.com> <4F4B3A62.4080409@st.com> <4F4B3D54.4010502@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4B3D54.4010502-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, "viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2/27/2012 1:52 PM, Laxman Dewangan wrote:
> On Monday 27 February 2012 01:40 PM, Rajeev kumar wrote:
>> On 2/27/2012 12:57 PM, Laxman Dewangan wrote:
>>> On Monday 27 February 2012 12:51 PM, Shubhrajyoti Datta wrote:
>>>> On Fri, Feb 24, 2012 at 5:01 PM, Viresh Kumar<viresh.kumar-qxv4g6HH51o@public.gmane.org>     wrote:
>>>>> From: Vincenzo Frascino<vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
>>>>>
>>>>> Add optional i2c_recover_bus() function to the Synopsys DesignWare I2C adapter
>>>>> driver that performs i2c bus recovery after timeout. The scope of this routine
>>>>> is to define i2c bus recovery procedure as specified in the i2c protocol Rev. 03
>>>>> section 3.16 titled "Bus clear".
>>>> What do you do in the function ?
>>>>
>>>> Could we have it in the driver file itself?
>>>>
>>> I think bus recovery mechanism is to send  extra clock on SCL line by
>>> toggling the pin (using gpio apis) and keep watching of sda line whether
>>> it becomes high or not.
>>> We can put this algorithms in the some common file (i2c/algos/) and so
>>> if any i2c bus driver want to use, they can use it.
>>> Little background: I am working on tegra i2c controller and we have
>>> similar logic in tegra-i2c driver which we want to upstream.
>>> If similar function is in common place, we can use this and need not to
>>> duplicating it on every bus driver.
>>>
>> I agreed with Laxman, as this is the protocol issue and so it should not
>> be in each individual driver. It should be the part of framework
>> itself. We need to implement something like
>> drivers/i2c/busses/i2c-gpio.c.  We need to investigate more on it.
>>
> I am thinking to put this in drivers/i2c/busses/bus_recovery_gpio.c.
> This will provide only one function and config variable for this code
> can be selected from different driver by select option. it will not be
> enabled as independent driver. Similar to regmap_i2c or regmap_spi which

What is this regmap_i2c or regmap_spi, I am not able to locate it.

> is selected through select in kconfig
>
> The function should take the gpio number and gpio flags for scl and sda,
> bus freq and number of clock to be sent.

Need to pass "number of clock to be sent" or not . I am not very much 
sure. I think number of clock to be sent is fixed.

~Rajeev

> All gpio related apis should be called on .c file which is implemented.
>
> How bus driver gets the corresponding gpio number is specific to bus
> driver but they need to pass all the information through arguments.
>
>
>
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> .
>
