From: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery
 function
Date: Wed, 29 Feb 2012 09:59:31 +0100
Message-ID: <4F4DE8F3.6030407@st.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com> <351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com> <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com> <4F4B3072.6050903@nvidia.com> <CAM=Q2cs-nCuSmkBFtv4odbqoRJcPkXk4Rz-H=9S6RDG3Z8kcEQ@mail.gmail.com> <4F4B569F.3080607@st.com> <4F4B5A9A.4050303@st.com>,<CAOh2x=nfNGpBmHVd1bPT9+AezDMEjaC4ktj4hX9=yWg2_k7r3Q@mail.gmail.com> <4E01B0DA4B09044DB320A047A7063F8DCA93DAA13E@SAFEX1MAIL4.st.com> <4F4DB073.9030906@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4DB073.9030906-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Giuseppe BARBA <giuseppe.barba-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Viresh,

Il 29/02/2012 05:58, Viresh KUMAR ha scritto:
> On 2/28/2012 7:25 PM, Salvatore DE DOMINICIS wrote:
>> What happens if the bus is still stuck?
>> Do we need to check also for a change in SDA line?
>> I mean, if some device is not behaving correctly and does not change the SDA
>> (as mandated by standard) then we don't solve the issue.
>>
> I also wanted to ask this question over list, so that experienced people
> can suggest what should we do here.
>
> Following is mentioned in: UM10204: I2C-bus specification and user manual
> http://www.nxp.com/documents/user_manual/UM10204.pdf
>
> "3.1.16 Bus clear
>
> In the unlikely event where the clock (SCL) is stuck LOW, the preferential procedure is to 
> reset the bus using the HW reset signal if your I2C devices have HW reset inputs. If the 
> I2C devices do not have HW reset inputs, cycle power to the devices to activate the 
> mandatory internal Power-On Reset (POR) circuit.
>
> If the data line (SDA) is stuck LOW, the master should send nine clock pulses. The device 
> that held the bus LOW should release it sometime within those nine clocks. If not, then 
> use the HW reset or cycle power to clear the bus."
>
>
> It says that the hang situation is "SDA is stuck LOW" and 9 clock pulses should
> be enough to get it out of hang (Can somebody tell me how this figure of "9"
> derived?)
>
> SDA will become High, but what guarantees that this will not be low immediately
> after that, while we are reading SDA line? Or Is reading SDA line after 9 pulses
> sufficient?
>
>> static int i2c_device_probe(struct device *dev)
>>> {
>> +       /* bus recovery specific initialization */
>>> +       if (!adap->recover_bus) {
>>> +               if (!adap->clock_cnt || !adap->clock_rate)
>>> +                       goto warn_no_recovery;
> I will also change this code to something like:
>
>        if (!adap->recover_bus) {
>                if (!adap->clock_cnt)
>                        adap->clock_cnt = 9;
>
>                if (!adap->clock_rate)
>                        goto warn_no_recovery;
>
I think this is ok. It covers the standard situation and the experimental foundings.

Regards,

Vincenzo
