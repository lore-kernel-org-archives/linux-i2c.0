From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v2 5/6] i2c: i2c-stm32f7: Add DMA support
Date: Wed, 4 Apr 2018 10:20:44 +0200
Message-ID: <273ac8d2-6861-c1ad-c2fc-f9c5cc2ac3de@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-6-git-send-email-pierre-yves.mordret@st.com>
 <20180403153925.lg37rezuvs6hefks@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403153925.lg37rezuvs6hefks@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On 04/03/2018 05:39 PM, Wolfram Sang wrote:
> 
>> +#define STM32F7_I2C_DMA_LEN_MIN			0x1
> ...
> 
>> +	if (i2c_dev->dma && f7_msg->count >= STM32F7_I2C_DMA_LEN_MIN) {
> 
> Are you using DMA for every message with a length >= 1? The setup of
> that might be more expensive than the DMA gain, if so.
> 
Well yes. I am in charge of DMA IPs as well. I2C is the only devices that I had
to test DMA outside standard DMA Engine test. Quite convenient.
I believe to stress both I2C and DMA, this value was relevant.
Now I agree this value can be tuned a little bit. I might raise this threshold
in V3.
