From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH ] i2c: omap: recover from Bus Busy condition
Date: Tue, 25 Oct 2011 18:39:35 +0530
Message-ID: <4EA6B50F.40805@ti.com>
References: <1319439118-3800-1-git-send-email-shubhrajyoti@ti.com> <4EA50F7F.6000400@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EA50F7F.6000400-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 24 October 2011 12:40 PM, Rajeev kumar wrote:
> On 10/24/2011 12:21 PM, Shubhrajyoti D wrote:
>> From: Vikram Pandita<vikram.pandita-l0cyMroinI0@public.gmane.org>
>>
>>      In case a peripheral is holding the DATA bus low, provide a 400Khz
>>      constant clock output using the TEST register.
>>
>>      Also soft reset the I2C controller so that there is no stale state
>>      left in the HW state machine.
>>
>>      A WARN_ON() will be generated when a BB timeout happens.
>>
>> Signed-off-by: Vikram Pandita<vikram.pandita-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-omap.c |   15 +++++++++++++--
>>   1 files changed, 13 insertions(+), 2 deletions(-)
>
>
> Reviewed-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>

Thanks for your review.
>
>
> ~Rajeev
