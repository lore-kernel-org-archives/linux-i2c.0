From: Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v8 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 8 Feb 2015 10:10:28 -0800
Message-ID: <54D7A694.4000903@broadcom.com>
References: <rjui@broadcom.com> <1423272507-18459-1-git-send-email-rjui@broadcom.com> <1423272507-18459-3-git-send-email-rjui@broadcom.com> <20150207175039.GB6263@katana> <54D6EF3D.4030302@broadcom.com> <20150208110325.GA2750@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150208110325.GA2750@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Arend van Spriel <arend@broadcom.com>, Kevin Cernekee <cernekee@chromium.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Scott Branden <sbranden@broadcom.com>, Dmitry Torokhov <dtor@google.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On 2/8/2015 3:03 AM, Wolfram Sang wrote:
> 
>>> Is it really a HW limitation? Could the driver later be extended to
>>> continue filling the FIFO if a certain threshold is reached?
>>>
>>
>> Will return -EOPNOTSUPP. This really depends on whether or not we expect
>> one sequence of START + SLV ADDR + DATA + STOP per i2c message. I can
>> later extend the driver to refill/re-drain the FIFO for data size >= 64
>> bytes, if one sequence of SATRT...STOP per message is not a requirement.
> 
> It is important to have the terminology clear here: One transfer can
> consist of multiple messages. The transfer uses START/STOP at the
> beginning/end, the messages within the transfer only REPEATED_START.
> 
Okay. Let me check with our ASIC engineer to see if there's a way to get
the driver extended to support the case when data size is larger than
the FIFO size. From my understanding based on the data sheet I have, I
don't think that can be done with this controller. But if the ASIC
engineers tells me the opposite, I'll add it as a separate patch later.

Thanks,

Ray
