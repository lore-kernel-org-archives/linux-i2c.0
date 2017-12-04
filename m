From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH] eeprom: at24: Change nvmem stride to 1
Date: Mon, 4 Dec 2017 15:22:07 -0600
Message-ID: <2917d26e-ad37-e118-585c-a479792fbac1@lechnology.com>
References: <1512352481-13613-1-git-send-email-david@lechnology.com>
 <CAMRc=McoGNhQZwdNNwXwKYhjZvLPwUQbbVM4YjgnSnth7fOZTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=McoGNhQZwdNNwXwKYhjZvLPwUQbbVM4YjgnSnth7fOZTw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 12/04/2017 11:44 AM, Bartosz Golaszewski wrote:
> I can't find any documentation on what the stride config option does
> in nvmem, but looking at the code it's only used for alignment checks
> in nvmem core, so this patch should be ok. Still: I'm wondering if it
> shouldn't depend on the size of the eeprom or if we shouldn't make the
> chip you're using a special case.

I am just guessing on the usage too, but I assume it is for memory 
alignment for other types of nvmem devices that only read words (2, 4 or 
8 bytes) at a time. I don't see anything in the at24 code that says we 
can't read any arbitrary starting I2C register, so I don't think we 
should have any problems.

> 
> @David: what is the chip you're using?

Microchip 24FC128

> Is it an at24mac402 by any
> chance? Were you affected by the read problem we fixed recently[1][2]
> in at24?

No and no.

> 
> @Srinivas: any comments on that?
> 
> Thanks,
> Bartosz
> 
> [1] http://patchwork.ozlabs.org/patch/841852/
> [2] http://patchwork.ozlabs.org/patch/841876/
> 
