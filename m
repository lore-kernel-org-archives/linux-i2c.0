From: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH V3 0/2] I2C: Add bus recovery infrastructure
Date: Tue, 17 Apr 2012 15:07:07 +0530
Message-ID: <4F8D39C3.5070306@st.com>
References: <cover.1330669025.git.viresh.kumar@st.com> <4F8D323E.5040908@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F8D323E.5040908-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org" <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, spear-devel <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, "viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ml.lawnick-Mmb7MZpHnFY@public.gmane.org" <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 4/17/2012 2:35 PM, Viresh KUMAR wrote:
> On 3/2/2012 11:53 AM, Viresh KUMAR wrote:
>> This patchset adds i2c bus recovery infrastructure to i2c adapters as specified
>> in the i2c protocol Rev. 03 section 3.16 titled "Bus clear".
>>
>> http://www.nxp.com/documents/user_manual/UM10204.pdf
>>
>> This patch was earlier part of a separate thread:
>> http://www.spinics.net/lists/linux-i2c/msg07267.html
>
> Hi Wolfram,
>
> I know that you have been very busy with other stuff, but Can you
> please apply this patchset if it looks fine to you?
>
> It had been in queue for over 1.5 months now :(
>

Tested By: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>

Rgds
Rajeev
