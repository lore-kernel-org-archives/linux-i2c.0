From: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Change readl to readw and writel to writew
Date: Mon, 24 Oct 2011 15:27:20 +0530
Message-ID: <4EA53680.4040401@st.com>
References: <1319430293-2624-1-git-send-email-rajeev-dlh.kumar@st.com> <20111024050308.GA26649@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111024050308.GA26649-MwjkAAnuF3khR1HGirfZ1z4kX+cae0hd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Baruch

On 10/24/2011 10:33 AM, Baruch Siach wrote:
> Hi Rajeev,
>
> On Mon, Oct 24, 2011 at 09:54:53AM +0530, Rajeev Kumar wrote:
>> Since I2C designware registers are 16 bit wide and so we should use
>> readw/writew.
>>
>> Signed-off-by: Rajeev Kumar<rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
>> ---
>
> For completeness I think you should also change the width of written/read
> values, e.g. ic_con, hcnt, lcnt.
>
> I don't have hardware to test these changes though. Shinya, can you test this?
>
> baruch
>
Good catch

I will circulate patch v2 for this.

~Regards
Rajeev
