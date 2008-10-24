From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v7] Add ov772x driver
Date: Fri, 24 Oct 2008 20:40:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810242035130.7996@axis700.grange>
References: <uhc77mucm.wl%morimoto.kuninori@renesas.com>
	<aec7e5c30810222026g4622aafcrf70cde31bcb0c602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <aec7e5c30810222026g4622aafcrf70cde31bcb0c602-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: V4L <video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Magnus,

thanks for the Acked-by, but, unfortunately, as the contents of the driver 
has changed in -v8 (0x38 instead of 0x40), I cannot use this for the new 
version. If you want, you can re-test and re-send for -v8. You might also 
consider using Tested-by instead-of Acked-by (see 
Documentation/SubmittingPatches) - decide for yourself whichever you 
prefer. I'll push it now, but if you're fast enough, maybe Mauro will pick 
up your *-by on the way to Linus.

Thanks
Guennadi

On Thu, 23 Oct 2008, Magnus Damm wrote:

> On Mon, Oct 20, 2008 at 7:09 PM, Kuninori Morimoto
> <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> > This patch adds ov772x driver that use soc_camera framework.
> > It was tested on SH Migo-r board.
> >
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > ---
> > PATCH v6 -> v7
> 
> This works just fine on my Migo-R board as well. Much better than my
> old soc_camera_platform hack.
> 
> Acked-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
> 
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
