From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 7/8]ieee1394/sdp2 Fix warning: variable
 'unit_characteristics' set but not used
Date: Tue, 15 Jun 2010 13:38:30 +0200
Message-ID: <20100615133830.55afdddf@hyperion.delvare>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>
	<1276547208-26569-8-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276547208-26569-8-git-send-email-justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Jun 2010 13:26:47 -0700, Justin P. Mattock wrote:
> Temporary fix until something is resolved

This is wrong by design, sorry. Warnings aren't blocking, and thus need
no "temporary fix". Such temporary fixes would be only hiding the
warning, cancelling the good work of gcc developers. Nack nack nack.

> to fix the below warning:
>   CC [M]  drivers/ieee1394/sbp2.o
> drivers/ieee1394/sbp2.c: In function 'sbp2_parse_unit_directory':
> drivers/ieee1394/sbp2.c:1353:6: warning: variable 'unit_characteristics' set but not used
>  Signed-off-by: Justin P. Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
>  drivers/ieee1394/sbp2.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
> index 4565cb5..fcf8bd5 100644
> --- a/drivers/ieee1394/sbp2.c
> +++ b/drivers/ieee1394/sbp2.c
> @@ -1356,6 +1356,8 @@ static void sbp2_parse_unit_directory(struct sbp2_lu *lu,
>  
>  	management_agent_addr = 0;
>  	unit_characteristics = 0;
> +	if (!unit_characteristics)
> +		unit_characteristics = 0;
>  	firmware_revision = SBP2_ROM_VALUE_MISSING;
>  	model = ud->flags & UNIT_DIRECTORY_MODEL_ID ?
>  				ud->model_id : SBP2_ROM_VALUE_MISSING;


-- 
Jean Delvare
