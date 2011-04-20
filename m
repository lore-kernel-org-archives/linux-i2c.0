From: "Tomoya MORINAGA" <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: RE: [PATCH 5/7] I2C: eg20t, remove unused variable
Date: Wed, 20 Apr 2011 09:04:27 +0900
Message-ID: <8E3665F04B674455AC81C533493D964F@hacdom.okisemi.com>
References: <1300870200-24405-1-git-send-email-jslaby@suse.cz> <1300870200-24405-5-git-send-email-jslaby@suse.cz> <3DCFFD98C696488F94CB1A74F2998DF9@hacdom.okisemi.com> <4DADA4D8.4080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DADA4D8.4080602-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Jiri Slaby' <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Jiri Slaby' <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jean Delvare' <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 Hi Jiri

Until now, this driver have been reviewed / accepted by Ben Dooks [ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org].
Thus, I think he will review / accept with sooner or later.

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.


> -----Original Message-----
> From: Jiri Slaby [mailto:jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
> Sent: Wednesday, April 20, 2011 12:06 AM
> To: Tomoya MORINAGA
> Cc: 'Jiri Slaby'; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 'Jean 
> Delvare'; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 5/7] I2C: eg20t, remove unused variable
> 
> On 03/23/2011 11:50 AM, Tomoya MORINAGA wrote:
> > Hi Jiri,
> > 
> > It looks OK.
> > 
> > Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
> 
> Hi, will somebody take it or should I resubmit?
> 
> > Thanks,
> > -----------------------------------------
> > Tomoya MORINAGA
> > OKI SEMICONDUCTOR CO., LTD.
> > 
> >> -----Original Message-----
> >> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> [mailto:linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Jiri Slaby
> >> Sent: Wednesday, March 23, 2011 5:50 PM
> >> To: jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Jiri Slaby; Jean Delvare; 
> >> linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Subject: [PATCH 5/7] I2C: eg20t, remove unused variable
> >>
> >> drivers/i2c/busses/i2c-eg20t.c:684:2: warning: Value stored to 
> >> 'msglen' is never read msglen = (pmsg->len) - (subaddrlen + 1);
> >> ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> Signed-off-by: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
> >> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> >> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> ---
> >>  drivers/i2c/busses/i2c-eg20t.c |    8 --------
> >>  1 files changed, 0 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-eg20t.c 
> >> b/drivers/i2c/busses/i2c-eg20t.c index 878a120..ea73252 100644
> >> --- a/drivers/i2c/busses/i2c-eg20t.c
> >> +++ b/drivers/i2c/busses/i2c-eg20t.c
> >> @@ -651,8 +651,6 @@ static s32 pch_i2c_xfer(struct i2c_adapter 
> >> *i2c_adap,
> >>  	struct i2c_msg *pmsg;
> >>  	u32 i = 0;
> >>  	u32 status;
> >> -	u32 msglen;
> >> -	u32 subaddrlen;
> >>  	s32 ret;
> >>  
> >>  	struct i2c_algo_pch_data *adap = i2c_adap->algo_data; 
> @@ -676,12 
> >> +674,6 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
> >>  	status = pmsg->flags;
> >>  	pch_dbg(adap,
> >>  		"After invoking I2C_MODE_SEL :flag= 0x%x\n", status);
> >> -	/* calculate sub address length and message length */
> >> -	/* these are applicable only for buffer mode */
> >> -	subaddrlen = pmsg->buf[0];
> >> -	/* calculate actual message length excluding
> >> -	 * the sub address fields */
> >> -	msglen = (pmsg->len) - (subaddrlen + 1);
> >>  	if (status & (I2C_M_RD)) {
> >>  		pch_dbg(adap, "invoking pch_i2c_readbytes\n");
> >>  		ret = pch_i2c_readbytes(i2c_adap, pmsg, (i + 1 == num),
> >> --
> >> 1.7.4.1
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe 
> >> linux-kernel" in the body of a message to 
> majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
> >>
> > 
> 
> 
> --
> js
> 
