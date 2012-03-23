From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c/busses: Add PM support
Date: Fri, 23 Mar 2012 13:40:11 +0530
Message-ID: <4F6C2FE3.7010700@st.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, "viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2/24/2012 5:01 PM, Viresh KUMAR wrote:
> From: Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>
> 
> This patch adds in support for standby/S2R/hybernate for i2c-designware driver.
> 
> Signed-off-by: Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)

Hi Wolfram,

Any inputs of this patch?
You can discard 2/2 of this patchset, as that patch is included in
a separate patchset "I2C: Add bus recovery infrastructure".

-- 
viresh
