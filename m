From: Naveen Kaje <nkaje@codeaurora.org>
Subject: Re: [15/18] i2c: i2c-qup: use new 8 bit address helper function
Date: Thu, 5 May 2016 12:27:20 -0600
Message-ID: <fdcbf59d-7d26-8151-6858-c73201510f9d@codeaurora.org>
References: <1459709101-24462-16-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44662 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbcEES10 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 14:27:26 -0400
In-Reply-To: <1459709101-24462-16-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On 4/3/2016 12:44 PM, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>   drivers/i2c/busses/i2c-qup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 23eaabb19f961a..cc6439ab3f7141 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -515,7 +515,7 @@ static int qup_i2c_get_data_len(struct qup_i2c_dev *qup)
>   static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>   			    struct i2c_msg *msg,  int is_dma)
>   {
> -	u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
> +	u16 addr = i2c_8bit_addr_from_msg(msg);
>   	int len = 0;
>   	int data_len;
Looks good to me. Tested ok on QDF2432.
There is another place in issue_read that we can use this helper 
function. I will send a follow up patch.

Reviewed by: Naveen Kaje <nkaje@codeaurora.org>
Tested by: Naveen Kaje <nkaje@codeaurora.org>
>   
