From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery
 function
Date: Mon, 27 Feb 2012 15:57:38 +0530
Message-ID: <4F4B5A9A.4050303@st.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com> <351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com> <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com> <4F4B3072.6050903@nvidia.com> <CAM=Q2cs-nCuSmkBFtv4odbqoRJcPkXk4Rz-H=9S6RDG3Z8kcEQ@mail.gmail.com> <4F4B569F.3080607@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4B569F.3080607-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, "viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2/27/2012 3:40 PM, Rajeev KUMAR wrote:
> In some i2c controller (like synopsys) you dont have control over i2c 
> data and clock lines. So clock toggling, you need to use gpio lines 
> which in turns maps on sda and scl line.
> 
> For the controller in which you have control over sda and scl line there 
> is not need for gpio lines. You can directly write on registers.
> 
> So to make the function more generic its better to control i2c lines 
> with gpio.

There would be many drivers where we need to convert i2c pins to gpio pins
and generate clock pulses:

gpio_request(gpio);
gpio_set_direction(gpio, out, 0);

for (i = 1; i < count; i++) {
	gpio set val(gpio, 1);
	gpio set val(gpio, 0);
}

gpio_free(gpio);

we can give generalized function inside i2c framework for this, so that multiple
drivers can use it.

Secondly there are drivers/devices where control of pins is available. For them
we can provide driver hooks.

I would try to provide a patch for this ASAP. Other suggestions are welcome.

-- 
viresh
