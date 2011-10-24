From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Change readl to readw and writel to
 writew
Date: Mon, 24 Oct 2011 07:03:09 +0200
Message-ID: <20111024050308.GA26649@sapphire.tkos.co.il>
References: <1319430293-2624-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1319430293-2624-1-git-send-email-rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rajeev,

On Mon, Oct 24, 2011 at 09:54:53AM +0530, Rajeev Kumar wrote:
> Since I2C designware registers are 16 bit wide and so we should use
> readw/writew.
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
> ---

For completeness I think you should also change the width of written/read 
values, e.g. ic_con, hcnt, lcnt.

I don't have hardware to test these changes though. Shinya, can you test this?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
