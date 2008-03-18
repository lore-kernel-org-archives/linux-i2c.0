From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301: Sync with linux-omap
Date: Tue, 18 Mar 2008 15:28:32 +0200
Message-ID: <31e679430803180628h7a4926a2t4e540d9617522e28@mail.gmail.com>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-4-git-send-email-me@felipebalbi.com>
	<20080315124918.GA21547@kedavra.cpe.vivax.com.br>
	<20080315125458.GB21547@kedavra.cpe.vivax.com.br>
	<20080315131309.GA24990@kedavra.cpe.vivax.com.br>
	<20080316105617.GA4503@kedavra.cpe.vivax.com.br>
	<20080316110033.GB4503@kedavra.cpe.vivax.com.br>
	<20080318134633.16f6e5f1@hyperion.delvare>
	<31e679430803180609s2b404dabu1cac2e09f128ba96@mail.gmail.com>
	<20080318142337.0f9a2b5b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080318142337.0f9a2b5b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 18, 2008 at 3:23 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Tue, 18 Mar 2008 15:09:43 +0200, Felipe Balbi wrote:
>  > On Tue, Mar 18, 2008 at 2:46 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>  > > Hi Felipe,
>  > >
>  > >
>  > >  On Sun, 16 Mar 2008 13:00:35 +0200, Felipe Balbi wrote:
>  > >  > There are some changes on linux-omap's isp1301_omap.c
>  > >  > that could already be in linux-mainline after
>  > >  > omap1/2 got merged.
>  > >  >
>  > >  > This patch sync such changes from linux-omap into linux-mailine.
>  > >
>  > >  I fear I will need a better description than this. Please explain what
>  > >  the changes are and why they are needed. "sync with an external tree"
>  > >  isn't sufficient.
>  >
>  > Here's a better description:
>  >
>  > Now that omap1/2 were merged on mainline we can bring the isp1301_omap.c
>  > changes that were done for board-h3 and keep the code in sync. This will allow
>  > us to decrese the diff between linux-omap and mainline and avoid merge conflicts
>  > later.
>  >
>  >
>  > Is this good enough ?
>
>  No. You are just paraphrasing, this doesn't help. I need an explanation
>  of the _functional_ changes implemented by the patch. I don't care much
>  that these changes come from the omap tree, I don't know anything about
>  this tree. What I need to know is why the changes are needed by
>  themselves. What problem(s) does this patch address?

otherwise the driver won't work on board-h3, simple enough

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
