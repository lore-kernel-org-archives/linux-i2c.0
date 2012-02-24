From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] i2c/designware: dw_i2c_init_driver as subsys initcall
Date: Fri, 24 Feb 2012 16:32:08 +0530
Message-ID: <4F476E30.60807@st.com>
References: <1321419487-2353-1-git-send-email-pratyush.anand@st.com> <20111116051440.GA3142@sapphire.tkos.co.il> <20111116052718.GE2286@DLH10011> <20111116082233.GB10335@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111116082233.GB10335-MwjkAAnuF3khR1HGirfZ1z4kX+cae0hd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/16/2011 1:52 PM, Baruch Siach wrote:
> Dependencies should be stated explicitly. Since this subsys_initcall thing is 
> quite common among the i2c masters I'm willing to ack this one for now. But 
> the real solution is to make the dependencies between devices clear and 
> explicit.

Baruch,

Did you apply this patch?

-- 
viresh
