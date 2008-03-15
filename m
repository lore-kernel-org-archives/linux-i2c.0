From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATH 0/3] isp1301 changes
Date: Sun, 16 Mar 2008 01:22:11 +0200
Message-ID: <31e679430803151622k3a76371bk4a6c898a9507e7d3@mail.gmail.com>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<20080315162832.067b8088@hyperion.delvare>
	<31e679430803150838n6638be05k53800bb74eeb3462@mail.gmail.com>
	<31e679430803150840p334e8d17ncdd1fdc431de8d82@mail.gmail.com>
	<20080315174731.29cfb554@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080315174731.29cfb554-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 15, 2008 at 6:47 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Sat, Mar 15, 2008 at 5:38 PM, Felipe Balbi
>  <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> wrote:
>  > On Sat, Mar 15, 2008 at 5:28 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>  >  > On Sat, 15 Mar 2008 14:47:14 +0200, Felipe Balbi wrote:
>  >  >  > Hi Jean,
>  >  >  >
>  >  >  > I have a new approach for the isp1301 driver, took your idea
>  >  >  > of adding a new irq_flags member to i2c_boardinfo and i2c_client.
>  >  >
>  >  >  I said we could do this _if_ many drivers needed this field. I didn't
>  >  >  mean to do it right now... So far I only know of the isp1301 driver
>  >  >  which would need this. And at any rate I'd like to hear David's opinion
>  >  >  before adding a new field to the core i2c structures.
>  >
>  >  Ok, so I'll prepare other patch based on addind include/i2c/isp1301_omap.h with
>  >  struct isp1301_platform_data.
>
>  Would be better, yes. If we finally decide to add an irq_flags field to
>  the i2c core structures, we'll update the isp1301 driver accordingly.

Ok, tomorrow probably i won't be able to work on that, but I'll update
asap and keep the other patches in a separate branch ;-)

>  >  But still, it makes really much sense adding this field cuz the
>  >  probability of having different irq flags on different boards is quite
>  >  high. Also, a driver shouldn't be conditional to an architecture. I
>  >  mean, isp1301 can be used with any arch, not only with omap. So as
>  >  much as we can make it platform independent as better driver we get.
>
>  I agree that it would be great if the isp1301 driver was arch-neutral.
>  But I fail to see how this is related to adding an irq_flags field to
>  struct i2c_board_info and struct i2c_client or not.

We're gonna have to keep adding arch-conditional code on that, if the
code were arch neutral a simple i2c_boardinfo and
i2c_register_boardinfo(); would be enough for the driver to work on
the new arch (possibly); otherwise we still have to keep "hacking"
isp1301 driver to add more arch-conditional code mostly cuz of
irq_flags (and some other bits we have to set on different arch, but
that makes sense going on a platform_data as well).

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
