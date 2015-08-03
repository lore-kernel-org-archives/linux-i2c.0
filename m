From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: Xilinx IIC: rework driver
Date: Mon, 3 Aug 2015 09:44:53 +0200
Message-ID: <55BF1BF5.4010809@xilinx.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <55BEFB87.1090909@xilinx.com>
 <CAMdRc4EKRQki+Pm-Et29FyaKARkiCeNGsGYMAQFVyYyvxW2EOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMdRc4EKRQki+Pm-Et29FyaKARkiCeNGsGYMAQFVyYyvxW2EOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Abel <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 08/03/2015 09:30 AM, Robert Abel wrote:
> Hi Michal,
> 
> On Mon, Aug 3, 2015 at 7:26 AM, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
>> I am confused. Do you want to change xilinx tree or mainline? You are
>> using public mailing list that's why all you patches have to be based on
>> the mainline repository not xilinx tree.
> 
> Both. I'm guessing Xilinx will sooner rather than later submit their
> patches from linux-xlnx to mainline any way, judging from their
> history. If that isn't the case, let me know and I'll gladly rebase.
> But right now, I'd like to save all involved some trouble and I'm fine
> with my patches not going in until the next merge window.

yes we are sync with mainline. And make no sense to point to our SoC
tree if you target mainline and ask them for review.

Thanks,
Michal
