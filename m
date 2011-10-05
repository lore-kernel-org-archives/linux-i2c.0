From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c-eg20t: delete 10bit access processing
Date: Wed, 05 Oct 2011 10:59:03 +0900
Message-ID: <4E8BB9E7.9080104@dsn.lapis-semi.com>
References: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com> <1316591509-4433-3-git-send-email-tomoya-linux@dsn.okisemi.com> <20111004205536.GA13323@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111004205536.GA13323-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

(2011/10/05 5:55), Ben Dooks wrote:
> On Wed, Sep 21, 2011 at 04:51:45PM +0900, Tomoya MORINAGA wrote:
>> Linux I2C core doesn't support 10bit access formally.
>> Additionally, we can't test with 10bit mode.
>> This patch deletes the 10bit access processing.
>
> do we want to keep this patch in the series? if not, can
> you post a new series with this dropped from it?
>

Yes, I want to delete 10bit access process.
Or do you want to keep the 10bit code in i2c-eg20t.c ?
If you want, I can obey your opinion.

BTW, we found previous patch series was unsatisfactory.
So, we will post v2 patch series by today.

Thanks,

-- 
tomoya
ROHM Co., Ltd.
