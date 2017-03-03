From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [PATCH] i2c: brcmstb: Fix START and STOP conditions
Date: Fri, 3 Mar 2017 10:30:24 +0900
Message-ID: <1B672D1D-666A-4F35-A8BB-5CE54C26960D@gmail.com>
References: <20160812055627.34668-1-jaedon.shin@gmail.com>
 <CAKekbesZc1HdWGuaW8eH-qB_p8skWKU+SVT9PvGd1S_=AmdQog@mail.gmail.com>
 <a825350e-a618-a5e8-282b-096d0a187c61@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32792 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdCCBcG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Mar 2017 20:32:06 -0500
Received: by mail-pg0-f65.google.com with SMTP id 16so2472125pga.0
        for <linux-i2c@vger.kernel.org>; Thu, 02 Mar 2017 17:30:28 -0800 (PST)
In-Reply-To: <a825350e-a618-a5e8-282b-096d0a187c61@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org

Hi Kamal, Florian,

> On 3 Mar 2017, at 3:48 AM, Florian Fainelli <f.fainelli@gmail.com> =
wrote:
>=20
> On 03/02/2017 10:42 AM, Kamal Dasu wrote:
>> Jaedon,
>>=20
>> On Fri, Aug 12, 2016 at 1:56 AM, Jaedon Shin <jaedon.shin@gmail.com> =
wrote:
>>> Fixes always repeated START when process multiple bytes with a =
message
>>> in combined transactions.
>>>=20
>>> The BSC has multiple data stroage that send or receive data at once, =
and
>>> it has the RESTART, NOSTART, NOSTOP to the condition flags. The =
problem
>>> is that begin repeated START for all the messages in combined
>>> transaction. If length of a data is over 32bytes, The BSC transmit
>>> repeated START in every 32bytes.
>>>=20
>>=20
>> Can you rephrase the commit message to something  like below ?
>>=20
>> The BSC data buffers to send and receive data are each of size 32 =
bytes
>> or 8 bytes 'xfersz' depending on SoC. The problem observed for all =
the
>> combined message transfer was if length of data transfer was a =
multiple of
>> 'xfersz'  a repeated START was being transmitted by BSC driver. Fixed =
this
>> by appropriately setting START/STOP conditions for such transfers.
>>=20

No problem.

>>> Fixes always repeated START when process multiple bytes with a =
message
>>> in combined transactions.
>>>=20
>>> The BSC has multiple data stroage that send or receive data at once, =
and
>>> it has the RESTART, NOSTART, NOSTOP to the condition flags. The =
problem
>>> is that begin repeated START for all the messages in combined
>>> transaction. If length of a data is over 32bytes, The BSC transmit
>>> repeated START in every 32bytes.
>>=20
>> The changes looks good to me.
>=20
> Do you mind adding:
>=20
> Fixes: dd1aa2524bc5 ("i2c: brcmstb: Add Broadcom settop SoC i2c
> controller driver")
>=20

Add that also.

Thanks,
Jaedon

> so this can be backported to -stable tree as well? Thanks!
>=20
>>=20
>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>> ---
>>> drivers/i2c/busses/i2c-brcmstb.c | 27 +++++++++++++++++++++------
>>> 1 file changed, 21 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/drivers/i2c/busses/i2c-brcmstb.c =
b/drivers/i2c/busses/i2c-brcmstb.c
>>> index 3f5a4d71d3bf..51c5f0bd361d 100644
>>> --- a/drivers/i2c/busses/i2c-brcmstb.c
>>> +++ b/drivers/i2c/busses/i2c-brcmstb.c
>>> @@ -465,6 +465,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter =
*adapter,
>>>        u8 *tmp_buf;
>>>        int len =3D 0;
>>>        int xfersz =3D brcmstb_i2c_get_xfersz(dev);
>>> +       u32 cond, cond_per_msg;
>>>=20
>>>        if (dev->is_suspended)
>>>                return -EBUSY;
>>> @@ -481,10 +482,11 @@ static int brcmstb_i2c_xfer(struct i2c_adapter =
*adapter,
>>>                        pmsg->buf ? pmsg->buf[0] : '0', pmsg->len);
>>>=20
>>>                if (i < (num - 1) && (msgs[i + 1].flags & =
I2C_M_NOSTART))
>>> -                       brcmstb_set_i2c_start_stop(dev, =
~(COND_START_STOP));
>>> +                       cond =3D ~COND_START_STOP;
>>>                else
>>> -                       brcmstb_set_i2c_start_stop(dev,
>>> -                                                  COND_RESTART | =
COND_NOSTOP);
>>> +                       cond =3D COND_RESTART | COND_NOSTOP;
>>> +
>>> +               brcmstb_set_i2c_start_stop(dev, cond);
>>>=20
>>>                /* Send slave address */
>>>                if (!(pmsg->flags & I2C_M_NOSTART)) {
>>> @@ -497,13 +499,24 @@ static int brcmstb_i2c_xfer(struct i2c_adapter =
*adapter,
>>>                        }
>>>                }
>>>=20
>>> +               cond_per_msg =3D cond;
>>> +
>>>                /* Perform data transfer */
>>>                while (len) {
>>>                        bytes_to_xfer =3D min(len, xfersz);
>>>=20
>>> -                       if (len <=3D xfersz && i =3D=3D (num - 1))
>>> -                               brcmstb_set_i2c_start_stop(dev,
>>> -                                                          =
~(COND_START_STOP));
>>> +                       if (len <=3D xfersz) {
>>> +                               if (i =3D=3D (num - 1))
>>> +                                       cond_per_msg =3D =
cond_per_msg &
>>> +                                               ~(COND_RESTART | =
COND_NOSTOP);
>>> +                               else
>>> +                                       cond_per_msg =3D cond;
>>> +                       } else {
>>> +                               cond_per_msg =3D (cond_per_msg & =
~COND_RESTART) |
>>> +                                       COND_NOSTOP;
>>> +                       }
>>> +
>>> +                       brcmstb_set_i2c_start_stop(dev, =
cond_per_msg);
>>>=20
>>>                        rc =3D brcmstb_i2c_xfer_bsc_data(dev, =
tmp_buf,
>>>                                                       bytes_to_xfer, =
pmsg);
>>> @@ -512,6 +525,8 @@ static int brcmstb_i2c_xfer(struct i2c_adapter =
*adapter,
>>>=20
>>>                        len -=3D  bytes_to_xfer;
>>>                        tmp_buf +=3D bytes_to_xfer;
>>> +
>>> +                       cond_per_msg =3D COND_NOSTART | COND_NOSTOP;
>>>                }
>>>        }
>>>=20
>>> --
>>> 2.9.2
>>>=20
>>=20
>> Thanks
>> Kamal
>>=20
>=20
>=20
> --=20
> Florian
