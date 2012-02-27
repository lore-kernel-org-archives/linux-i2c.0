From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery
 function
Date: Mon, 27 Feb 2012 12:57:46 +0530
Message-ID: <4F4B3072.6050903@nvidia.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>	<351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com> <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "armando.visconti-qxv4g6HH51o@public.gmane.org" <armando.visconti-qxv4g6HH51o@public.gmane.org>, "shiraz.hashim-qxv4g6HH51o@public.gmane.org" <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, "vipin.kumar-qxv4g6HH51o@public.gmane.org" <vipin.kumar-qxv4g6HH51o@public.gmane.org>, "rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org" <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, "deepak.sikri-qxv4g6HH51o@public.gmane.org" <deepak.sikri-qxv4g6HH51o@public.gmane.org>, "vipulkumar.samar-qxv4g6HH51o@public.gmane.org" <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, "amit.virdi-qxv4g6HH51o@public.gmane.org" <amit.virdi-qxv4g6HH51o@public.gmane.org>, "pratyush.anand-qxv4g6HH51o@public.gmane.org" <pratyush.anand-qxv4g6HH51o@public.gmane.org>, "bhupesh.sharma-qxv4g6HH51o@public.gmane.org" <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, "viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "bhavna.yadav-qxv4g6HH51o@public.gmane.org" <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, "vincenzo.frascino-qxv4g6HH51o@public.gmane.org" <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, "mirko.gardi-qxv4g6HH51o@public.gmane.org" <mirko.gardi-qxv4g6HH51o@public.gmane.org>, "salvatore.dedominicis-qxv4g6HH51o@public.gmane.org" <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, linux-i2c@vger
List-Id: linux-i2c@vger.kernel.org

On Monday 27 February 2012 12:51 PM, Shubhrajyoti Datta wrote:
> On Fri, Feb 24, 2012 at 5:01 PM, Viresh Kumar<viresh.kumar-qxv4g6HH51o@public.gmane.org>  wrote:
>> From: Vincenzo Frascino<vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
>>
>> Add optional i2c_recover_bus() function to the Synopsys DesignWare I2C adapter
>> driver that performs i2c bus recovery after timeout. The scope of this routine
>> is to define i2c bus recovery procedure as specified in the i2c protocol Rev. 03
>> section 3.16 titled "Bus clear".
> What do you do in the function ?
>
> Could we have it in the driver file itself?
>
I think bus recovery mechanism is to send  extra clock on SCL line by 
toggling the pin (using gpio apis) and keep watching of sda line whether 
it becomes high or not.
We can put this algorithms in the some common file (i2c/algos/) and so 
if any i2c bus driver want to use, they can use it.
Little background: I am working on tegra i2c controller and we have 
similar logic in tegra-i2c driver which we want to upstream.
If similar function is in common place, we can use this and need not to 
duplicating it on every bus driver.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
