From: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] i2c: st: add include for pinctrl
Date: Wed, 29 Apr 2015 14:00:35 +0200
Message-ID: <5540C7E3.2060606@st.com>
References: <1429789322-27260-1-git-send-email-wsa@the-dreams.de> <20150423163301.GB4689@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150423163301.GB4689@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 04/23/2015 06:33 PM, Wolfram Sang wrote:
> On Thu, Apr 23, 2015 at 01:42:02PM +0200, Wolfram Sang wrote:
>> The driver uses pinctrl directly and thus should include the appropriate
>> header. Sort the headers while we are here to have a better view what is
>> included and what is not.
>>
>> Reported-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Improved the sorting some more and applied to for-current, thanks!
>

Thanks Wolfram.
