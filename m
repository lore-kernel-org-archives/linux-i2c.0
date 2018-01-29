From: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Subject: Re: [RFC PATCH 0/2] check I2C device id for pca984x chips
Date: Mon, 29 Jan 2018 18:38:38 +0100
Message-ID: <318dc907-c091-a883-bf0c-346f32a66723@cern.ch>
References: <20180122113657.32094-1-peda@axentia.se>
 <04535e9d-9ba4-2f27-e94c-12d877d26cda@cern.ch>
 <8549b310-ecfe-e60b-c7fc-fab7db2fd2f2@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8549b310-ecfe-e60b-c7fc-fab7db2fd2f2@axentia.se>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 27.01.2018 at 09:37, Peter Rosin wrote:
> On 2018-01-26 17:33, Adrian Fiergolski wrote:
>> Hi Peter,
>>
>> Sorry for the late reply.
> No problem.
>
>> Yes, it's true I have one of the chip. However, my yocto based build system
>> depends on https://github.com/Xilinx/linux-xlnx and it's in version
>> 4.9.0-xilinx-v2017.3.
>> Apparently, there were some bigger changes in i2c core between this
>> version and
>> upstream, thus your patches don't apply.
> I think the core changes fail to apply mostly because of the file renaming
> that has been going on, and that it should be fairly trivial to adapt.
> But I don't know for certain...
>
>> Next week I will try to align only me i2c subdirectory with upstream.
>> Provided it compiles, I will
>> try then to apply and confirm your patches.
> I'm looking forward to feedback, thanks!
>
> Cheers,
> Peter
>
>> Regards,
>> Adrian
>>
>> On 22.01.2018 at 12:36, Peter Rosin wrote:
>>> Hi!
>>>
>>> This series tries to check the I2C device id, but instead of open
>>> coding the check in the pca954x driver, I have a new function in
>>> the core doing the work.
>>>
>>> The code is only compile-tested, hence the RFC, and I would really
>>> like a Tested-by: tag from Adrian who presumably have one of these
>>> chips.
>>>
>>> Also, I'm not sure if I should list all manufacturers that I know
>>> about in the header, or if I should settle for the one that is
>>> actually used and leave the others to be added by whomever needs
>>> them...
>>>
>>> Cheers,
>>> peda
>>>
>>> Peter Rosin (2):
>>>   i2c: add i2c_get_device_id() to get the standard i2c device id
>>>   i2c: mux: pca954x: verify the device id of the pca984x chips
>>>
>>>  drivers/i2c/i2c-core-base.c         | 33 ++++++++++++++++++++++++++++
>>>  drivers/i2c/muxes/i2c-mux-pca954x.c | 43 +++++++++++++++++++++++++++++++++++++
>>>  include/linux/i2c.h                 | 30 ++++++++++++++++++++++++++
>>>  3 files changed, 106 insertions(+)
>>>
Hi Peter,

I have tested your patch with the pca9846 device and I confirm it works.
Moreover, after short debugging, I can confirm that all read ids
(manufacture, part and die) seem to be correct. Moreover, in case of
misconfiguration, the probe function return a proper message and fails
as expected.

Regards,
Adrian
