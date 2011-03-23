From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 5/7] I2C: eg20t, remove unused variable
Date: Wed, 23 Mar 2011 11:09:56 +0100
Message-ID: <20110323110956.2edf6f33@endymion.delvare>
References: <1300870200-24405-1-git-send-email-jslaby@suse.cz>
	<1300870200-24405-5-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300870200-24405-5-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jiri,

On Wed, 23 Mar 2011 09:49:58 +0100, Jiri Slaby wrote:
> drivers/i2c/busses/i2c-eg20t.c:684:2: warning: Value stored to 'msglen' is never read
> msglen = (pmsg->len) - (subaddrlen + 1);
> ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: linux-i2c@vger.kernel.org
> ---
>  drivers/i2c/busses/i2c-eg20t.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)

This driver is under Ben Dooks's jurisdiction, not mine. You should get
this patch reviewed by him and Tomoya MORINAGA (both Cc'd.) It may be
that your simple fix is correct, but it may also be that the unused
variables should be used somewhere in the code for correctness. I can't
tell.

> 
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index 878a120..ea73252 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -651,8 +651,6 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	struct i2c_msg *pmsg;
>  	u32 i = 0;
>  	u32 status;
> -	u32 msglen;
> -	u32 subaddrlen;
>  	s32 ret;
>  
>  	struct i2c_algo_pch_data *adap = i2c_adap->algo_data;
> @@ -676,12 +674,6 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	status = pmsg->flags;
>  	pch_dbg(adap,
>  		"After invoking I2C_MODE_SEL :flag= 0x%x\n", status);
> -	/* calculate sub address length and message length */
> -	/* these are applicable only for buffer mode */
> -	subaddrlen = pmsg->buf[0];
> -	/* calculate actual message length excluding
> -	 * the sub address fields */
> -	msglen = (pmsg->len) - (subaddrlen + 1);
>  	if (status & (I2C_M_RD)) {
>  		pch_dbg(adap, "invoking pch_i2c_readbytes\n");
>  		ret = pch_i2c_readbytes(i2c_adap, pmsg, (i + 1 == num),


-- 
Jean Delvare
