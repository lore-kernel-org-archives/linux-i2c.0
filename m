From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery function
Date: Mon, 2 Jul 2012 12:02:33 +0530
Message-ID: <CAM=Q2ct+z_bGYvaOvAQ=AEzOSNh4Uob-HY-DemsYeS-mB-juEg@mail.gmail.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>
	<351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com>
	<CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com>
	<4F4B3072.6050903@nvidia.com>
	<CAM=Q2cs-nCuSmkBFtv4odbqoRJcPkXk4Rz-H=9S6RDG3Z8kcEQ@mail.gmail.com>
	<4F4B569F.3080607@st.com>
	<4FF1388B.4030108@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FF1388B.4030108-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, "viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 2, 2012 at 11:28 AM, Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org> wrote:
> Hi Shubhrajyoti,
>
>
> On 2/27/2012 3:40 PM, Rajeev kumar wrote:
>>
>> On 2/27/2012 2:42 PM, Shubhrajyoti Datta wrote:
>>>
>>> On Mon, Feb 27, 2012 at 12:57 PM, Laxman
>>> Dewangan<ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>  wrote:
>>>>
>>>> On Monday 27 February 2012 12:51 PM, Shubhrajyoti Datta wrote:
>>>>>
>>>>>
>>>>> On Fri, Feb 24, 2012 at 5:01 PM, Viresh
>>>>> Kumar<viresh.kumar-qxv4g6HH51o@public.gmane.org>    wrote:
>>>>>>
>>>>>>
>>>>>> From: Vincenzo Frascino<vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
>>>>>>
>>>>>> Add optional i2c_recover_bus() function to the Synopsys DesignWare I2C
>>>>>> adapter
>>>>>> driver that performs i2c bus recovery after timeout. The scope of this
>>>>>> routine
>>>>>> is to define i2c bus recovery procedure as specified in the i2c
>>>>>> protocol
>>>>>> Rev. 03
>>>>>> section 3.16 titled "Bus clear".
>>>>>
>>>>>
>>>>> What do you do in the function ?
>>>>>
>>>>> Could we have it in the driver file itself?
>>>>>
>>>> I think bus recovery mechanism is to send  extra clock on SCL line by
>>>> toggling the pin (using gpio apis)
>>>
>>> You mean the SCL I didnt understand the gpio part?
>
>
> Sorry, if I am out of sync.
> Is any necessary action taken on this patch ?
>

IIUC ,

On timeout we need to send some clock cycles.
For this you say you are using gpio apis.
I didnt understand this.

Thanks,
