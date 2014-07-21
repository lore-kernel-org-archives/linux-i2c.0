From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH] drivers: i2c: i2c-st: Update i2c timings
Date: Mon, 21 Jul 2014 13:05:16 +0200
Message-ID: <53CCF3EC.6030904@st.com>
References: <1400254330-2547-1-git-send-email-maxime.coquelin@st.com> <20140602163103.GJ2654@katana> <538D7A1C.5040409@st.com> <20140603075922.GB2653@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140603075922.GB2653@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 06/03/2014 09:59 AM, Wolfram Sang wrote:
> 
>>> Can you give names here? Would be interesting to know since a few
>>> drivers implement the minimum timings.
>>
>> I don't have the name actually.
>> The request to implement this change came from hw guys.
> 
> Can you ask? It feels better to have changes based on facts.

Sorry for the late reply, but it took time to get the answer.

Apparently the HDMI link of the Toshiba 19AV600U TV is affected by this.
I have no references of other devices (if any).

> 
>>>> This patch adds a 10% margin on all the timings.
>>>
>>> Is there a safety margin or do the devices start to work exactly at 10%?
>>
>> 10% is a safety margin, I don't know what is the limit.
> 
> Which also came from the HW guys? Please ask for details why 10%, too.

This is a safety margin.
Note that the I2C specification only defines minimal timings.

Is it fine for you?
Can I re-send a v2, which:
 - Indicate the Toshiba TV is one of the affected devices in the commit message
 - Indicate the 10% margin is a safety one in the commit message
 - Add a comment above the table indicating these are standard timings + 10% margin.

Regards,
Maxime

> 
> Thanks,
> 
>     Wolfram
> 
