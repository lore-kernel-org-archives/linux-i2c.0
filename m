From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] i2c: opal: don't check number of messages in the
 driver
Date: Thu, 24 May 2018 16:13:26 +0200
Message-ID: <5e42cc19-0f2a-c4e8-b545-eaede1b1d520@axentia.se>
References: <20180520065035.7920-1-wsa@the-dreams.de>
 <20180520065035.7920-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180520065035.7920-3-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-05-20 08:50, Wolfram Sang wrote:
> Since commit 1eace8344c02 ("i2c: add param sanity check to
> i2c_transfer()") and b7f625840267 ("i2c: add quirk checks to core"), the
> I2C core does this check now. We can remove it here.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Peter Rosin <peda@axentia.se>

> ---
> 
> Only build tested.
> 
>  drivers/i2c/busses/i2c-opal.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
> index 0aabb7eca0c5..dc2a23f4fb52 100644
> --- a/drivers/i2c/busses/i2c-opal.c
> +++ b/drivers/i2c/busses/i2c-opal.c
> @@ -94,8 +94,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 */
>  	memset(&req, 0, sizeof(req));
>  	switch(num) {
> -	case 0:
> -		return 0;
>  	case 1:
>  		req.type = (msgs[0].flags & I2C_M_RD) ?
>  			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
> @@ -114,8 +112,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  		req.size = cpu_to_be32(msgs[1].len);
>  		req.buffer_ra = cpu_to_be64(__pa(msgs[1].buf));
>  		break;
> -	default:
> -		return -EOPNOTSUPP;
>  	}
>  
>  	rc = i2c_opal_send_request(opal_id, &req);
> 
