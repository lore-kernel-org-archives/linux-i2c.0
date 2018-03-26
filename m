From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v2 4/6] i2c: i2c-stm32: Add generic DMA API
Date: Mon, 26 Mar 2018 10:20:05 +0200
Message-ID: <43b6d8d7-37e6-1fe8-6a53-0202ab25cfb1@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-5-git-send-email-pierre-yves.mordret@st.com>
 <20180324225138.d5yipagxiouoyqtl@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324225138.d5yipagxiouoyqtl@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Thanks for the heads-up !
My driver supports DMA, but hardly used in the system.

But it's worth to mentioned it.

On 03/24/2018 11:51 PM, Wolfram Sang wrote:
> On Wed, Mar 21, 2018 at 05:48:58PM +0100, Pierre-Yves MORDRET wrote:
>> This patch adds a generic DMA API to implement DMA support for i2c-stm32fx
>> drivers
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> 
> In case you haven't read it so far, there is a new document about I2C &
> DMA -> Documentation/i2c/DMA-considerations
> 
> Just so you know...
> 
