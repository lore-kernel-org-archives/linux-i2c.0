From: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] i2c/designware: dw_i2c_init_driver as subsys initcall
Date: Wed, 16 Nov 2011 10:57:19 +0530
Message-ID: <20111116052718.GE2286@DLH10011>
References: <1321419487-2353-1-git-send-email-pratyush.anand@st.com>
 <20111116051440.GA3142@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111116051440.GA3142-MwjkAAnuF3khR1HGirfZ1z4kX+cae0hd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Baruch,

On Wed, Nov 16, 2011 at 01:14:41PM +0800, Baruch Siach wrote:
> Hi Pratyush Anand,
> 
> On Wed, Nov 16, 2011 at 10:28:07AM +0530, Pratyush Anand wrote:
> > There are few drivers(for example stmpe-gpio) which are available on i2c
> > bus but has been initialized as subsys initcall. Therefore i2c driver
> > must also be initialized as subsys initcall.
> > 
> > Signed-off-by: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
> > ---
> 
> NAK.
> 
> Dependency problem like this one should be solved using the probe deferral 
> mechanism, when it's merged 
> (http://thread.gmane.org/gmane.linux.ports.arm.omap/65436). Sprinkling those 
> really_really_early_initcall() all over the place is unreasonable IMO.

Being a bus driver in this particular case, don't you think that it
should explicitly appear before devices using this bus.

--
regards
Shiraz
