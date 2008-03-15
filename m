From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATH 0/3] isp1301 changes
Date: Sat, 15 Mar 2008 17:40:06 +0200
Message-ID: <31e679430803150840p334e8d17ncdd1fdc431de8d82@mail.gmail.com>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<20080315162832.067b8088@hyperion.delvare>
	<31e679430803150838n6638be05k53800bb74eeb3462@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430803150838n6638be05k53800bb74eeb3462-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Fixing Dave's email. It was mis-spelled earlier.

On Sat, Mar 15, 2008 at 5:38 PM, Felipe Balbi
<felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> wrote:
> On Sat, Mar 15, 2008 at 5:28 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>  > On Sat, 15 Mar 2008 14:47:14 +0200, Felipe Balbi wrote:
>  >  > Hi Jean,
>  >  >
>  >  > I have a new approach for the isp1301 driver, took your idea
>  >  > of adding a new irq_flags member to i2c_boardinfo and i2c_client.
>  >
>  >  I said we could do this _if_ many drivers needed this field. I didn't
>  >  mean to do it right now... So far I only know of the isp1301 driver
>  >  which would need this. And at any rate I'd like to hear David's opinion
>  >  before adding a new field to the core i2c structures.
>
>  Ok, so I'll prepare other patch based on addind include/i2c/isp1301_omap.h with
>  struct isp1301_platform_data.
>
>  But still, it makes really much sense adding this field cuz the
>  probability of having different irq flags on different boards is quite
>  high. Also, a driver shouldn't be conditional to an architecture. I
>  mean, isp1301 can be used with any arch, not only with omap. So as
>  much as we can make it platform independent as better driver we get.
>
>
>  >  > If it's ok for you, i'll also send a patch putting linux-omap and
>  >  > linux-mailine isp1301 in sync.
>  >
>  >  This would be great, yes. Divergence between trees tend to confuse
>  >  developers, often I receive patches which do not apply to my tree
>  >  because of this.
>
>  I already have such patch for both linux-omap and linux-mainline, but
>  it's based on adding irq_flags to i2c_boardinfo and i2c_client. So
>  let's wait Dave's comments ;-)
>
>  --
>  Best Regards,
>
>  Felipe Balbi
>  felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>



-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
