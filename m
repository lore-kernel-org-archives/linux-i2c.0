From: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 8/8]tuners:tuner-simple Fix warning: variable 'tun' set
 but not used
Date: Tue, 15 Jun 2010 08:16:20 +0300
Message-ID: <4C170CA4.2020805@redhat.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-9-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276547208-26569-9-git-send-email-justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



Em 14-06-2010 23:26, Justin P. Mattock escreveu:
> not sure if this is correct or not for 
> fixing this warning:
>   CC [M]  drivers/media/common/tuners/tuner-simple.o
> drivers/media/common/tuners/tuner-simple.c: In function 'simple_set_tv_freq':
> drivers/media/common/tuners/tuner-simple.c:548:20: warning: variable 'tun' set but not used
> 
>  Signed-off-by: Justin P. Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
>  drivers/media/common/tuners/tuner-simple.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/common/tuners/tuner-simple.c b/drivers/media/common/tuners/tuner-simple.c
> index 8abbcc5..4465b99 100644
> --- a/drivers/media/common/tuners/tuner-simple.c
> +++ b/drivers/media/common/tuners/tuner-simple.c
> @@ -545,14 +545,12 @@ static int simple_set_tv_freq(struct dvb_frontend *fe,
>  	struct tuner_simple_priv *priv = fe->tuner_priv;
>  	u8 config, cb;
>  	u16 div;
> -	struct tunertype *tun;
>  	u8 buffer[4];
>  	int rc, IFPCoff, i;
>  	enum param_type desired_type;
>  	struct tuner_params *t_params;
>  
> -	tun = priv->tun;
> -
> +	
Why are you adding an extra blank line here? Except for that, the patch
looks sane.

>  	/* IFPCoff = Video Intermediate Frequency - Vif:
>  		940  =16*58.75  NTSC/J (Japan)
>  		732  =16*45.75  M/N STD
