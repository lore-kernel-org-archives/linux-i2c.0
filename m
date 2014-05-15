From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2] i2c: ocores: Make of_device_id array const
Date: Thu, 15 May 2014 15:43:59 +0900
Message-ID: <000d01cf7009$0d62d070$28287150$%han@samsung.com>
References: <005801cf6fca$af7fd0e0$0e7f72a0$%han@samsung.com>
 <87lhu3tuq1.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <87lhu3tuq1.fsf-D6SC8u56vOOJDPpyT6T3/w@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Peter Korsgaard' <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Maxime COQUELIN' <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, May 15, 2014 3:36 PM, Peter Korsgaard wrote:
> 
> >>>>> "Jingoo" == Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> writes:
> 
> You seem to have forgotten to change subject, but I guess Wolfram can
> fix that when committing (E.G. s/ocores/busses/).

Oh, it's my mistake! I will fix the subject and send
v3 patch, soon. Thank you for your notification. :-)

Best regards,
Jingoo Han

> 
>  > Make of_device_id array const, because all OF functions
>  > handle it as const.
> 
>  > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>  > Acked-by: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
>  > Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
>  > ---
>  > Changes since v1:
>  > - squashed all patches into a single patch
>  > - added acked-by
> 
> --
> By, Peter Korsgaard
