From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V1 1/2] i2c: tegra: fix 10bit address configuration
Date: Thu, 3 May 2012 11:43:14 +0530
Message-ID: <4FA221FA.2030305@nvidia.com>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>	<1335251976-31925-2-git-send-email-ldewangan@nvidia.com> <20120424105815.1d9e7d95@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120424105815.1d9e7d95-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 24 April 2012 02:28 PM, Jean Delvare wrote:
> On Tue, 24 Apr 2012 12:49:35 +0530, Laxman Dewangan wrote:
>> The slave address of device to be configured in packet
>> header as follows:
>>      7 bit address: PacketHeader3[7:1]
>>      10 bit address: PacketHeader3[9:0]
>>
>> Fixing the code to make packet header3 properly.
>>
>> Signed-off-by: Laxman Dewangan<ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>
>>   
> Looks good.
>
> Acked-by: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>
Hi Wolfram Sang,
Can it be apply? This is independent of other change in this series 
which is under discussion/review.
