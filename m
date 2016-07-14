From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH 4/9] i2c: brcmstb: enable ACK condition
Date: Thu, 14 Jul 2016 13:14:42 -0400
Message-ID: <CAC=U0a1dGVDdThe9F2GTdzf6nRKnwCBQZrVDF-ChRDWm+xxz8g@mail.gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-5-git-send-email-jaedon.shin@gmail.com> <20151130153712.GO1513@katana>
 <974DB801-538F-44AA-9ADD-239E9081077F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35366 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcGNROo (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Jul 2016 13:14:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so9702517wmg.2
        for <linux-i2c@vger.kernel.org>; Thu, 14 Jul 2016 10:14:43 -0700 (PDT)
In-Reply-To: <974DB801-538F-44AA-9ADD-239E9081077F@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org

Jaedon,

Your change looks good to me.  I agree that we do not need the size check.

Kamal

On Thu, Jul 14, 2016 at 12:15 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Hi Kamal,
>
> On Dec 1, 2015, at 12:37 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>> On Wed, Oct 21, 2015 at 11:36:56AM +0900, Jaedon Shin wrote:
>>> Removes the condition of a message with under 32 bytes in length. The
>>> messages that do not require an ACK are I2C_M_IGNORE_NAK flag.
>>
>> Makes me wonder why it worked before? Kamal?
>>
>>>
>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>> ---
>>> drivers/i2c/busses/i2c-brcmstb.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
>>> index 2d7d155029dc..53eb8b0c9bad 100644
>>> --- a/drivers/i2c/busses/i2c-brcmstb.c
>>> +++ b/drivers/i2c/busses/i2c-brcmstb.c
>>> @@ -330,7 +330,7 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
>>>      int no_ack = pmsg->flags & I2C_M_IGNORE_NAK;
>>>
>>>      /* see if the transaction needs to check NACK conditions */
>>> -    if (no_ack || len <= N_DATA_BYTES) {
>
> Could you please explain why have NOACK with smaller transfer size? I don't find any
> reason about NOACK when smaller size, and the driver always operates NOACK by "len <= xfersz".
>
> brcmstb_i2c_xfer(...)
> {
>         int xfersz = brcmstb_i2c_get_xfersz(dev);
>         ...
>         bytes_to_xfer = min(len, xfersz);
>         ...
>         brcmstb_i2c_xfer_bsc_data(..., bytes_to_xfer, ...);
>         ...
>
> I have a plan for v2 that has for BMIPS_GENERIC and this patch with the latest driver.
>
> Thanks!
> --
> Jaedon
>
>>> +    if (no_ack) {
>>>              cmd = (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
>>>                      : CMD_WR_NOACK;
>>>              pi2creg->ctlhi_reg |= BSC_CTLHI_REG_IGNORE_ACK_MASK;
>>> --
>>> 2.6.1
>>>
>
