From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Convert pfc8563 i2c driver from old style to new
	style
Date: Tue, 19 Feb 2008 16:24:15 +0100
Message-ID: <20080219162415.601c7efe@hyperion.delvare>
References: <20080121200901.15517.30253.stgit@terra.home>
	<20080219161020.61f7ec10@hyperion.delvare>
	<9e4733910802190717g3a4b6ddejbd180a32d7dfae47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910802190717g3a4b6ddejbd180a32d7dfae47-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Clemens Koller <clemens.koller-IEdZaowOqhEb1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Feb 2008 10:17:43 -0500, Jon Smirl wrote:
> On 2/19/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Hi Jon,
> >
> > On Mon, 21 Jan 2008 15:09:01 -0500, Jon Smirl wrote:
> > > Convert pfc8563 i2c driver from old style to new style.
> 
> Let's just forget about this patch until the dynamic module loading
> support goes into the base.

Why? I don't see the rationale. New-style drivers are good even without
dynamic module loading.

> The Phytec PCM030 mpc5200 board uses this chip. They are staying out
> of tree because they've integrated real-time support which is not in
> mainline yet.


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
