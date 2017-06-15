From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 4/4] i2c: rcar: check for DMA-capable buffers
Date: Thu, 15 Jun 2017 13:48:17 -0600
Message-ID: <fd55bfd6-b927-fc3f-a50d-9610329d0346@kernel.org>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
 <20170615183039.22925-5-wsa+renesas@sang-engineering.com>
 <CAKocOONjafedew70jMnV9HfNru6mhQV6FXAkoHTL3wzght7+Ww@mail.gmail.com>
 <20170615191743.xdrvigy4h2gqk2kk@ninjato>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615191743.xdrvigy4h2gqk2kk@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Shuah Khan <shuahkhan@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 06/15/2017 01:17 PM, Wolfram Sang wrote:
> Hi,
> 
>>> -       /* Do not use DMA if it's not available or for messages < 8 bytes */
>>> -       if (IS_ERR(chan) || msg->len < 8)
>>> +       if (IS_ERR(chan) || msg->len < RCAR_DMA_THRESHOLD || priv->flags & ID_P_NODMA)
>>
>> Might be more efficient to check for ID_P_NODMA first instead of msg->len.
> 
> I think most of the I2C transfers are smaller (like reading/writing one
> register) than the threshold, so this "should" be more efficient. Plus,
> honestly, I also think this is a micro-optimization which is largely
> depending on the use-case. Can we agree on that?

Makes sense.

> 
>>> -       read = msg->flags & I2C_M_RD;
>>> +       /* we need to check here because we need the 'current' context */
>>> +       if (i2c_check_msg_for_dma(msg, RCAR_DMA_THRESHOLD, NULL) == -EFAULT) {
>>> +               dev_dbg(dev, "skipping DMA for this whole transfer\n");
>>
>> Adding reason for skipping will be helpful.
> 
> The I2C core helper will immediately print before that the buffer is not
> DMA capable. Do you think this together will do?

That is sufficient.

thanks,
-- Shuah

> 
> Thanks for your input,
> 
>    Wolfram
> 
