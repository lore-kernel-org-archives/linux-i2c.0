From: Bich HEMON <bich.hemon@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Date: Mon, 11 Mar 2019 09:34:00 +0000
Message-ID: <36e0aec2-8fb8-d584-daee-1b3427f1067e@st.com>
References: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
 <20190309101340.GH1340@kunai> <20190309105021.GI1340@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309105021.GI1340@kunai>
Content-Language: en-US
Content-ID: <CAB849C8628AE3419068CD4964787227@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Pierre Yves MORDRET <pierre-yves.mordret@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 3/9/19 11:50 AM, Wolfram Sang wrote:
> On Sat, Mar 09, 2019 at 11:13:40AM +0100, Wolfram Sang wrote:
>> On Wed, Mar 06, 2019 at 03:12:16PM +0000, Bich HEMON wrote:
>>> From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>>>
>>> It conforms with Reference Manual I2C timing section.
>>>
>>> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>>> Signed-off-by: Bich Hemon <bich.hemon@st.com>
>>
>> Applied to for-current, thanks!
> 
> Do you have a Fixes tag for this?
> 
Hi Wolfram,

Fixes: aeb068c57214858b638d5ee627bb4a831f98771e ("i2c: i2c-stm32f7: add 
driver")

Will you change the commit message or do you want me to resend the patch?

BR,

Bich
