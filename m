From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [PATCH 4/9] i2c: brcmstb: enable ACK condition
Date: Thu, 14 Jul 2016 13:15:29 +0900
Message-ID: <974DB801-538F-44AA-9ADD-239E9081077F@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com> <1445395021-4204-5-git-send-email-jaedon.shin@gmail.com> <20151130153712.GO1513@katana>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32905 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbcGNEPe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Jul 2016 00:15:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so3836128pfe.0
        for <linux-i2c@vger.kernel.org>; Wed, 13 Jul 2016 21:15:34 -0700 (PDT)
In-Reply-To: <20151130153712.GO1513@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org

Hi Kamal,

On Dec 1, 2015, at 12:37 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> On Wed, Oct 21, 2015 at 11:36:56AM +0900, Jaedon Shin wrote:
>> Removes the condition of a message with under 32 bytes in length. The
>> messages that do not require an ACK are I2C_M_IGNORE_NAK flag.
> 
> Makes me wonder why it worked before? Kamal?
> 
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> drivers/i2c/busses/i2c-brcmstb.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
>> index 2d7d155029dc..53eb8b0c9bad 100644
>> --- a/drivers/i2c/busses/i2c-brcmstb.c
>> +++ b/drivers/i2c/busses/i2c-brcmstb.c
>> @@ -330,7 +330,7 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
>> 	int no_ack = pmsg->flags & I2C_M_IGNORE_NAK;
>> 
>> 	/* see if the transaction needs to check NACK conditions */
>> -	if (no_ack || len <= N_DATA_BYTES) {

Could you please explain why have NOACK with smaller transfer size? I don't find any 
reason about NOACK when smaller size, and the driver always operates NOACK by "len <= xfersz".

brcmstb_i2c_xfer(...)
{
	int xfersz = brcmstb_i2c_get_xfersz(dev);
	...
	bytes_to_xfer = min(len, xfersz);
	...
	brcmstb_i2c_xfer_bsc_data(..., bytes_to_xfer, ...);
	...

I have a plan for v2 that has for BMIPS_GENERIC and this patch with the latest driver.

Thanks!
--
Jaedon

>> +	if (no_ack) {
>> 		cmd = (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
>> 			: CMD_WR_NOACK;
>> 		pi2creg->ctlhi_reg |= BSC_CTLHI_REG_IGNORE_ACK_MASK;
>> -- 
>> 2.6.1
>> 
